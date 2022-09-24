import 'package:flutter/material.dart';

import 'views/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:together/services/firestore.dart';
import 'views/login/login.dart';

bool? loggedIn;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Auth auth = Auth();

  loggedIn = auth.user.currentUser != null;
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.josefinSansTextTheme(),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: loggedIn! ? Home() : LoginView(),
    );
  }
}
