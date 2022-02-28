import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/Screens/details/details_screen.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';
import 'package:http/http.dart' as http;
import 'categorries.dart';
import 'item_card.dart';
import 'package:left_over/components/discover_small_card.dart';

class ItemBody extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<ItemBody> {
  List<Product> products = [];

  var _postJson = [];

  void fetchProduct() async {
    //return http.get(Uri.parse(dotenv.env['API_URL'] + "/item"));

    final response = await http.get(Uri.parse(dotenv.env['API_URL'] + "/item"));

    var jsonData = jsonDecode(response.body) as List;

    setState(() {
      _postJson =
          List<Product>.from(jsonData.map((model) => Product.fromJson(model)))
              .where((item) =>
                  item.category ==
                  CategoriesState.categories[CategoriesState.selectedIndex])
              .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NotificationListener(
        onNotification: (_) {
          fetchProduct();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: topPadding, left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                    ),
                  )
                ],
              ),
            ),
            Categories(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                    itemCount: _postJson.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kDefaultPaddin,
                      crossAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => ItemCard(
                          product: _postJson[index],
                          press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  product: _postJson[index],
                                ),
                              )),
                        )),
              ),
            ),
          ],
        ));
  }
}
