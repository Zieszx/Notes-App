// NAME: Ieskandar Zulqarnain Bin Ghazali
// MATRIC NO: A20EC0046
// COURSE: SECJ3623-01(MOBILE APPLICATION PROGRAMMING)

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
      title: 'MAP Exam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LoginScreen(),
      home: const LoginScreen(),
      // home: const EditScreen(),
    );
  }
}
