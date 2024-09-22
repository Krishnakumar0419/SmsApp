import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smsapp/LoginPage.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA2D5AB),
        title: const Center(
          child: Text('Verify Email'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'We have sent you a verification email. Please open it to verify your account.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'If you haven\'t received the email, press the button below to resend it.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              User? user = FirebaseAuth.instance.currentUser;

              if (user != null && !user.emailVerified) {
                await user.sendEmailVerification();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Verification Email Sent'),
                    content: const Text(
                      'A verification link has been sent to your email. Please check your inbox and verify your account.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Dismiss dialog
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                      'Unable to send verification email. Either the email is already verified or there was an issue.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Dismiss dialog
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: const Text('Resend Verification Email'),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
