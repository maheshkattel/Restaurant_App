import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RestaurantProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;
  List<String> menusHeading = [];

  void addmenus() async {
    QuerySnapshot snap = await _firebaseStorage.collection('menus').get();
    for (var i = 0; i < snap.docs.length; i++) {
      var data = snap.docs.map((e) => e.id.toUpperCase()).toList();
      menusHeading.add(data[i]);
      print(menusHeading);
      notifyListeners();
    }
  }
}

// class Menus extends ChangeNotifier {
//   getData() async {
//     var a = await FirebaseFirestore.instance.collection('menus').get();
//     var b = a.docs.map((e) => e).toList();
//     print(b);
//     notifyListeners();
//   }
// }
