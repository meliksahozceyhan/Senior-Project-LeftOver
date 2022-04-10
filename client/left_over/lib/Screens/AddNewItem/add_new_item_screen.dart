import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:left_over/Screens/Account/components/account_body.dart';
import 'package:left_over/Screens/AddNewItem/components/add_item_body.dart';
import 'package:left_over/Screens/Map/components/map_body.dart';
import 'package:left_over/Screens/Message/components/message_body.dart';
import 'package:left_over/Screens/SearchItem/components/search_item_body.dart';
import 'package:left_over/Screens/item/components/item_body.dart';
import 'package:left_over/constants.dart';

class AddNewItemScreen extends StatefulWidget {
  @override
  _AddNewItemScreenState createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  List screens = [
    ItemBody(),
    SearchItemBody(),
    AddNewItemBody(),
    MapBody(),
    MessageBody(),
    AccountBody()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: AddNewItemBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
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
        selectedItemColor: blueBlockColor,
        backgroundColor: lightBackgroundColor,
        onTap: (i) => setState(() {
          selectedIndex = i;
        }),
      ),
      //body: _widgetOptions.elementAt(selectedIndex),
    );
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/images/search.svg"),
        onPressed: () {},
      ),
    );
  }
}
/*
class ItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/images/search.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/images/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/images/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}*/
