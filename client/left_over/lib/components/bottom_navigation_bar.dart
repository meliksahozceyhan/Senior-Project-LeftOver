import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';

class bottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        //icon: Image.asset("assets/icons/home.svg"), label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        //icon: Image.asset("assets/icons/search.svg"), label: "search"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
        //icon: Image.asset("assets/icons/new.svg"), label: "add"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
        //icon: Image.asset("assets/icons/message.svg"), label: "message"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
        //icon: Image.asset("assets/icons/user.svg"), label: "user")
      ],
      //currentIndex: selectedIndex, // the variable is undefined
      //onTap: onClicked, // the function is undefined
      selectedItemColor: bPinkButton,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
    );
  }
}
