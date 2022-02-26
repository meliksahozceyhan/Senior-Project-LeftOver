import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.007),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.01),
      width: size.width * 0.8,
      height: size.height * 0.07,
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: lightBackgroundColor)),
      child: child,
    );
  }
}
