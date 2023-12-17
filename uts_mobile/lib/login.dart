import 'package:flutter/material.dart';
import 'package:flutter_utsmobile/auth_services.dart';
import 'package:flutter_utsmobile/home.dart';
import 'package:flutter_utsmobile/home_page.dart';
import 'package:flutter_utsmobile/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_utsmobile/welcome_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _service = AuthService();

  @override
  Widget build(BuildContext context) {
    void login() async {
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user =
          await _service.loginWithEmailPassword(email, password, context);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login gagal'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red, Colors.black],
          ),
        ),
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
            children: [
              Image.asset(
                'images/boy.png', // Replace with your food delivery logo asset
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 24),
              const Text(
                'Food Delivery',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Use your desired button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Belum punya akun ? ',
                    style: TextStyle(
                        color: Colors.white), // Set the text color to white
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: const Text('Daftar'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
