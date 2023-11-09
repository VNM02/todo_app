import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './screens/home.dart';
import './auth/authscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



// Import the generated file


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,usersnapshot){
        if(usersnapshot.hasData)
          {
            return const Home();
          }
        else
          {
            return const AuthScreen();
          }
      }),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:Colors.orange,
        textTheme: GoogleFonts.emilysCandyTextTheme(),
        scaffoldBackgroundColor: Colors.orange[100],
      ),
    );
  }
}
