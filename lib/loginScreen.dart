import 'package:flutter/material.dart';
import 'package:projet_parking/RegScreen.dart';
import 'package:projet_parking/db_helper.dart';
import 'package:projet_parking/model/UserProvider.dart';
import 'package:projet_parking/model/user.dart';
import 'package:provider/provider.dart';

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

void loginUser(BuildContext context, String email, String password) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    userProvider.loginUser(email, password);

    // Navigation vers la page d'accueil
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 2),
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
              color: Colors.green,
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
                      // ListView
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
                        const SizedBox(height: 70),
                        Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:Colors.green ,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              print("connexion");
                              loginUser(context,emailController.text,passwordController.text);
                            },
                            child: Container(
                              height: 55,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:Colors.green,
                              ),
                              child: const Center(
                                child: Text(
                                  'CONNEXION',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
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
