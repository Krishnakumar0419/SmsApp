import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smsapp/HomeScreen.dart';
import 'package:smsapp/RegistrationPage.dart';
import 'package:smsapp/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE3B3),
        title: const Center(
          child: Text(
            'Login Page',
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Please enter your registered email-Id.',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Please enter your password.',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                User? user = await authService.signIn(email, password);
                if (user != null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (Route<dynamic> route) => false);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Email not Verified.'),
                            content: Text(
                                'Please Verify your email by clicking on the verification link sent to you.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'))
                            ],
                          ));
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 6,
                backgroundColor: const Color(0xFFFFC872),
              ),
              child: const Text('Login'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Not registered yet? Click to go to Register page!',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
