// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resturantapp/pages/addItemsPageAdmin.dart';
import 'package:resturantapp/pages/homepage.dart';
import 'package:resturantapp/pages/restaurantLogin.dart';

class RestaurantSignUpPage extends StatelessWidget {
  RestaurantSignUpPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                      textAlign: TextAlign.center,
                      controller: _nameController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name of Restaurant')),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                      textAlign: TextAlign.center,
                      controller: _contactController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Contact of Restaurant')),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                      textAlign: TextAlign.center,
                      controller: _addressController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Address of Restaurant')),
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
                          .createUserWithEmailAndPassword(
                              email: email, password: password);

                      await FirebaseFirestore.instance
                          .collection('restaurantdetails')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(<String, dynamic>{
                        'address': _addressController.text.trim(),
                        'name': _nameController.text.trim(),
                        'email': _emailController.text.trim(),
                        'phone': _contactController.text.trim(),
                        'uid': FirebaseAuth.instance.currentUser!.uid
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddItemsPage();
                      }));
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: const Text(
                    'Restaurant Sign Up',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, wordSpacing: 2),
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
                      'Restaurant Login',
                      style: TextStyle(fontSize: 18, wordSpacing: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
