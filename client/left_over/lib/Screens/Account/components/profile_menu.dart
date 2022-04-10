import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:left_over/Screens/Account/components/profile.dart';

import '../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key key, this.text, this.icon, this.press, this.color})
      : super(key: key);

  final String text;
  final IconData icon;
  final Color color;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: color,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: lightBackgroundColor,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                SizedBox(width: 20),
                Expanded(child: Text(text, style: TextStyle(color: color))),
                Icon(Icons.arrow_forward_ios, color: color),
              ],
            ),
          ),
        ));
  }
}
