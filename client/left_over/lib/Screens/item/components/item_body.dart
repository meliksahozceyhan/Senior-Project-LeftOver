import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/constants_copy.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'categorries.dart';
import 'item_card.dart';

class ItemBody extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState  extends State<ItemBody> {

  List<Product> products = [];

  Future<List<Product>> fetchProduct() async {
    //return http.get(Uri.parse(dotenv.env['API_URL'] + "/item"));

      final response = await http
        .get(Uri.parse(dotenv.env['API_URL'] + "/item"));

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {

        Iterable l = json.decode(response.body);
        products = List<Product>.from(l.map((model)=> Product.fromJson(model)));
        print(products.length);
        print("PROOO");

        setState(() {
          products = products.where((item) => item.category == CategoriesState.categories[CategoriesState.selectedIndex]).toList();
          print(products.length);
          print("PRO STATEEE");
        });

        return products;
        
      } else {
          throw Exception('Failed to load album');
      }
  }

  @override
  Widget build(BuildContext context) {

    if(products.length > 0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Products",
              style: GoogleFonts.comfortaa(fontSize: 45),
            ),
          ),
          Categories(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                        product: products[index],
                        press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                // builder: (context) => DetailsScreen(
                                //   product: products[index],
                                // ),
                                )),
                      )),
            ),
          ),
        ],
      );
    }
    else {
      var prods = fetchProduct();
      return Container(child: Text("wait for complition"),);
    }
  }
}
