import 'package:flutter_utsmobile/auth_services.dart';
import 'package:flutter_utsmobile/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _service = AuthService();

  @override
  Widget build(BuildContext context) {
     void register() async {
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user =
          await _service.registerWithEmailPassword(email, password, context);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Register berhasil'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Register gagal'),
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
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 24),
          children: [
            const Text(
              'Register',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah punya akun ? ',
                style: TextStyle(
                        color: Colors.white),
                ),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                }, child: const Text('Masuk'))
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                register();
              },
              child:const Text(
                'Daftar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}