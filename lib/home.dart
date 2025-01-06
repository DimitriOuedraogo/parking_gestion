import 'package:flutter/material.dart';
import 'package:projet_parking/loginScreen.dart';
import 'package:projet_parking/model/UserProvider.dart';
import 'package:projet_parking/services.dart';
import 'package:provider/provider.dart';

import 'Mes_Reservations.dart';
import 'acceuil.dart';
import 'add_parking.dart';

class HomePage extends StatefulWidget {
  

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;
    final String userName = user?.name ?? "nom inconnu";
    final userEmail = user?.email ?? "Email inconnu";



    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
           color: Colors.green
          ),
        ),

     
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
                        text: 'Park',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Mobile',
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
                        color: Colors.white, // Couleur de fond pour l'icône
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.grey),
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
                 color:Colors.green,
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
                          size: 40, color:Colors.green,),
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
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userEmail, // Ton email d'utilisateur
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
                  )),
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
                    leading: const Icon(Icons.storefront, color: Colors.green),
                    title: const Text("Nos Services"),
                    onTap: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (content)=> Services()));
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
      
     floatingActionButton: FloatingActionButton(
    onPressed: () {
     
    },
    backgroundColor: Colors.green,
    child: const Icon(Icons.place),
    tooltip: 'Trouver le parking le plus proche',
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
bottomNavigationBar: BottomAppBar(
  shape: const CircularNotchedRectangle(),
  notchMargin: 8.0,
  color: Colors.white,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Icône Accueil avec label
      Expanded(
        child: InkWell(
          onTap: () {
            setState(() {
              pageIndex = 0;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home,
                color: pageIndex == 0 ? Colors.green : Colors.grey,
                size: 28,
              ),
              Text(
                "Accueil",
                style: TextStyle(
                  color: pageIndex == 0 ? Colors.green : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
   
      // Espace pour le bouton flottant
      const SizedBox(width: 40),
      // Icône Services avec label
        // Icône Réservations avec label
      Expanded(
        child: InkWell(
          onTap: () {
            setState(() {
              pageIndex = 1;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event,
                color: pageIndex == 1 ? Colors.green : Colors.grey,
                size: 28,
              ),
              Text(
                "Réservations",
                style: TextStyle(
                  color: pageIndex == 1 ? Colors.green : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),

);
  }
}