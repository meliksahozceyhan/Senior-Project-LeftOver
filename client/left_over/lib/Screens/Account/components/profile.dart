import 'package:flutter/material.dart';
import 'package:left_over/Screens/Account/components/profile_pic.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/components/discover_small_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);
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
                    ProfilePic(),
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
                            subtitle: "Jane Doe",
                            gradientStartColor: pinkBlockColor,
                            gradientEndColor: lightPinkBlockColor,
                          ),
                          DiscoverSmallCard(
                            title: 'E-mail: ',
                            subtitle: "janedoe2@gmail.com",
                            gradientStartColor: bExclamationColor,
                            gradientEndColor: greenBlockColor,
                          ),
                          DiscoverSmallCard(
                            title: 'Date of Birth: ',
                            subtitle: '27.11.1998',
                            gradientStartColor: blueBlockColor,
                            gradientEndColor: lightBlueBlockColor,
                          ),
                          DiscoverSmallCard(
                            title: 'City: ',
                            subtitle: 'London',
                            gradientStartColor: greenBlockColor,
                            gradientEndColor: lightGreenBlockColor,
                          ),
                          DiscoverSmallCard(
                            title: 'Address: ',
                            subtitle: '221B Baker Street',
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
