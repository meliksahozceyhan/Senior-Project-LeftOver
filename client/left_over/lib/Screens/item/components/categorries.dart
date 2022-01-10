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
      padding: const EdgeInsets.only(left: 0.0, top: 10,bottom: 15),
      //padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        MyNotification().dispatch(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: selectedIndex == index ? bDarkBlue : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? bgreen : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
