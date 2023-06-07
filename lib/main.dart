import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF405DE6), // Set the primary color
        primaryColorDark: const Color(
            0xFF5851DB), // Set the dark variant of the primary color
        primaryColorLight: const Color(
            0xFF7C83FD), // Set the light variant of the primary color
        appBarTheme: AppBarTheme(
          backgroundColor:
              const Color(0xFF405DE6), // Set the app bar background color
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
