// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resturantapp/pages/homepage.dart';
import 'package:resturantapp/pages/restaurantLogin.dart';
import 'package:resturantapp/pages/signupPage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                    textAlign: TextAlign.center,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'example@gmail.com')),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    controller: _passController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '********************')),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                elevation: 6,
                color: Colors.grey.shade700,
                onPressed: () async {
                  try {
                    String email = _emailController.text.trim();
                    String password = _passController.text.trim();
                    UserCredential user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    }));
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, wordSpacing: 2),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ));
                },
                child: const Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, wordSpacing: 2),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantLoginPage(),
                      ));
                },
                child: const Center(
                  child: Text(
                    'Resturant Login',
                    style: TextStyle(fontSize: 18, wordSpacing: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
