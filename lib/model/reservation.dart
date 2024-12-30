import 'package:objectbox/objectbox.dart';
import 'parking.dart';

@Entity()
class Reservation {
  @Id()
  int id = 0;
  String nom;
  String telephone;
  String duree;
  String typeVehicule;
  String placeImmatriculation;
  String marqueVehicule;
  int timestamps;

  // Relation avec Parking
  final ToOne<Parking> parking = ToOne<Parking>();

  Reservation({
    required this.nom,
    required this.telephone,
    required this.duree,
    required this.typeVehicule,
    required this.placeImmatriculation,
    required this.marqueVehicule,
    required this.timestamps,
  });
}
