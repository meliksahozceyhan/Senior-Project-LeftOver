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
          right: 130,
          top: 70,
        ),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height / 15,
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: bPrimaryColor,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Item Name: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    TextSpan(text: '${product.itemName}'),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Owner: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    TextSpan(text: '${product.user.fullName}'),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Published At: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    TextSpan(
                        text:
                            '${product.createdAt.split("T")[0].split("-").reversed.join("-")}'),
                  ],
                ),
              ),
              if (product.category == "Consumable")
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Expiration Date: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      TextSpan(
                          text:
                              '${product.expirationDate.split("T")[0].split("-").reversed.join("-")}'),
                    ],
                  ),
                )
              else
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Status: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19.0)),
                      TextSpan(text: '${product.itemCondition}'),
                    ],
                  ),
                )
            ],
          ),
        ));
  }
}
