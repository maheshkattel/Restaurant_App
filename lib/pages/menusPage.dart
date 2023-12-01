import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/constraints.dart';
import 'package:resturantapp/pages/snacksPage.dart';

class MenusPage extends StatelessWidget {
  String category;
  MenusPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.toUpperCase())),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('menus')
                  .doc(category.toLowerCase())
                  .collection(category.toLowerCase())
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                return snapshot.hasData
                    ? Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data?.docs.toList()[index];
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return SnacksPage(
                                            image: data['image'],
                                            price: data['price'],
                                            category: category,
                                            name: data['name'],
                                            description: data['description'],
                                            restaurantName:
                                                data['restaurantname']);
                                      },
                                    ));
                                  },
                                  child: Container(
                                    height: 400,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      color: Colors.grey,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          child: Image.network(
                                            data?['image'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Rs.${data!['price']}",
                                                style: kpriceTextStyle,
                                              ),
                                              const Spacer(),
                                              const Text('Buy')
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                        ),
                      )
                    : Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
