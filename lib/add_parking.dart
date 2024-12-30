import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_parking/fonction.dart';

import 'db_helper.dart';
import 'model/parking.dart';

class AddParking extends StatefulWidget {
  const AddParking({super.key});

  @override
  _AddParkingState createState() => _AddParkingState();
}

class _AddParkingState extends State<AddParking> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();
  String imagePath = "";
  bool imageExist = false;
  XFile? image;
  TextEditingController placeNameController = TextEditingController();
  TextEditingController placeVilleController = TextEditingController();
  TextEditingController placeQuartierController = TextEditingController();
  TextEditingController placeCategoryController = TextEditingController();
  TextEditingController placeDescriptionController = TextEditingController();
  TextEditingController placeNoteController = TextEditingController();
  TextEditingController placeVehiculeController = TextEditingController();
  TextEditingController placeMotoController = TextEditingController();
   double latitude = 0.0;
  double longitude = 0.0;


  final mySnack = SnackBar(
    content: Container(
      color: Colors.white,
      child: const Row(
        children: [
          Icon(
            Icons.check,
            size: 30,
            color: Colors.green,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "lieu enregistré",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            "Ajouter Parking",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          width: 200,
                          height: 180,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: imageExist
                              ? ClipRRect(
                                  child: Image.file(
                                    File(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final image_ = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {
                                      if (image_ != null) {
                                        image = image_;
                                        imagePath = image!.path;
                                        imageExist = true;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            TextFormField(
                              controller: placeNameController,
                              decoration: InputDecoration(
                                label: const Text("Nom"),
                                filled: true,
                                fillColor:
                                    Colors.grey[200], // Fond doux pour le champ
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 1.5,
                                      color: Colors
                                          .blueAccent), // Bordure accentuée
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                prefixIcon: const Icon(
                                  Icons.business,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veuillez entrer le nom";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: placeVilleController,
                              decoration: InputDecoration(
                                label: const Text("Pays"),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 1.5,
                                      color: Colors
                                          .blueAccent), // Bordure accentuée
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                prefixIcon: const Icon(
                                  Icons.location_city,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veuillez entrer le pays";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: placeQuartierController,
                              decoration: InputDecoration(
                                label: const Text("Ville"),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 1.5,
                                      color: Colors
                                          .blueAccent), // Bordure accentuée
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                prefixIcon: const Icon(
                                  Icons.home,
                                  color: Colors.black, // Icône accentuée
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veuillez entrer la ville";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nombre de Place",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: placeMotoController,
                                  decoration: InputDecoration(
                                    labelText: "Engin à 2 roues",
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          width: 1.5, color: Colors.blueAccent),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    prefixIcon: const Icon(
                                      Icons.two_wheeler,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Veuillez entrer un nombre";
                                    }
                                    if (int.tryParse(value) == null) {
                                      return "Veuillez entrer un entier valide";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: TextFormField(
                                  controller: placeVehiculeController,
                                  decoration: InputDecoration(
                                    labelText: "Engin à 4 roues",
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          width: 1.5, color: Colors.blueAccent),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    prefixIcon: const Icon(
                                      Icons.directions_car,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Veuillez entrer un nombre";
                                    }
                                    if (int.tryParse(value) == null) {
                                      return "Veuillez entrer un entier valide";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      Position position = await determinatePosition();
                      final data = await getCountryAndCityName(
                          position.latitude, position.longitude);

                      setState(() {
                        placeVilleController.text = data[0];
                        placeQuartierController.text = data[1];
                        latitude = position.latitude;
                        longitude = position.longitude;
                      });
                    },
                    icon: const Icon(Icons.place),
                    label: const Text('obtenir la position',
                        style: TextStyle( fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 105, vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: placeDescriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText:
                            'Décrivez votre parking (heure ouverture | fermeture)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState!.validate()) {
                        final parking = Parking(
                            timestamps: DateTime.now().millisecondsSinceEpoch,
                            imagePath: imagePath,
                            nom: placeNameController.text,
                            ville: placeVilleController.text,
                            quartier: placeQuartierController.text,
                            placeMoto: int.parse(placeMotoController.text),
                            placeVehicule:int.parse(placeVehiculeController.text),
                            desc: placeDescriptionController.text,
                            latitude: latitude,
                            longitude: longitude );
                            
                        ObjectBox.saveParking(parking);
                        ScaffoldMessenger.of(context).showSnackBar(mySnack);
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text(
                      'Enregistrer',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Bouton moderne
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
