import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/Screens/Search/search_screen.dart';
import 'package:left_over/Screens/details/details_screen.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'categorries.dart';
import 'item_card.dart';

class ItemBody extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<ItemBody> {
  List<Product> products = [];

  var _postJson = [];

  void fetchProduct() async {
    //return http.get(Uri.parse(dotenv.env['API_URL'] + "/item"));

    Map<String, String> headers = new Map<String, String>();
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    headers["Authorization"] = "Bearer " + token;

    final response = await http.get(Uri.parse(dotenv.env['API_URL'] + "/item"),
        headers: headers);

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
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                    ),
                  ]),
            ),
            Categories(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                    itemCount: _postJson.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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

Widget buildFloatingSearchBar(BuildContext context) {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return FloatingSearchBar(
    hint: 'Search...',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 0.0 : -1.0,
    openAxisAlignment: 0.0,
    //width: isPortrait ? 600 : 500,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Colors.accents.map((color) {
              return Container(height: 112, color: color);
            }).toList(),
          ),
        ),
      );
    },
  );
}
