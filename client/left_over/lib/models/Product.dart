import 'package:flutter/material.dart';

class Product {
  final String image, category, name, sharer, releaseDate;
  String receiver ="",status = "";
  final int id;
  Product({
    this.id,
    this.image,
    this.category,
    this.name,
    this.sharer,
    this.releaseDate,
    this.receiver,
    this.status,
  });
}

List<Product> products = [
  Product(
      id: 1,
      category: "Consumable",
      name: "bread",
      sharer: "yagmur",
      releaseDate: "03.01.2022",
      receiver: "",
      status: "fresh",
      image: "assets/images/leftover_logo_black.png",
    ),
  Product(
      id: 2,
      category: "Consumable",
      name: "cake",
      sharer: "didem",
      releaseDate: "03.01.2022",
      receiver: "",
      status: "fresh",
      image: "assets/images/leftover_logo_black.png",
    ),
    Product(
      id: 3,
      category: "Reusable",
      name: "comic book",
      sharer: "furkan",
      releaseDate: "01.01.2022",
      receiver: "",
      status: "",
      image: "assets/images/leftover_logo_black.png",
    ),
    Product(
      id: 4,
      category: "Consumable",
      name: "donut",
      sharer: "meliksah",
      releaseDate: "02.01.2022",
      receiver: "",
      status: "",
      image: "assets/images/leftover_logo_black.png",
    ),
    Product(
      id: 5,
      category: "Reusable",
      name: "dress",
      sharer: "didem",
      releaseDate: "01.01.2022",
      receiver: "",
      status: "",
      image: "assets/images/leftover_logo_black.png",
    ),
    Product(
      id: 6,
      category: "Reusable",
      name: "calculator",
      sharer: "yagmur",
      receiver: "",
      status: "",
      image: "assets/images/leftover_logo_black.png",
    ),
    Product(
      id: 7,
      category: "Reusable",
      name: "spoon",
      sharer: "furkan",
      receiver: "",
      status: "",
      image: "assets/images/leftover_logo_black.png",
    ),
  
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
