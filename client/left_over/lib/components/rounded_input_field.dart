import 'package:flutter/material.dart';
import 'package:left_over/components/text_field_container.dart';
import 'package:left_over/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    @required this.hintText,
    @required this.icon,
    @required this.onChanged,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: lightBlueColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        controller: controller,
      ),
    );
  }
}
