import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';
import 'package:left_over/screens/details/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:left_over/components/discover_small_card.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.35,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 28),
                      Container(
                        width: size.width * 0.858,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/" + product.itemImage),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05, top: size.width * 0.05),
                  child: Hero(
                    tag: "productName",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(product.itemName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: Text(
                    product.subCategory,
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),
                SizedBox(height: 25),
                */
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: size.height / 30,
                    ),
                    /*
                    new RichText(
                      text: new TextSpan(
                        style: new TextStyle(
                          fontSize: 17.0,
                          color: Color(0xffffffff).withOpacity(0.7),
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
                          color: Color(0xffffffff).withOpacity(0.7),
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
                            color: Color(0xffffffff).withOpacity(0.7),
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'Expiration Date: ',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0)),
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
                            color: Color(0xffffffff).withOpacity(0.7),
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'Status: ',
                                style: new TextStyle(
                                    color: Color(0xffffffff).withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0)),
                            new TextSpan(text: '${product.itemCondition}'),
                          ],
                        ),
                      )*/
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 19,
                            mainAxisExtent: 62,
                            mainAxisSpacing: 19),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          DiscoverSmallCard(
                            title: '${product.itemName} ',
                            subtitle: "- ${product.subCategory}",
                            gradientStartColor: lightBlueColor,
                            gradientEndColor: lilacColor,
                          ),
                          DiscoverSmallCard(
                            title: '${product.user.fullName}',
                            subtitle: " ",
                            gradientStartColor: pinkBlockColor,
                            gradientEndColor: lightPinkBlockColor,
                          ),
                          DiscoverSmallCard(
                            title: 'Published at: ',
                            subtitle:
                                '${product.createdAt.split("T")[0].split("-").reversed.join("-")}',
                            gradientStartColor: blueBlockColor,
                            gradientEndColor: lightBlueBlockColor,
                          ),
                          if (product.category == "Consumable")
                            DiscoverSmallCard(
                              title: 'Expiration Date: ',
                              subtitle:
                                  '${product.expirationDate.split("T")[0].split("-").reversed.join("-")}',
                              gradientStartColor: greenBlockColor,
                              gradientEndColor: lightGreenBlockColor,
                            ),
                          if (product.category == "Reusable")
                            DiscoverSmallCard(
                              title: 'Status: ',
                              subtitle: '${product.itemCondition}',
                              gradientStartColor: bExclamationColor,
                              gradientEndColor: greenBlockColor,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
                /* Padding(
                  padding: EdgeInsets.only(left: 28, right: 28, bottom: 80),
                  child: Text(
                    "Meditation is a practice where an individual uses a technique – such as mindfulness, or focusing their mind on a particular object, thought or activity – to train attention and awareness, and achieve a mentally clear and emotionally calm and stable state. Scholars have found meditation difficult to define, as practices vary both between traditions and within them.",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  
                )*/
              ],
            ),
            /*
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 87,
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: blueBlockColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          height: 56,
                          width: size.width * 0.9,
                          child: Center(
                              child: Text(
                            "Request Item",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: darkishBlue,
      title: Text(product.category),
      centerTitle: true,
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () {},
            child: const Text('Request',
                style: TextStyle(color: lightPinkBlockColor))),
      ],
      elevation: 0,
    );
  }
}
