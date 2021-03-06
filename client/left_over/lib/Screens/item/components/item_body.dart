import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Screens/details/details_screen.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:left_over/models/User.dart';
import 'package:left_over/socket_service.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'categorries.dart';
import 'item_card.dart';

import 'dart:math' as math;

class ItemBody extends StatefulWidget {
  const ItemBody({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<ItemBody> {
  List<Product> products = [];

  List<Product> _postJson = [];
  List<Product> _sortedList = [];
  static int selectedCategoryIndex = 0;
  static int defaultCategory =
      selectedCategoryIndex; // both 0 at the beginning which is consumable
  var ascending = false;
  var descending = false;
  static int sortCount = 0;
  var selectedSub = 'All';

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
        Uri.parse(dotenv.env['API_URL'] + "/item/getItems?userId=" + user.id),
        headers: headers);

    if (response.statusCode == 500) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text(
            'Something went wrong on the server side',
          ),
          backgroundColor: redCheck,
          action: SnackBarAction(
              label: 'Close',
              onPressed: scaffold.hideCurrentSnackBar,
              textColor: Colors.white),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    var jsonData = jsonDecode(response.body) as List;

    setState(() {
      selectedCategoryIndex = CategoriesState.selectedIndex;

      _postJson = //unsorted original list from json
          List<Product>.from(jsonData.map((model) => Product.fromJson(model)))
              .where((item) =>
                  item.category ==
                  CategoriesState.categories[CategoriesState.selectedIndex])
              .toList();

      _sortedList = _postJson;

      // if(selectedSub != 'All'){
      //   _postJson = //unsorted original list from json
      //       List<Product>.from(jsonData.map((model) => Product.fromJson(model)))
      //           .where((item) =>
      //               item.subCategory == selectedSub)
      //           .toList();
      //           //selectedSub = 'All';
      // }else if(selectedSub == 'All'){
      //   _postJson = //unsorted original list from json
      //       List<Product>.from(jsonData.map((model) => Product.fromJson(model)))
      //           .where((item) =>
      //               item.category ==
      //               CategoriesState.categories[CategoriesState.selectedIndex])
      //           .toList();
      // }

      if (defaultCategory != selectedCategoryIndex) {
        //if selected category is changed then it detects the change , it returns default all items in selected category without sort without selected specific sub
        sortCount = 0; // so it cancels sorting selection
        _postJson = //unsorted original list from json
            List<Product>.from(jsonData.map((model) => Product.fromJson(model)))
                .where((item) =>
                    item.category ==
                    CategoriesState.categories[CategoriesState.selectedIndex])
                .toList();
        _sortedList = _postJson; //to init list for sorting or not
        ascending = false;
        descending = false;
        defaultCategory =
            selectedCategoryIndex; //sets default as selected to be able to control later changes
        selectedSub = "All";
      }

      if (selectedSub != 'All') {
        _sortedList = _sortedList
            .where((item) => item.subCategory == selectedSub)
            .toList();
      }

      if (ascending == true && descending == false) {
        _sortedList.sort();
      } else if (descending == true && ascending == false) {
        _sortedList.sort();
        _sortedList = _sortedList.reversed.toList();
      } else {
        _sortedList = List<Product>.from(
                jsonData.map((model) => Product.fromJson(model)))
            .where((item) =>
                item.category ==
                CategoriesState.categories[CategoriesState.selectedIndex])
            .toList(); //to turn back original list in case both orderin is false
        if (selectedSub != 'All') {
          _sortedList = _sortedList
              .where((item) => item.subCategory == selectedSub)
              .toList();
        }
      }
    });
  }

  connectToSocketServer() async {
    socketService.initialize();
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    User user = User.fromJson(payload);
    socketService.connectToRoom(user.id);
  }

  @override
  void initState() {
    fetchProduct();
    if (socketService.socket == null || !this.socketService.socket.connected) {
      connectToSocketServer();
    }
    super.initState();
  }

  // @override
  // void dispose() {
  //   User user = User();
  //   getUser().then((value) => user = value);
  //   socketService.disconnectFromSocket(user.id);
  //   super.dispose();
  // }

  // Future<User> getUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');
  //   Map<String, dynamic> payload = Jwt.parseJwt(token);
  //   User user = User.fromJson(payload);
  //   return user;
  // }

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
                    const Text(
                      "Discover",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.sort_by_alpha,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        sortCount += 1;
                        if (sortCount % 2 == 1) {
                          ascending = true;
                          print("ascending");
                          descending = false;
                          print(sortCount);
                        } else if (sortCount != 0 && sortCount % 2 == 0) {
                          descending = true;
                          print("descending");
                          ascending = false;
                          print(sortCount);
                        }
                        print('sort is pressed');
                        fetchProduct();
                      },
                    ),
                  ]),
            ),
            // Container(
            //   child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Categories(),
            // IconButton(
            //   icon: const Icon(
            //     Icons.arrow_drop_down_circle,
            //     size: 30,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {

            //     //fetchProduct();
            //   },
            // ),
            //       ])),

            Row(
              children: [
                Categories(),
                Spacer(),
                PopupMenuButton(
                  icon: Icon(Icons.arrow_drop_down_circle,
                      size: 30, color: Colors.white),
                  itemBuilder: selectedCategoryIndex == 0
                      ? (_) => const <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                child: Text('All'), value: 'All'),
                            PopupMenuItem<String>(
                                child: Text('Bakery'), value: 'Bakery'),
                            PopupMenuItem<String>(
                                child: Text('Charcuterie'),
                                value: 'Charcuterie'),
                            PopupMenuItem<String>(
                                child: Text('GreenGrocery'),
                                value: 'GreenGrocery'),
                            PopupMenuItem<String>(
                                child: Text('Other'), value: 'Other'),
                          ]
                      : (_) => const <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                child: Text('All'), value: 'All'),
                            PopupMenuItem<String>(
                                child: Text('TopWear'), value: 'TopWear'),
                            PopupMenuItem<String>(
                                child: Text('BottomClothing'),
                                value: 'BottomClothing'),
                            PopupMenuItem<String>(
                                child: Text('Book'), value: 'Book'),
                            PopupMenuItem<String>(
                                child: Text('Shoes'), value: 'Shoes'),
                            PopupMenuItem<String>(
                                child: Text('Accessories'),
                                value: 'Accessories'),
                            PopupMenuItem<String>(
                                child: Text('Decoration'), value: 'Decoration'),
                            PopupMenuItem<String>(
                                child: Text('Tools'), value: 'Tools'),
                            PopupMenuItem<String>(
                                child: Text('Other'), value: 'Other'),
                          ],
                  onSelected: (value) {
                    setState(() {
                      selectedSub = value;
                      fetchProduct();
                    });
                  },
                  // onCanceled: (){
                  //   setState(() {
                  //     fetchProduct();
                  //     selectedSub = 'All';
                  //   });
                  // }
                )
              ],
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                    itemCount: _sortedList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kDefaultPaddin,
                      crossAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => ItemCard(
                          product: _sortedList[index],
                          press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  product: _sortedList[index],
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
