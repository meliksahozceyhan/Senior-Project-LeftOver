import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';

class AccountBody extends StatelessWidget {
  const AccountBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(height: 25, child: Text("Account")),
    );
  }
}
