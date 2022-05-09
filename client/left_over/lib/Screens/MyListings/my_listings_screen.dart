import 'package:flutter/material.dart';
import 'package:left_over/Screens/MyListings/components/my_listings_item_body.dart';
import 'package:left_over/constants.dart';

class MyListingsItemScreen extends StatefulWidget {
  const MyListingsItemScreen({Key key}) : super(key: key);

  @override
  _MyListingItemScreenState createState() => _MyListingItemScreenState();
}

class _MyListingItemScreenState extends State<MyListingsItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: MyListingsItemBody()
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: darkishBlue,
      title: Text("My Listings"),
      centerTitle: true,
      elevation: 0,
    );
  }
}
