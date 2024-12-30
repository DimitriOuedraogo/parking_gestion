import 'package:flutter/material.dart';
import 'package:projet_parking/RegScreen.dart';
import 'package:projet_parking/db_helper.dart';
import 'package:projet_parking/model/user.dart';

import 'home.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible =
      false; // Variable pour gérer la visibilité du mot de passe
  GlobalKey<FormState> formeKey = GlobalKey<FormState>();

void loginUser(BuildContext context) {


// Permet de verifier que les champs du formulaire sont valides
  if (!formeKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veuillez corriger les erreurs dans le formulaire.'),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  // Vérifier si l'utilisateur existe dans la base de données
  User? user = ObjectBox.getUserByEmail(emailController.text);
  if (user == null) {
    // Aucun utilisateur trouvé
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Aucun utilisateur trouvé avec cet email."),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  // Vérifier le mot de passe
  if (user.password != passwordController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Mot de passe incorrect."),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  // Connexion réussie
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Connexion réussie !"),
      duration: Duration(seconds: 2),
    ),
  );

  // Naviguer vers la page d'accueil
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(
        user: user,
      ),
    ),
  );
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
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Connectez Vous !',
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
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Form(
                    key: formeKey,
                    child: ListView(
                      // Remplacer Column par ListView
                      children: [
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
                                color: Color(0xffB81736),
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
                          obscureText:
                              !_isPasswordVisible, // On cache le texte si _isPasswordVisible est false
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible =
                                      !_isPasswordVisible; // Inverser la visibilité
                                });
                              },
                            ),
                            label: const Text(
                              'Mot de Passe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
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
                        const SizedBox(height: 70),
                        Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffB81736),
                                Color(0xff281537),
                              ],
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              print("connexion");
                              loginUser(context);
                            },
                            child: Container(
                              height: 55,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffB81736),
                                    Color(0xff281537),
                                  ],
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'CONNEXION',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 20), // Espace entre le bouton et le texte
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Pas de Compte? ",
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
                                    builder: (context) => RegScreen()
                                  ),
                                );
                              },
                              child: const Text(
                                "Inscrivez-vous !",
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
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
