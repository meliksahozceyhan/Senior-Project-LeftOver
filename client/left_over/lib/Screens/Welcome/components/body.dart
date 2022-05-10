import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/Screens/Login/login_screen.dart';
import 'package:left_over/Screens/Signup/signup_screen.dart';
import 'package:left_over/Screens/Welcome/components/background.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/constants.dart';
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  void checkIfServerAvailableAndDoesAppHaveInternetConnection(
      BuildContext context) async {
    var response = await http.get(Uri.parse(dotenv.env['API_URL'])).timeout(
      Duration(seconds: 2),
      onTimeout: () {
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            content: const Text(
              'Either you don\'t have internet connection or server is not online!',
            ),
            backgroundColor: redCheck,
            action: SnackBarAction(
                label: 'Close',
                onPressed: scaffold.hideCurrentSnackBar,
                textColor: Colors.white),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return null;
      },
    ).ignore();
  }

  @override
  Widget build(BuildContext context) {
    checkIfServerAvailableAndDoesAppHaveInternetConnection(context);
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
