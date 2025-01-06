import 'package:flutter/material.dart';

import 'RegScreen.dart';
import 'loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
     
     
  const WelcomeScreen({Key? key});

   

  @override
  Widget build(BuildContext context) {
    Color firstColor = Colors.greenAccent.shade700;
    return Scaffold(
      body:  Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xFFFFFFFF),
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/unnamed.png'),
                width: 150, // Largeur souhaitée du logo
                height: 150, // Hauteur souhaitée du logo
              ),
             const SizedBox(
                height: 15, // Espace entre le logo et le texte
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Park',
                      
                      style: TextStyle(
                        fontSize: 30,
                          fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: 'Mobile',
                      style: TextStyle(
                        fontSize: 30,
                          fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  loginScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(

                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                    child: Text(
                      'CONNEXION',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                    child: Text(
                      'INSCRIPTION',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
