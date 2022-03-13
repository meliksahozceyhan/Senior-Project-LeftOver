import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';
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
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.35,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(width: 28),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: GridView(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 19,
                            mainAxisExtent: 62,
                            mainAxisSpacing: 19),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          DiscoverSmallCard(
                            title: '${product.category} ',
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: darkishBlue,
      title: Text(product.itemName),
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
