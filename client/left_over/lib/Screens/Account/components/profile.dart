import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Models/User.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/components/discover_small_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user = User();

  String username = "";

  String email = "";

  String dateOfBirth = DateTime.now().toString();

  String city = "";

  String address = "";

  String profileImage = "assets/images/profile_avatar.jpg";

  @override
  void initState() {
    getUserDetailsFromSharedPrefs();
    super.initState();
  }

  void getUserDetailsFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    //userId = payload['id'];
    setState(() {
      user = User.fromJson(payload);
      username = user.fullName;
      email = user.email;
      dateOfBirth = user.dateOfBirth;
      city = user.city;
      address = user.address;

      if (user.profileImage != null) {
        //profileImage = user.profileImage;
        profileImage = dotenv.env['API_URL'] + "/image/" + user.profileImage;
        //print(profileImage);

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: size.height / 30,
                    ),
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
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 19,
                                mainAxisExtent: 62,
                                mainAxisSpacing: 19),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          DiscoverSmallCard(
                            title: 'Full Name: ',
                            subtitle: username,
                            gradientStartColor: pinkBlockColor,
                            gradientEndColor: lightPinkBlockColor,
                          ),
                          DiscoverSmallCard(
                            title: 'E-mail: ',
                            subtitle: email,
                            gradientStartColor: bExclamationColor,
                            gradientEndColor: greenBlockColor,
                          ),
                          DiscoverSmallCard(
                            title: 'Date of Birth: ',
                            subtitle: DateFormat('dd-MM-yyyy')
                                .format(DateTime.parse(dateOfBirth)),
                            gradientStartColor: blueBlockColor,
                            gradientEndColor: lightBlueBlockColor,
                          ),
                          DiscoverSmallCard(
                            title: 'City: ',
                            subtitle: city,
                            gradientStartColor: greenBlockColor,
                            gradientEndColor: lightGreenBlockColor,
                          ),
                          DiscoverSmallCard(
                            title: 'Address: ',
                            subtitle: address,
                            gradientStartColor: lightBlueColor,
                            gradientEndColor: lilacColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: darkishBlue,
      title: Text("My Profile"),
      centerTitle: true,
      elevation: 0,
    );
  }
}
