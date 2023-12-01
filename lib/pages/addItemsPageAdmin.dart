import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/constraints.dart';
import 'package:resturantapp/models/resturantModel.dart';

class AddItemsPage extends StatefulWidget {
  @override
  State<AddItemsPage> createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _menunameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _deltimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  var documentPath = "";
  var snap =
      FirebaseFirestore.instance.collection('restaurantdetails').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text('name'),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _menunameController,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Text('Price'),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _priceController,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Text('Image'),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _imageController,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Text('Delivery Time'),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _deltimeController,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Text('Description'),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _descriptionController,
                  ),
                )
              ],
            ),
            Center(
              child: MaterialButton(
                onPressed: () async {
                  var snap = await _firestore
                      .collection('restaurantdetails')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .get();
                  var data = snap.docs[0];
                  print(data['name']);
                  await _firestore
                      .collection('menus')
                      .doc(_menunameController.text.trim())
                      .collection(_menunameController.text.trim())
                      .add(ResturantMenu(
                        resName: data['name'],
                        image: _imageController.text.trim(),
                        delivryTime: _deltimeController.text.trim(),
                        menuItem: _menunameController.text.trim(),
                        price: int.parse(_priceController.text.trim()),
                        description: _descriptionController.text.trim(),
                      ).menutoJson());
                },
                color: Colors.yellow,
                child: const Text('Add Items to Menu'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
