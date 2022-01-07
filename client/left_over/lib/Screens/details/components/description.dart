import 'package:flutter/material.dart';
import 'package:left_over/models/Product.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 2),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height / 15,
              ),
              Text(
                "Item Name: ${product.itemName}",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.left,
              ),
              Text(
                "OWNER: ${product.user.fullName}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Published At: ${product.createdAt.split("T")[0].split("-").reversed.join("-")}",
                style: TextStyle(fontSize: 15),
              ),
              if (product.category == "Consumable")
                Text(
                  "Expiration Date: ${product.expirationDate.split("T")[0].split("-").reversed.join("-")}",
                  style: TextStyle(fontSize: 15),
                )
              else
                Text("Status: ${product.itemCondition}",
                    style: TextStyle(fontSize: 15)),
            ],
          ),
        ));
  }
}
