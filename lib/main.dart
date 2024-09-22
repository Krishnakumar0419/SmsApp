import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smsapp/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SMS APP',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
