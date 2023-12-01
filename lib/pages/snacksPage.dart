import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/constraints.dart';

import '../widgets/sharedContainer.dart';

class SnacksPage extends StatefulWidget {
  String name;
  String category;
  String restaurantName;
  String description;
  int price;
  String image;
  SnacksPage(
      {super.key,
      required this.image,
      required this.price,
      required this.category,
      required this.name,
      required this.description,
      required this.restaurantName});

  @override
  State<SnacksPage> createState() => _SnacksPageState();
}

class _SnacksPageState extends State<SnacksPage> {
  int cart = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.toUpperCase())),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.image), fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Text(
                          widget.name,
                          style: kheaderNameTextStyle.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (cart > 1) cart = cart - 1;
                                setState(() {});
                              },
                              icon: const Icon(CupertinoIcons.minus_circled)),
                          Text(cart.toString()),
                          IconButton(
                              onPressed: () {
                                if (cart < 9) cart++;

                                setState(() {});
                              },
                              icon: const Icon(CupertinoIcons.add_circled))
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs.${widget.price}",
                        style: kpriceTextStyle,
                      ),
                      InkWell(
                        onTap: () async {
                          print(FirebaseAuth.instance.currentUser?.uid);
                          try {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('cart')
                                .add((<String, dynamic>{
                                  'name': widget.name,
                                  'price': widget.price,
                                  'image': widget.image,
                                  'quantity': cart
                                }));
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.yellow),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Add to Cart'),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text("from ${widget.restaurantName}",
                      style: kresNameTextStyle.copyWith(
                        fontSize: 19,
                      )),
                  Text(widget.description, style: kdescriptionTextStyle),
                  Text('Related Products', style: kheaderNameTextStyle),
                  SizedBox(
                    height: 265,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('menus')
                          .doc(widget.category.toLowerCase())
                          .collection(widget.category.toLowerCase())
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data?.docs.toList();
                                  return ItemContainer(
                                    name: data?[index]['name'],
                                    category: widget.category,
                                    price: data?[index]['price'],
                                    resName: data?[index]['restaurantname'],
                                    image: data?[index]['image'],
                                  );
                                },
                              )
                            : CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
