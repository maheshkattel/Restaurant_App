import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp/constraints.dart';
import 'package:resturantapp/pages/cartPage.dart';
import 'package:resturantapp/pages/menusPage.dart';
import 'package:resturantapp/widgets/sharedContainer.dart';

import '../provider/provider.dart';
import 'orderPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<RestaurantProvider>(context, listen: false).addmenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade400,
          title: const Text(
            'Restaurant App',
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ));
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        drawer: buildDrawer(context),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              itemCount:
                  Provider.of<RestaurantProvider>(context).menusHeading.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          Provider.of<RestaurantProvider>(context)
                              .menusHeading[index],
                          style: kheaderNameTextStyle,
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (buildcontext) {
                                  return MenusPage(
                                      category: Provider.of<RestaurantProvider>(
                                              context,
                                              listen: false)
                                          .menusHeading[index]
                                          .toLowerCase());
                                },
                              ));
                            },
                            child: const Text('See All'))
                      ],
                    ),
                    SizedBox(
                        height: 262,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('menus')
                              .doc(Provider.of<RestaurantProvider>(context)
                                  .menusHeading[index]
                                  .toLowerCase())
                              .collection(
                                  Provider.of<RestaurantProvider>(context)
                                      .menusHeading[index]
                                      .toLowerCase())
                              .snapshots(),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, atIndex) {
                                      var data =
                                          snapshot.data?.docs.toList()[atIndex];
                                      return ItemContainer(
                                        category:
                                            Provider.of<RestaurantProvider>(
                                                    context)
                                                .menusHeading[index],
                                        image: data?['image'],
                                        name: data?['name'],
                                        resName: data?['restaurantname'],
                                        price: data?['price'],
                                      );
                                    },
                                  )
                                : const Center(
                                    child: CircularProgressIndicator());
                          },
                        )),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width / 1.3,
        backgroundColor: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 40,
                  child: Text('Logo'),
                ),
              ),
              const Text(
                'Menus',
                style: TextStyle(fontSize: 22),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: Provider.of<RestaurantProvider>(context)
                      .menusHeading
                      .length,
                  itemBuilder: (context, index) {
                    return dividerListView(
                        Provider.of<RestaurantProvider>(context)
                            .menusHeading[index],
                        Provider.of<RestaurantProvider>(context)
                            .menusHeading[index]);
                  },
                ),
              ),
              const Divider(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(),
                            ));
                      },
                      child: const Text(
                        "My Cart",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderPage()));
                      },
                      child: const Text(
                        'Order',
                        style: TextStyle(fontSize: 19),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Padding dividerListView(String menuName, String category) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return MenusPage(category: category);
            },
          ));
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
          child: Text(menuName, style: const TextStyle(fontSize: 25)),
        ),
      ),
    );
  }
}
