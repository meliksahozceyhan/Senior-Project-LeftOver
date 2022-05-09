import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/MyNotification.dart';

import '../../../constants.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  static List<String> categories = ["Consumable", "Reusable"];
  // By default our first item will be selected
  static int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 20),
      //padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: categoryHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        MyNotification().dispatch(context);
      },
      child: Padding(
          padding: EdgeInsets.only(left: size.width * 0.02),
          child: Container(
            height: size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: selectedIndex == index ? selectedBlue : darkishBlue,
              boxShadow: selectedIndex == index
                  ? [
                      BoxShadow(
                          color: selectedBlue.withOpacity(0.3),
                          offset: const Offset(0, 4),
                          blurRadius: 20),
                    ]
                  : [],
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.01),
                child: Text(
                  categories[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
