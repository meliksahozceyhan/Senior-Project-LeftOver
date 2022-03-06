import 'package:flutter/material.dart';
import 'package:left_over/Screens/Login/login_screen.dart';
import 'package:left_over/Screens/Signup/signup_screen.dart';
import 'package:left_over/Screens/Welcome/components/background.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/leftover_logo.png'),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              color: lightBackgroundColor,
              textColor: greenBlockColor,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: lightBackgroundColor,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
