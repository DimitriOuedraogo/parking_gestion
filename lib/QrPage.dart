import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projet_parking/home.dart';
import 'package:projet_parking/model/reservation.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatelessWidget {
  final Reservation reservation;

  const QrPage({Key? key, required this.reservation}) : super(key: key);

  // Méthode pour générer un code aléatoire (par exemple, un code à 6 chiffres)
  String generateRandomCode() {
    Random random = Random();
    int code = random.nextInt(1000000); // Génère un nombre aléatoire entre 0 et 999999
    return code.toString().padLeft(6, '0');  // Formate le code pour avoir 6 chiffres
  }

  @override
  Widget build(BuildContext context) {
  String randomCode = generateRandomCode();  // Génère un code aléatoire
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
               color: Colors.green,
            ),
          ),
          title: const Text(
            "QR Code ",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          centerTitle: true,
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Détails de la réservation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),

              // Card for reservation details
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildReservationInfo('Nom et prénom', reservation.nom),
                      _buildReservationInfo('Numéro de téléphone', reservation.telephone),
                       _buildReservationInfo('Durée de réservation', reservation.dure),
                      _buildReservationInfo('Type de véhicule', reservation.typeVehicule),
                      _buildReservationInfo('Marque de place', reservation.marqueVehicule),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // QR Code Section
              Column(
                children: [
                  const Text(
                    'Votre QR Code',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                       child:QrImageView(
                      data: randomCode,  // Le code aléatoire à encoder dans le QR
                      size: 200.0,  // Taille du QR Code
                      backgroundColor: Colors.white,  // Fond du QR Code
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  const Text(
                    'Scannez ce QR Code à l\'entrée',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Button for navigation or actions
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Retour',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReservationInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
