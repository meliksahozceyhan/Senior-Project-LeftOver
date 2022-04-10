import 'package:flutter/material.dart';
import 'package:left_over/Screens/AddNewItem/components/add_item_body.dart';
import 'package:left_over/Screens/Message/components/message_body.dart';
import 'package:left_over/Screens/SearchItem/components/search_item_body.dart';
import 'package:left_over/Screens/item/components/item_body.dart';
import 'package:left_over/Screens/Account/account_screen.dart';
import 'package:left_over/constants.dart';
import 'components/account_body.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List screens = [
    ItemBody(),
    SearchItemBody(),
    AddNewItemBody(),
    MessageBody(),
    AccountBody()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
        ],
        selectedItemColor: yellowBlockColor,
        backgroundColor: navBlueColor,
        onTap: (i) => setState(() {
          selectedIndex = i;
        }),
      ),
    );
  }
}
