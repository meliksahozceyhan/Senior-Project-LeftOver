import 'package:flutter/material.dart';
import 'package:left_over/constants_copy.dart';
import 'package:left_over/Models/Product.dart';

import '../../../constants.dart';

class SearchCard extends StatelessWidget {
  final Product product;
  final Function press;
  const SearchCard({
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
              padding: EdgeInsets.all(0.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Hero(
                tag: "${product.id}",
                //child: Image.asset(product.image, fit: BoxFit.cover),
                child: Image.asset("assets/images/frenchToast.png",
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              product.name,
              //textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
