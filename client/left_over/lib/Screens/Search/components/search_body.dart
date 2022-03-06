import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 15.0),
          child: Text(
            "Search",
            style: GoogleFonts.comfortaa(fontSize: 45),
          ),
        ),
      ],
    );
  }
}
