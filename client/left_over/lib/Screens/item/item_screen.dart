import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:left_over/constants_copy.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/screens/item/components/body.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  //List screens = [ScreenMovies(), ScreenReleases(), ScreenCuriosities()];
  /*
  void onClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    return Scaffold(
        appBar: buildAppBar(),
        body: Body(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (i) => setState(() {
            selectedIndex = i;
            print('$selectedIndex Selected!');
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            //icon: Image.asset("assets/icons/home.svg"), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            //icon: Image.asset("assets/icons/search.svg"), label: "search"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
            //icon: Image.asset("assets/icons/new.svg"), label: "add"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: "Message"),
            //icon: Image.asset("assets/icons/message.svg"), label: "message"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
            //icon: Image.asset("assets/icons/user.svg"), label: "user")
          ],
          selectedItemColor: bPinkButton,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          /*onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },*/
        ));
  }

  buildAppBar() {
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
