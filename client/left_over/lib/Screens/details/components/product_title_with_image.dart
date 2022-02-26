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
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddinT),
          Text(product.subCategory,
              style: TextStyle(
                color: Color(0xffffffff).withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: 18,
              )),

          
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
