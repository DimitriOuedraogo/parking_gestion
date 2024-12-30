import 'package:flutter/material.dart';
import 'package:projet_parking/PayementReservation.dart';
import 'package:projet_parking/model/parking.dart';

import 'db_helper.dart';
import 'model/reservation.dart';

class ReservationPage extends StatefulWidget {
 final  Parking parking;
  const ReservationPage({super.key,required this.parking });

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final List<String> placeTypes = ['2 roues', '4 roues'];

  final List<String> duree = [
    '1jour',
    '3jours',
    '1semaine',
    '3 semaines',
    '1 mois',
    '3 mois',
    '6 mois',
    '1 annee'
  ];
  String? _selectedPlaceType = '2 roues';
  String? _selectedDurer = '1jour';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Consolidez vos contrôleurs
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController vehicleMarqueController = TextEditingController();
  final TextEditingController vehiculeImmatriculationController = TextEditingController();
  final TextEditingController dureeReservationController = TextEditingController();

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
            "Reservation  enregistrée",
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
            "Reserver une place ",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          centerTitle: true,
        ),
        body: Form(
           key: formKey,

          child:
           Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: ListView(
            children: [
              Text(
                'Vous reservez une place au parking ${widget.parking.nom} :',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 25.0),
              // Nom et Prénom
              TextFormField(
                controller: placeNameController,
                decoration: InputDecoration(
                  labelText: 'Nom et prénom',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer le nom et prenom";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              // Numéro de Téléphone
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Numéro de téléphone',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer le numéro de téléphone";
                  }
                  if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
                    return "Veuillez entrer un numéro de téléphone valide (entre 8 et 15 chiffres)";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              // Type de place
              DropdownButtonFormField<String>(
                validator: (value){
                                  if(value == null){
                                    return "veuillez choisir un type de Vehicule";
                                  }
                                  return null;
                                },

                decoration: InputDecoration(
                  labelText: "Type de Vehicule",
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                value: _selectedPlaceType,
                items: [
                  for (var i in placeTypes )
                  DropdownMenuItem(value: i,child: Text(i),)
                ],
                onChanged: (value) {
                  vehicleTypeController.text = value!;
                 
                },
              ),
              const SizedBox(height: 15.0),
              // Type de véhicule
              TextFormField(
                controller: vehicleMarqueController,
                decoration: InputDecoration(
                  labelText: "Marque du Vehicule",
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer la marque";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),

              // Plaque d'immatriculation

              TextFormField(
                controller: vehiculeImmatriculationController,
                decoration: InputDecoration(
                  labelText: 'Plaque d\'immatriculation',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer une plaque d'immatriculation";
                  }
                 
                  return null;
                },
              ),

              const SizedBox(height: 15.0),
              // Durée de la réservation
              DropdownButtonFormField<String>(
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner une durée';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Durée de la réservation',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                value: _selectedDurer,
                items: [
                  for(var i in duree)
                  DropdownMenuItem(value: i,child: Text(i))
                ],
                onChanged: (value) {
                dureeReservationController.text = value!;
                },
              
              ),

              const SizedBox(height: 30.0),
              // Bouton Réserver
              ElevatedButton(
                onPressed: () {
                  // Masquer le clavier
                FocusManager.instance.primaryFocus?.unfocus();

                // Créer et sauvegarder la réservation
                final reservation = _createAndSaveReservation(widget.parking);

                // Naviguer vers la page suivante si la réservation est valide
                if (reservation != null) {
                  // Afficher le SnackBar de confirmation
                  ScaffoldMessenger.of(context).showSnackBar(mySnack);

                  // Naviguer vers la page suivante et passer la réservation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayementReservation(reservation: reservation),
                    ),
                  );
                }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50), // Vert vif
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Center(
                  child: Text(
                    'Réserver',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        ),
    );
  
  
  }

  @override
  void dispose() {
    // N'oubliez pas de libérer les contrôleurs
    placeNameController.dispose();
    phoneNumberController.dispose();
    vehicleTypeController.dispose();
    vehicleMarqueController.dispose();
    vehiculeImmatriculationController.dispose();
    dureeReservationController.dispose();
    super.dispose();
  }

 // Méthode qui crée, enregistre et retourne la réservation
Reservation? _createAndSaveReservation(Parking parking) {
  if (formKey.currentState!.validate()) {
    // Créer la réservation
    final reservation = Reservation(
      timestamps: DateTime.now().millisecondsSinceEpoch,
      nom: placeNameController.text,
      telephone: phoneNumberController.text,
      typeVehicule: vehicleTypeController.text,
      marqueVehicule: vehicleMarqueController.text,
      duree: dureeReservationController.text,
      placeImmatriculation: vehiculeImmatriculationController.text,
    );

    // Lier la réservation au parking
    reservation.parking.target = parking;

    // Enregistrer la réservation
    ObjectBox.saveReservation(reservation);

    return reservation;
  }
  return null;
}

}
