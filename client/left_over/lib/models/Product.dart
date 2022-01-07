import 'package:flutter/material.dart';

import 'User.dart';

class Product {
  String id, createdAt, updatedAt, itemName, category, subCategory, itemImage, requestStatus,
        itemCondition, expirationDate;

  User user;

  Product({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.itemName,
    this.category,
    this.subCategory,
    this.itemImage,
    this.requestStatus,
    this.itemCondition,
    this.expirationDate,
    this.user,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      itemName: json['itemName'],
      category: json['category'],
      subCategory: json['subCategory'],
      itemImage: json['itemImage'],
      requestStatus: json['requestStatus'],
      expirationDate: json['expirationDate'],
      itemCondition: json['itemCondition'],
      user: User.fromJson(json['user']),
    );
  }
  
}

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
