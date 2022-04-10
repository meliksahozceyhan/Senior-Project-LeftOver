import 'package:flutter/material.dart';
import 'package:left_over/Screens/Account/components/edit_profile.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/Screens/Account/components/profile_menu.dart';
import 'package:left_over/Screens/Account/components/profile_pic.dart';
import 'package:left_over/Screens/Account/components/profile.dart';

class AccountBody extends StatefulWidget {
  const AccountBody({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<AccountBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      //padding: const EdgeInsets.only(top: profileTopPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfilePic(),
          SizedBox(height: 25),
          const Text(
            "Hi, FULL NAME",
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
                        builder: (context) => const ProfileScreen()),
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
            press: () {},
          ),
        ],
      ),
    ));
  }
}
