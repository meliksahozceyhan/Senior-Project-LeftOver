import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Screens/Account/components/edit_profile.dart';
import 'package:left_over/Screens/Login/login_screen.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/User.dart';
import 'package:left_over/Screens/Account/components/profile_menu.dart';
import 'package:left_over/Screens/Account/components/profile_pic.dart';
import 'package:left_over/Screens/Account/components/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountBody extends StatefulWidget {
  const AccountBody({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<AccountBody>  {
  User user ;
  String username = "";

  @override
  void initState() {
    
    // synchronous call if you don't care about the result
    getUserDetailsFromSharedPrefs();
    // anonymous function if you want the result
    //() async {
    //    await getUserDetailsFromSharedPrefs();
    //}();
    super.initState();
  }

  void getUserDetailsFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    //username = payload['fullname'];
    user = User.fromJson(payload);
    print(user.fullName);
    username = user.fullName;
  }

   
  @override
  Widget build(BuildContext context){   
     
    return Center(
        child: SingleChildScrollView(
      //padding: const EdgeInsets.only(top: profileTopPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfilePic(),
          SizedBox(height: 25),
          Text(
            "HI "+username.toUpperCase()+"," ,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15),
          ProfileMenu(
              text: "My Profile",
              icon: Icons.account_circle_rounded,
              color: pinkBlockColor,
              press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen()),
                  )),
          ProfileMenu(
              text: "Edit Profile",
              icon: Icons.edit,
              color: greenBlockColor,
              press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen()),
                  )),
          ProfileMenu(
            text: "Notifications",
            icon: Icons.notifications,
            color: lightBlueBlockColor,
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout,
            color: lightPinkBlockColor,
            press: () async {
              user=null;
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('token', "");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
              final scaffold = ScaffoldMessenger.of(context);
                scaffold.showSnackBar(
                  SnackBar(
                    content: const Text(
                      'You are logged out!',
                    ),
                    backgroundColor: greenBlockColor,
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: scaffold.hideCurrentSnackBar,
                      textColor: Colors.white),
                    behavior: SnackBarBehavior.floating,
                  )
                );
            },
          ),
        ],
      ),
    ));
  }
}
