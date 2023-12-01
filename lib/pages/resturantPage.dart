import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/models/resturantModel.dart';
import 'package:resturantapp/pages/addItemsPageAdmin.dart';

class ResturantPage extends StatefulWidget {
  const ResturantPage({super.key});

  @override
  State<ResturantPage> createState() => _ResturantPageState();
}

class _ResturantPageState extends State<ResturantPage> {
  var resturantDocid;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Name'),
                  SizedBox(
                    width: 200,
                    child: TextField(controller: _nameController),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('Address'),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _addressController,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('Contact'),
                  SizedBox(
                    width: 200,
                    child: TextField(controller: _contactController),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('email'),
                  SizedBox(
                    width: 200,
                    child: TextField(controller: _emailController),
                  )
                ],
              ),
              const Row(
                children: [
                  Text('Password'),
                  SizedBox(
                    width: 200,
                    child: TextField(),
                  )
                ],
              ),
              MaterialButton(
                onPressed: () async {
                  if (_nameController.text.trim() != "" &&
                      _addressController.text.trim() != "" &&
                      _emailController.text.trim() != "" &&
                      _contactController.text.trim() != "") {
                    try {
                      await _firebaseFirestore
                          .collection('ResturantDetails')
                          .add(ResturantModel(
                                  resName: _nameController.text,
                                  resAddress: _addressController.text,
                                  resEmail: _emailController.text,
                                  resPhone: _contactController.text)
                              .resturanttoJson())
                          .then((value) => resturantDocid = value.id);
                    } catch (e) {
                      print(e.toString());
                    }
                  } else {
                    print('Null Value');
                  }
                },
                color: Colors.teal,
                child: const Text('Signup'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
