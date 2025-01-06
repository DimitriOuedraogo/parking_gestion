import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projet_parking/QrPage.dart';
import 'package:projet_parking/model/parking.dart';
import 'package:projet_parking/model/reservation.dart';
// Importez votre page QR si nécessaire

class PayementReservation extends StatefulWidget {
  final Reservation reservation;
  
  const PayementReservation({Key? key, required this.reservation}) : super(key: key);

  @override
  _PaymentReservationState createState() => _PaymentReservationState();
}

class _PaymentReservationState extends State<PayementReservation> {
  late TextEditingController otpController;
  late int? totalPrice;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    totalPrice = calculateTotalPrice(widget.reservation.typeVehicule,widget.reservation.dure);
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
   // Accédez à l'objet Parking via la relation ToOne

    Parking? parking = widget.reservation.parking.target;  // Ou utilisez la méthode appropriée pour accéder à l'objet Parking
  return Scaffold(
    backgroundColor: Colors.white,
     appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
             color: Colors.green,
            ),
          ),
          title: const Text(
            "Facture",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          centerTitle: true,
        ),
    body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête élégant
         Center(
  child: Column(
    children: [
       Image.file(
                                    File( parking?.imagePath ?? 'Pas d\'image'),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
      // Affichage dynamique de l'image du parking
    
      SizedBox(height: 10),
      // Affichage dynamique du nom du parking
      Text(
         
        parking?.nom ?? "Pas de Nom", // Utilisez le nom du parking à partir de la réservation
        style: const TextStyle(    
          fontSize: 28,
          fontWeight: FontWeight.bold,
         color: Colors.green, // Couleur personnalisée
        ),
      ),
    ],
  ),
),

            SizedBox(height: 10),

            // Carte des informations de réservation
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Détails de Réservation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                       
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    const SizedBox(height: 10),
                    _buildDetailRow(
                      Icons.person,
                      'Nom et Prénom',
                      widget.reservation.nom,
                    ),
                    _buildDetailRow(
                      Icons.phone,
                      'Numéro de Téléphone',
                      widget.reservation.telephone,
                    ),
                    _buildDetailRow(
                      Icons.car_rental,
                      'Type de Véhicule',
                      widget.reservation.typeVehicule,
                    ),
                    _buildDetailRow(
                      Icons.branding_watermark,
                      'Marque du Véhicule',
                      widget.reservation.marqueVehicule,
                    ),
                    _buildDetailRow(
                      Icons.timelapse,
                      'Durée de Réservation',
                       widget.reservation.dure,
                    ),
                  
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Champ OTP avec design amélioré
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Code de Validation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                         color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: otpController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.green),
                        labelText: 'Entrez le code OTP',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide( color: Colors.green, width: 2),
                        ),
                        errorText: otpController.text.isNotEmpty &&
                                otpController.text.length < 8
                            ? 'Le code doit contenir 8 chiffres'
                            : null,
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Prix total et bouton de paiement
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
            
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Montant Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$totalPrice FCFA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => QrPage(reservation:  widget.reservation)));
                      },
                      icon: const Icon(Icons.payment),
                      label: Text('Procéder au Paiement'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Nouvelle méthode pour construire les lignes de détails avec des icônes
Widget _buildDetailRow(IconData icon, String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon,  color: Colors.green, size: 24),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
  

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  // Fonction pour calculer le prix total en fonction de la durée de réservation
  int? calculateTotalPrice(String vehiculeType,String? dureeReservation) {
    if (vehiculeType == "2 roues"){
switch (dureeReservation) {
      case '1jour':
        return 600;
      case '3jours':
        return 600 * 3;
      case '1semaine':
        return 600 * 7;
      case '3 semaines':
        return 600 * 21;
      case '1 mois':
        return 600 * 30;
      case '3 mois':
        return 600 * 90;
      case '6 mois':
        return 600 * 180;
      case '1 annee':
        return 600 * 365;
      default:
        return 0; // Prix total par défaut si aucune durée n'est sélectionnée
    }
    } else if (vehiculeType == "4 roues"){
      switch (dureeReservation) {
      case '1jour':
        return 1200;
      case '3jours':
        return 1200 * 3;
      case '1semaine':
        return 1200 * 7;
      case '3 semaines':
        return 1200 * 21;
      case '1 mois':
        return 1200 * 30;
      case '3 mois':
        return 1200 * 90;
      case '6 mois':
        return 1200 * 180;
      case '1 annee':
        return 1200 * 365;
      default:
        return 0; // Prix total par défaut si aucune durée n'est sélectionnée
    }
    }
    
  }
}