import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smsapp/ConfirmationPage.dart';
import 'package:smsapp/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('                     '),
            Icon(Icons.message),
            Text(' Sms App'),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Register for best experience.',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Please Enter your Email',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Please Enter your Password',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    // Try to register the user
                    User? user = await authService.register(email, password);

                    if (user != null) {
                      print("User registered successfully: ${user.email}");

                      // After successful registration, navigate to ConfirmationPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConfirmationPage(),
                        ),
                      );
                    } else {
                      print("Registration failed.");
                      // Optionally show an error dialog
                    }
                  },
                  child: const Text('Register')),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Text(
                'Already Registered? Click to go to Login Page!',
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: Text(
              'By clicking you agree to my terms and conditions.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
