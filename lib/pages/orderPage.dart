import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constraints.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Order')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('order')
                    .snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var snap = snapshot.data!.docs.toList()[index];
                            var price = snap['price'];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.grey.shade400,
                                width: 200,
                                height: 100,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snap['name'],
                                                style:
                                                    kmenuTextStyle.copyWith()),
                                            Text(
                                              'Rs. $price',
                                              style: kpriceTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 140,
                                      child: Image.network(snap['image'],
                                          fit: BoxFit.fill),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
