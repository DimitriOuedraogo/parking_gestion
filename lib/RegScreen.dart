import 'package:flutter/material.dart';
import 'package:projet_parking/db_helper.dart';
import 'package:projet_parking/model/user.dart';
import 'package:projet_parking/objectbox.g.dart';

import 'loginScreen.dart';

class RegScreen extends StatefulWidget {

  // Ajoute un constructeur pour initialiser 'store'
  RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  late Box<User> userBox; // Déclare la boîte pour User
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
   
  }


  void registerUser(BuildContext context) async {

  // Vérifie si le formulaire est valide
  if (!formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veuillez corriger les erreurs dans le formulaire.'),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  // Vérifie si les mots de passe correspondent
  if (passwordController.text != confirmPasswordController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Les mots de passe ne correspondent pas.'),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  try {
    // Crée un nouvel utilisateur
    final newUser = User(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    // Sauvegarde l'utilisateur dans la base de données
      ObjectBox.saveUser(newUser);
    // Affiche un message de succès
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Inscription réussie!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Navigue vers l'écran de connexion
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => loginScreen(),
      ),
    );
  } catch (error) {
    // Gestion des erreurs
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur lors de l\'inscription : $error'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color:Colors.green,
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Inscrivez-Vous !',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Nom',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez entrer le nom";
                            }
                            return null;
                          },
                        ),

                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir votre adresse e-mail.';
                            }
                            if (!RegExp(
                                    r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                                .hasMatch(value)) {
                              return 'Veuillez saisir une adresse e-mail valide.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Mot de Passe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir votre mot de passe.';
                            }
                            if (value.length < 6) {
                              return 'Le mot de passe doit comporter au moins 6 caractères.';
                            }
                            return null;
                          },
                        ),
                        TextField(
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Confirmer Mot de Passe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: () {
                            registerUser(context);
                          },
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                             color: Colors.green,
                            ),
                            child: const Center(
                              child: Text(
                                'INSCRIPTION',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Avez-vous déjà un compte? ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => loginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Connectez-vous !",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
