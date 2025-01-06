import 'package:flutter/material.dart';
import 'package:projet_parking/WelcomeScreen.dart';
import 'package:projet_parking/model/UserProvider.dart';
import 'package:provider/provider.dart';

import 'db_helper.dart';

late ObjectBox objectbox;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projet Parking',
      theme: ThemeData(
        fontFamily: 'inter',
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}