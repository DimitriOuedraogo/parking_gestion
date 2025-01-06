import 'package:objectbox/objectbox.dart';
import 'package:projet_parking/model/user.dart';

import 'parking.dart';

@Entity()
class Reservation {
  @Id()
  int id = 0;
  String nom;
  String telephone;

  // Durée en minutes
  int duree;

  // Date et heure de début
  final DateTime startDate;

  // Calcul de la date de fin
  late DateTime endDate;

  String typeVehicule;
  String dure;

  String marqueVehicule;
  int timestamps;

  // Relation avec Parking
  final ToOne<Parking> parking = ToOne<Parking>();

  // Relation avec User
  final ToOne<User> user = ToOne<User>();

  // Constructeur
  Reservation({
    required this.nom,
    required this.telephone,
     required this.dure, 
    required this.duree, // Durée en minutes
    required this.typeVehicule,
    required this.endDate,
    required this.marqueVehicule,
    required this.startDate,
    required this.timestamps,
  }) {
    // Calcul de la date de fin en fonction de la durée
    endDate = startDate.add(Duration(
        minutes: duree)); // Utilise la durée en minutes pour calculer la fin
  }
}