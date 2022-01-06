import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(3.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: bgreen,
              ),
              child: Hero(
                tag: "${product.id}",
                child: Image.asset("assets/images/" + product.itemImage,
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              product.itemName,
              style: TextStyle(
                  color: bDarkBlue, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              product.category,
              style: TextStyle(color: bDarkBlue),
            ),
          ),
        ],
      ),
    );
  }
}
