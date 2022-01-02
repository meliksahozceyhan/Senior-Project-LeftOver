import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/Screens/Welcome/welcome_screen.dart';
import 'package:left_over/constants.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  await dotenv.load();

  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.rokkittTextTheme(
            Theme.of(context).textTheme,
          )),
      home: WelcomeScreen(),
    );
  }
}
