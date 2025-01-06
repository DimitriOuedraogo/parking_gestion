import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:projet_parking/fonction.dart';

import 'ReservationPage.dart';
import 'db_helper.dart';
import 'model/parking.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<Parking> parkings = [];
  Color main_color = const Color(0xFFBDBDBD);
  double latitude = 0;
  double longitude = 0;

  void getParkings() {
    parkings = ObjectBox.getAllParking();
    setState(() {});
  }

  Future<void> setPosition() async {
    Position position = await determinatePosition();
    longitude = position.longitude;
    latitude = position.latitude;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getParkings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: parkings.length == 0
              ? const Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Aucun parking enregistrés",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    Image(
                      image: AssetImage("assets/liste.jpg"),
                      width: 400,
                      height: 250,
                    )
                  ],
                ))
              : ListView.builder(
                  itemCount: parkings.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image Section
                          parkings[index].imagePath == ""
                              ? Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: main_color,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Pas d'image",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.file(
                                    File(parkings[index].imagePath),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title and Time
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      parkings[index].nom,
                                      style: GoogleFonts.lobster(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.update_outlined,
                                          size: 20,
                                          color: Colors.grey.shade700,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          GetTimeAgo.parse(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  parkings[index].timestamps)),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // Ville et Quartier
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: Color(0xFFBDBDBD)),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${parkings[index].ville}, ${parkings[index].quartier}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 5),
                                // Available Places
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Place disponible: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(Icons.two_wheeler,
                                        color: Colors.grey),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${parkings[index].placeMoto}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.directions_car,
                                        color: Colors.grey),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${parkings[index].placeVehicule}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Description:",
                                  style: GoogleFonts.baloo2(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // Description
                                Text(
                                  parkings[index].desc,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    height: 1.5,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Action Buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () async {
                                        final checker =
                                            await MapLauncher.isMapAvailable(
                                                MapType.google);
                                        if (checker != null && checker) {
                                          await MapLauncher.showMarker(
                                            mapType: MapType.google,
                                            coords: Coords(
                                                parkings[index].latitude,
                                                parkings[index].longitude),
                                            title: parkings[index].nom,
                                            description: parkings[index].desc,
                                          );
                                        }
                                      },
                                      icon: Icon(Icons.map_rounded,
                                          color: Color(0xFFBDBDBD)),
                                      label: Text(
                                        "Voir l'adresse",
                                        style: TextStyle(color: Color(0xFFBDBDBD)),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReservationPage(
                                                      parking: parkings[index],
                                                    )));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFBDBDBD),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 20),
                                      ),
                                      child: const Text(
                                        "Réserver",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
    ]));
  }
}
