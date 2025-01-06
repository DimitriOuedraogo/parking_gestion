import 'package:objectbox/objectbox.dart';
import 'package:projet_parking/model/reservation.dart';

@Entity()
class User {
   @Id()
  int id = 0;
  String name;
  String email;
  String password;
  
   // Relation avec Reservation
  final reservations = ToMany<Reservation>();


  User({
    required this.name,
    required this.email,
    required this.password,
  });
}
