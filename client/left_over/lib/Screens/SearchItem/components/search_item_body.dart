import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Screens/details/details_screen.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:left_over/models/User.dart';
import 'package:left_over/socket_service.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item_card.dart';

class SearchItemBody extends StatefulWidget {
  const SearchItemBody({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<SearchItemBody> {
  List<Product> products = [];
  var getItemName = "";
  var _postJson = [];

  void fetchProduct() async {

    Map<String, String> headers = new Map<String, String>();
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    headers["Authorization"] = "Bearer " + token;

    final response = await http.get(Uri.parse(dotenv.env['API_URL'] + "/item/searchItems?searchValue=" + getItemName),
        headers: headers);

    var jsonData = jsonDecode(response.body) as List;

    if(this.mounted) {
      setState(() {
      _postJson =
          List<Product>.from(jsonData.map((model) => Product.fromJson(model))).toList();
      });
    }

    if(_postJson.isEmpty) {
      Fluttertoast.showToast(
        msg: "Could not find any product!",          
        fontSize: 20,
        backgroundColor: Colors.red,
        gravity: ToastGravity.CENTER
      );
    }
    
  }

  @override
  void initState() {
    fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NotificationListener(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: topPadding, left: 15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedInputField(
                        hintText: "Item Name..",
                        icon: Icons.search,
                        onChanged: (value) {
                          getItemName = value;
                          fetchProduct();
                        },
                    ),
                  ]),
            ),
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
