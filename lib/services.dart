import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final List<Map<String, String>> imageDetails = [
    {
      'image': 'assets/parking1.jpg',
      'title': 'Location de Parking',
      'description': 'Vous pouvez mettre en location votre parking',
    },
    {
      'image': 'assets/parking2.jpg',
      'title': 'Vente de Parking',
      'description': 'Vous pouvez mettre en vente votre parking',
    },
    {
      'image': 'assets/parking3.jpg',
      'title': 'Construction de Parking',
      'description': 'Nous construisons des parkings sur mesure',
    },
    {
      'image': 'assets/parking4.jpg',
      'title': 'Regulation de Parking',
      'description': 'Rendez vos parkings legaux ',
    },
    {
      'image': 'assets/parking5.jpg',
      'title': 'Regulation de Parking',
      'description': 'Automatiser votre Parking',
    },
    {
      'image': 'assets/parking6.jpg',
      'title': 'Standarisez vos parkings',
      'description': 'Nous standarisons vos parkings ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Carrousel stylisé
            Expanded(
              flex: 2,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: 250.0, // Hauteur spécifique pour le carrousel
                  autoPlayInterval: const Duration(seconds: 5),
                ),
                items: imageDetails.map((imageDetail) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(imageDetail['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Fond semi-transparent en bas de l'image
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Titre
                                    Text(
                                      imageDetail['title']!,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    // Description
                                    Text(
                                      imageDetail['description']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
