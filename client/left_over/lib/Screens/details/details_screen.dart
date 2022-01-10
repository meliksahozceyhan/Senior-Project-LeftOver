import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';
import 'package:left_over/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: bgreen,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: bExclamationColor,
      elevation: 0,
    );
  }
}
