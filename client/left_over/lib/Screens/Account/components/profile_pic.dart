import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:left_over/constants.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/book.jpg"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: lightBackgroundColor),
                  ),
                  primary: Colors.white,
                  backgroundColor: lightBackgroundColor,
                ),
                onPressed: () {},
                child: Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
