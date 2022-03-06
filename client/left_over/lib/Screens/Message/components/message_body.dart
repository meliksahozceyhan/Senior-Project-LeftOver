import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';

class MessageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(height: 25, child: Text("Message")),
    );
  }
}
