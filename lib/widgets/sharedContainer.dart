import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp/pages/homepage.dart';
import 'package:resturantapp/pages/snacksPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resturantapp/provider/provider.dart';

import '../constraints.dart';

class ItemContainer extends StatelessWidget {
  String name;
  String category;
  String resName;
  String image;
  int price;
  ItemContainer(
      {super.key,
      required this.category,
      required this.name,
      required this.resName,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade300),
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SnacksPage(
                    image: image,
                    category: category,
                    price: price,
                    name: name,
                    description: category,
                    restaurantName: resName,
                  );
                }));
              },
              child: SizedBox(
                  height: 150,
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: kmenuTextStyle),
                  Text(resName, style: kresNameTextStyle),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "\Rs. $price",
                        style: kpriceTextStyle,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text('Grab It'),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
