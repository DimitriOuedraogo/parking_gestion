import 'package:flutter/material.dart';
import 'package:projet_parking/loginScreen.dart';
import 'package:projet_parking/model/user.dart';
import 'package:projet_parking/services.dart';

import 'Mes_Reservations.dart';
import 'acceuil.dart';
import 'add_parking.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String userName = widget.user.name;

  late String userEmail = widget.user.email;

  final List<Widget> pages = [Accueil(), MesReservations(), Services()];

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _deconnexion() async {
    // Naviguer vers l'écran de connexion
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              loginScreen()), // Remplace "loginScreen()" par ton écran de connexion
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // ici j'ai afficher l'heure a droite du appBar
        actions: [
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1), (_) {
              return DateTime.now();
            }),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox(); // Affiche rien si les données ne sont pas prêtes
              }
              final now = snapshot.data as DateTime;
              final formattedTime =
                  "${now.hour.toString().padLeft(2, '0')} h :${now.minute.toString().padLeft(2, '0')}";
              return Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Center(
                  child: Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            padding: const EdgeInsets.only(
                left: 30,
                bottom: 20,
                right: 30), // Ajout du padding droit pour équilibrer
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Faso',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: 'Parking',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height: 20), // Espacement avant le champ de recherche
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Rechercher un lieu",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Espacement entre le champ et l'icône
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.indigo, // Couleur de fond pour l'icône
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          // Action de recherche
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      //Ici c'est le menu lateral j'utilise le widget drawer pour le faire
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffB81736),
                    Color(0xff281537),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.person,
                          size: 40, color: Color(0xffB81736)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Profil utilisateur'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nom complet: $userName'),
                                  SizedBox(height: 8),
                                  Text('Adresse e-mail: $userEmail'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Fermer'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bienvenue !",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Expanded(child: 
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        this.userEmail, // Ton email d'utilisateur
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),          
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(Icons.logout, color: Colors.white),
                            onPressed: () {
                              _deconnexion(); // Appeler la méthode de déconnexion
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                  ),
                 
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.local_parking, color: Colors.red),
                    title: const Text("Ajouter Votre parking"),
                    subtitle: const Text("Faites connaître votre parking"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddParking()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.account_box, color: Colors.blue),
                    title: const Text("Profil"),
                    onTap: () {
                      // Action pour Profil
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.green),
                    title: const Text("Paramètres"),
                    onTap: () {
                      // Action pour Paramètres
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.orange),
                    title: const Text("Aide"),
                    onTap: () {
                      // Action pour Aide
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.close, color: Colors.grey),
                    title: const Text("Quitter"),
                    onTap: () {
                      // Action pour Quitter
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          selectedIndex: pageIndex, // Utiliser pageIndex ici
          onDestinationSelected: (int index) {
            setState(() {
              pageIndex =
                  index; // Mettre à jour le pageIndex lors de la sélection
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home, color: Colors.white),
              label: "Accueil",
            ),
            NavigationDestination(
              icon: Icon(Icons.event, color: Colors.white),
              label: "Réservations",
            ),
            NavigationDestination(
              icon: Icon(Icons.storefront, color: Colors.white),
              label: "Nos services",
            ),
          ],
        ),
      ),
    );
  }
}

// Méthode pour créer des boutons stylisés
Widget _buildModernButton(
  BuildContext context, {
  required String text,
  required VoidCallback onPressed,
  required Color backgroundColor,
  required IconData icon,
}) {
  return SizedBox(
    width: double.infinity, // S'assurer que le bouton occupe toute la largeur
    child: ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor,
        // Couleur du texte
        padding: EdgeInsets.symmetric(vertical: 14.0),
        // Padding vertical pour augmenter la taille
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Bords arrondis
        ),
        elevation: 5.0, // Ombre légère pour un effet moderne
      ),
      icon: Icon(icon, size: 20),
      label: Text(text,
          style: TextStyle(fontSize: 18)), // Texte avec une taille plus grande
    ),
  );
}
