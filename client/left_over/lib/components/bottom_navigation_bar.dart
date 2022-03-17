import 'package:flutter/material.dart';
import 'package:left_over/Screens/Account/components/account_body.dart';
import 'package:left_over/Screens/AddNewItem/components/add_item_body.dart';
import 'package:left_over/Screens/Message/components/message_body.dart';
import 'package:left_over/Screens/SearchItem/components/search_item_body.dart';
import 'package:left_over/Screens/item/components/item_body.dart';
import 'package:left_over/constants.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({Key key}) : super(key: key);

  @override
  _BottomNavigationMenuState createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  List screens = <Widget>[
    ItemBody(),
    SearchItemBody(),
    AddNewItemBody(),
    MessageBody(),
    AccountBody()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
      ],
      selectedItemColor: blueBlockColor,
      backgroundColor: lightBackgroundColor,
      onTap: (i) => setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screens[i]));
        selectedIndex = i;
      }), // the variable is undefined
    );
  }
}
