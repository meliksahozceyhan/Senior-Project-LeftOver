import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/Models/Product.dart';
import 'package:google_fonts/google_fonts.dart';

import 'categorries.dart';
import 'item_card.dart';

class AccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(height: 25, child: Text("Account")),
    );
  }
}
