import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:left_over/Screens/Account/components/account_body.dart';
import 'package:left_over/Screens/AddNewItem/components/addItem_body.dart';
import 'package:left_over/Screens/Message/components/message_body.dart';
import 'package:left_over/Screens/Search/components/search_body.dart';
import 'package:left_over/Screens/item/components/item_body.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/constants.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List screens = [
    ItemBody(),
    SearchBody(),
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
        selectedItemColor: bgreen,
        onTap: (i) => setState(() {
          selectedIndex = i;
        }),
      ),
    );
  }
}
