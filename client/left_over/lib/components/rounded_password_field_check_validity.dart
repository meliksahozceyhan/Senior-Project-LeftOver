import 'package:flutter/material.dart';
import 'package:left_over/components/text_field_container.dart';
import 'package:left_over/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final checkValidity;

  const RoundedPasswordField({
    Key key,
    @required this.onChanged,
    @required this.hintText,
    @required this.checkValidity,
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
          icon: const Icon(
            Icons.lock,
            color: lightBlueColor,
          ),
          /*icon: checkValidity
              ? Icon(
                  Icons.lock,
                  color: lightBlueColor,
                )
              : Icon(
                  Icons.lock,
                  color: Colors.red,
                ),*/
          // errorText: checkValidity ? 'Please enter valid password!' : null,
          /*errorBorder: checkValidity
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0))
              : OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 0.0),
                ),
          */
          border: InputBorder.none,
        ),
      ),
    );
  }
}
