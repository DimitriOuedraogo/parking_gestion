import 'package:objectbox/objectbox.dart';
import 'package:projet_parking/model/user.dart';

import 'model/parking.dart';
import 'model/reservation.dart';
import 'objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';


class ObjectBox {

  static late Store store;

  ObjectBox._create(store){
    ObjectBox.store = store;
  }
   // Add any additional setup code, e.g. build queries.

 static Future<ObjectBox> create() async {
   final docsDir = await getApplicationDocumentsDirectory();
   // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
   final store = await openStore(directory: p.join(docsDir.path, "db-projetParking"));
   
   return ObjectBox._create(store);
 }

  static Future<void> saveParking(Parking parking) async {
     final box = ObjectBox.store.box<Parking>();
     final id = box.put(parking);
     print(id);
  }

  static Parking getParking(int id)  {
    final box = ObjectBox.store.box<Parking>();
    Parking parking = box.get(id)!;
    return parking;
  }

  static List<Parking> getAllParking(){
    final query = ObjectBox.store.box<Parking>();
    final List<Parking> parkings = query.getAll();
    return parkings;
  }
      
/////////////////////  Crud  Reservation  /////////////////////////////////////////////////

 static Future<void> saveReservation(Reservation reservation) async {
     final box = ObjectBox.store.box<Reservation>();
     final id = box.put(reservation);
     print(id);
  }

  static Reservation getReservation(int id)  {
    final box = ObjectBox.store.box<Reservation>();
    Reservation reservation = box.get(id)!;
    return reservation;
  }

  
  static List<Reservation> getAllReservation(){
    final query = ObjectBox.store.box<Reservation>();
    final List<Reservation> reservations = query.getAll();
    return reservations;
  }

   // Méthode pour sauvegarder un utilisateur
  static Future<void> saveUser(User user) async {
    final box = ObjectBox.store.box<User>();
    final id = box.put(user);
    print('Utilisateur enregistré avec ID: $id');
  }

  // Méthode pour obtenir un utilisateur par ID
  static User getUser(int id) {
    final box = ObjectBox.store.box<User>();
    User user = box.get(id)!;
    return user;
  }

  // Méthode pour obtenir tous les utilisateurs
  static List<User> getAllUsers() {
    final query = ObjectBox.store.box<User>();
    final List<User> users = query.getAll();
    return users;
  }

  // Méthode pour obtenir un utilisateur par email
static User? getUserByEmail(String email) {
  final box = ObjectBox.store.box<User>();

  // Crée une requête pour rechercher un utilisateur avec l'email correspondant
  final query = box.query(User_.email.equals(email)).build();

  // Exécute la requête
  final user = query.findFirst();

  // Libère les ressources utilisées par la requête
  query.close();

  return user; // Retourne l'utilisateur ou null s'il n'existe pas
}


}