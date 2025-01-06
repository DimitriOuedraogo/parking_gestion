import 'package:flutter/material.dart';
import 'package:projet_parking/model/user.dart';
import 'package:projet_parking/db_helper.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  void loginUser(String email, String password) {
    // Chercher l'utilisateur dans la base de données
    User? user = ObjectBox.getUserByEmail(email);
    if (user != null && user.password == password) {
      _currentUser = user;
      notifyListeners();
    } else {
      throw Exception("Email ou mot de passe incorrect");
    }
  }

  void logoutUser() {
    _currentUser = null;
    notifyListeners();
  }

  void updateUser(User updatedUser) {
    _currentUser = updatedUser;
    // Mettez à jour les données dans la base de données si nécessaire
    ObjectBox.updateUser(updatedUser);
    notifyListeners();
  }
}
