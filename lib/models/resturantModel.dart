import 'package:flutter/cupertino.dart';

class ResturantModel {
  String resName;
  String resAddress;
  String resPhone;
  String resEmail;

  ResturantModel({
    required this.resName,
    required this.resAddress,
    required this.resEmail,
    required this.resPhone,
  });

  Map<String, dynamic> resturanttoJson() => {
        "Name": resName,
        "Address": resAddress,
        "Email": resEmail,
        "Phone": resPhone,
      };
}

class ResturantMenu {
  String resName;
  String menuItem;
  String delivryTime;
  int price;
  String description;
  String image;

  ResturantMenu(
      {required this.resName,
      required this.image,
      required this.menuItem,
      required this.delivryTime,
      required this.price,
      required this.description});

  Map<String, dynamic> menutoJson() => {
        "restaurantname": resName,
        "name": menuItem,
        "deliverytime": delivryTime,
        "price": price,
        "description": description,
        'image': image
      };
}
