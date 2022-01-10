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
        padding: const EdgeInsets.only(
          right: 150,
          top: 70,
        ),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height / 15,
              ),
              new RichText(
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 17.0,
                    color: bPrimaryColor,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Item Name: ',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    new TextSpan(text: '${product.itemName}'),
                  ],
                ),
              ),
              new RichText(
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Owner: ',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    new TextSpan(text: '${product.user.fullName}'),
                  ],
                ),
              ),
              new RichText(
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Published At: ',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    new TextSpan(
                        text:
                            '${product.createdAt.split("T")[0].split("-").reversed.join("-")}'),
                  ],
                ),
              ),
              if (product.category == "Consumable")
                new RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                          text: 'Expiration Date: ',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      new TextSpan(
                          text:
                              '${product.expirationDate.split("T")[0].split("-").reversed.join("-")}'),
                    ],
                  ),
                )
              else
                new RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                          text: 'Status: ',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19.0)),
                      new TextSpan(text: '${product.itemCondition}'),
                    ],
                  ),
                )
            ],
          ),
        ));
  }
}
