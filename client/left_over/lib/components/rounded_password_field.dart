import 'package:flutter/material.dart';
import 'package:left_over/components/text_field_container.dart';
import 'package:left_over/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  const RoundedPasswordField({
    Key key,
    @required this.onChanged,
    @required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: lightBlueColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
