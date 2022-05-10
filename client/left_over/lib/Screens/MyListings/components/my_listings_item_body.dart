import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Screens/Account/account_screen.dart';
import 'package:left_over/Screens/item/components/item_card.dart';
import 'package:left_over/Screens/MyListings/components/my_listing_details_screen.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:left_over/models/User.dart';
import 'package:left_over/socket_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyListingsItemBody extends StatefulWidget {
  const MyListingsItemBody({Key key}) : super(key: key);

  @override
  _MyListingsItemBodyState createState() => _MyListingsItemBodyState();
}

class _MyListingsItemBodyState extends State<MyListingsItemBody> {
  List<Product> products = [];

  var _postJson = [];

  SocketService socketService = SocketService();

  void fetchProduct() async {
    //return http.get(Uri.parse(dotenv.env['API_URL'] + "/item"));

    Map<String, String> headers = new Map<String, String>();
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    User user = User.fromJson(payload);
    headers["Authorization"] = "Bearer " + token;

    final response = await http.get(
        Uri.parse(
            dotenv.env['API_URL'] + "/item/getItemsOfUser?userId=" + user.id),
        headers: headers);

    var jsonData = jsonDecode(response.body) as List;

    setState(() {
      products =
          List<Product>.from(jsonData.map((json) => Product.fromJson(json)));
    });
  }

  @override
  void initState() {
    fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 5, left: 15.0, bottom: 15),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: products[index],
                      press: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyListingDetailScreen(
                              product: products[index],
                            ),
                          )),
                    )),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: (){
          AccountScreen.selectedIndex=5;
           Navigator.pushReplacement(
                              context,
          MaterialPageRoute(
                                  builder: (context) => AccountScreen()));
        },
        child: const Icon(Icons.arrow_back),),
      backgroundColor: darkishBlue,
      title: Text("Edit Profile"),
      centerTitle: true,
      elevation: 0,
    );
  }
}
