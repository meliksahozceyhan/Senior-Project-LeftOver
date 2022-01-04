import 'package:flutter/material.dart';
import 'package:left_over/constants_copy.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/Models/Product.dart';
import 'package:google_fonts/google_fonts.dart';

import 'categorries.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  List<Product> categorizedItems = products
      .where((item) =>
          item.category ==
          CategoriesState.categories[CategoriesState.selectedIndex])
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "Products",
            style: GoogleFonts.comfortaa(fontSize: 45),
          ),
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: categorizedItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: categorizedItems[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (context) => DetailsScreen(
                              //   product: products[index],
                              // ),
                              )),
                    )),
          ),
        ),
      ],
    );
  }
}
