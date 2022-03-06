import 'package:flutter/material.dart';
import 'package:left_over/components/text_field_container.dart';
import 'package:left_over/constants.dart';

class RoundedDateField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Function() onTap;
  final TextEditingController textEditingController;
  const RoundedDateField(
      {Key key,
      @required this.hintText,
      this.icon = Icons.calendar_today_outlined,
      @required this.onChanged,
      @required this.onTap,
      @required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        onTap: onTap,
        cursorColor: kPrimaryColor,
        controller: textEditingController,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: lightBlueColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
