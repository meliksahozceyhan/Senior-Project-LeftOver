import 'package:flutter/material.dart';

class User {
  String id, createdAt, updatedAt, email, fullName, password, dateOfBirth, city, address;
         
  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.fullName,
    this.password,
    this.dateOfBirth,
    this.city,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      email: json['email'],
      fullName: json['fullName'],
      password: json['password'],
      dateOfBirth: json['dateOfBirth'],
      city: json['city'],
      address: json['address'],
    );
  }

}