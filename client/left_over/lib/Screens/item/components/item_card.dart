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
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              //padding: EdgeInsets.all(3.0),
              height: size.height * 0.5,
              width: size.width,
              //decoration: BoxDecoration(
              //  color: bgreen,
              //  borderRadius: BorderRadius.circular(16),
              //),
              child: Hero(
                tag: "${product.id}",
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/images/" + product.itemImage,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            //padding: const EdgeInsets.symmetric(vertical: 10),
            child: Align(
              child: Text(
                product.itemName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: lightBlueBlockColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 5),
            child: Align(
              child: Text(
                product.subCategory,
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
