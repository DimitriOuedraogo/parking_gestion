
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

Future<bool> checkInternetConnexion() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

Future<dynamic> sendGetRequest(String url) async {

    final response = await http.get(
        Uri.parse(url)
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<dynamic> sendPostRequest(Object donneesAEnvoyer,String url) async {

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(donneesAEnvoyer),
     );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

Future<Map<String,dynamic>> sendPostRequestAdvanced(String bodyJson, String url) async {
  // verifier l'état de la connexion
  bool res = await checkInternetConnexion();
  if (!res) {
    return {
      "status": false,
      "message": "Impossible de se connecter à internet",
      "data": ""
    };
  }
  // utiliser un try catch
  try {
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyJson,
    );
    return {"status": true, "message": "données recues", "data": response.body};

  } catch (e) {
    return {
      "status": false,
      "message": "une erreur est survenue veuillez réessayer",
      "data": ""
    };
  }
}



Future<Position> determinatePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

Future<List<String>> getCountryAndCityName(double lat, double long) async {
  print(lat);
  print(long);

  // URL de l'API avec les coordonnées
  String url = "https://api.opencagedata.com/geocode/v1/json?q=$lat,$long&key=03fdfadc1a5c48459baa5c12993a39d0";
  
  // Envoi de la requête GET et récupération de la réponse
  dynamic response = await sendGetRequest(url);

  // Vérification de la présence des données avant d'y accéder
  String city = response["results"] != null && response["results"].isNotEmpty
      ? response["results"][0]["components"]["country"] ?? "Ville non trouvée"
      : "Aucune donnée de ville";
  
  String road = response["results"] != null && response["results"].isNotEmpty
      ? response["results"][0]["components"]["city"] ?? "Route non trouvée"
      : "Aucune donnée de route";

  // Retourner la liste avec la ville et la route (si disponibles)
  return [city, road];
}
