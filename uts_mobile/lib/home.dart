import 'package:flutter_utsmobile/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Home',
            style: TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: const Text('Log Out'))
        ]),
      ),
    );
  }
}