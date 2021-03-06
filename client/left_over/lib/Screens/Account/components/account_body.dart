import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Screens/Account/components/edit_profile.dart';
import 'package:left_over/Screens/Login/login_screen.dart';
import 'package:left_over/Screens/MyListings/my_listings_screen.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/models/User.dart';
import 'package:left_over/Screens/Account/components/profile_menu.dart';
import 'package:left_over/Screens/Account/components/profile.dart';
import 'package:left_over/socket_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountBody extends StatefulWidget {
  const AccountBody({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<AccountBody> {
  User user = User();
  String username = "";
  String profileImage = "assets/images/profile_avatar.jpg";
  SocketService socketService = SocketService();

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
    setState(() {
      user = User.fromJson(payload);
      if (user.profileImage != null) {
        //profileImage = user.profileImage;
        profileImage = dotenv.env['API_URL'] + "/image" + user.profileImage;
      }
    });

    //print(user.fullName);
    username = user.fullName;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      //padding: const EdgeInsets.only(top: profileTopPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                    backgroundImage: user.profileImage != null
                        ? NetworkImage(dotenv.env['API_URL'] +
                            "/image/" +
                            user.profileImage)
                        : AssetImage(profileImage)),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Text(
            "Hi, " + username,
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
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
              text: "My Listings",
              icon: Icons.view_list_outlined,
              color: lightYellowBlockColor,
              press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyListingsItemScreen()),
                  )),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout,
            color: lightPinkBlockColor,
            press: () async {
              user = null;
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('token', "");
              socketService.socket.disconnect();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.showSnackBar(SnackBar(
                content: const Text(
                  'You are logged out!',
                ),
                backgroundColor: greenBlockColor,
                action: SnackBarAction(
                    label: 'Close',
                    onPressed: scaffold.hideCurrentSnackBar,
                    textColor: Colors.white),
                behavior: SnackBarBehavior.floating,
              ));
            },
          ),
        ],
      ),
    ));
  }
}
