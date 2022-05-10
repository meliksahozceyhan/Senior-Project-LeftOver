import 'package:flutter/material.dart';
import 'package:left_over/Screens/AddNewItem/components/add_item_body.dart';
import 'package:left_over/Screens/Map/components/map_body.dart';
import 'package:left_over/Screens/Message/components/message_body.dart';
import 'package:left_over/Screens/MyListings/components/my_listings_item_body.dart';
import 'package:left_over/Screens/SearchItem/components/search_item_body.dart';
import 'package:left_over/Screens/item/components/item_body.dart';
import 'package:left_over/Screens/Account/account_screen.dart';
import 'package:left_over/constants.dart';
import 'components/account_body.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);
  static int selectedIndex = 0;
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List screens = [
    ItemBody(),
    SearchItemBody(),
    AddNewItemBody(),
    MapBody(),
    MessageBody(),
    AccountBody()
  ];
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[AccountScreen.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: AccountScreen.selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
        ],
        selectedItemColor: yellowBlockColor,
        backgroundColor: navBlueColor,
        onTap: (i) => setState(() {
          AccountScreen.selectedIndex = i;
        }),
      ),
    );
  }
}
