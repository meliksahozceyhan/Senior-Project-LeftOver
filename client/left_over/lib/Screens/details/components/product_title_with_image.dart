import 'package:flutter/material.dart';
import 'package:left_over/models/Product.dart';

import '../../../constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kDefaultPaddin, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.itemName,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            product.category,
            style: TextStyle(
                color: bPrimaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          Text(
            product.subCategory,
            style: TextStyle(
                color: bPrimaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: size.width * 0.1),
                  padding: EdgeInsets.only(
                    top: size.height * 0.10,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  width: size.width * 0.25),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                  child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                child: Hero(
                    tag: "${product.id}",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(45), // Image radius
                        child: Image.asset(
                          "assets/images/" + product.itemImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )

                    //Image.asset(
                    //"assets/images/" + product.itemImage,
                    //fit: BoxFit.cover,
                    //size: Size.fromRadius(48),
                    //),

                    ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
