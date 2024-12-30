import 'package:objectbox/objectbox.dart';

import 'reservation.dart';

@Entity()
class Parking {
  @Id()
  int id = 0;
  String nom;
  String ville;
  String quartier;
  int placeMoto;
  int placeVehicule;
  String desc;
  String imagePath;
  int timestamps;
  double latitude;
  double longitude;
  // Relation inverse avec Reservation
  @Backlink('parking')
  final ToMany<Reservation> reservations = ToMany<Reservation>();

  Parking({
    required this.nom,
    required this.ville,
    required this.quartier,
    required this.placeMoto,
    required this.placeVehicule,
    required this.desc,
    required this.imagePath,
    required this.timestamps,
    required this.longitude,
  required this.latitude
  });
}
