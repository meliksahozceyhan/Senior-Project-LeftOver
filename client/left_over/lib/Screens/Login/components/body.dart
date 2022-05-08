import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/Screens/Login/components/background.dart';
import 'package:left_over/Screens/Signup/signup_screen.dart';
import 'package:left_over/Screens/item/item_screen.dart';
import 'package:left_over/components/already_have_an_account_acheck.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_password_field.dart';
import 'package:http/http.dart' as http;
import 'package:left_over/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

var mailController = TextEditingController();
var passwordController = TextEditingController();

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getEmail = "";
    var getPassword = "";

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("LOGIN",
                style: TextStyle(color: kPrimaryLightColor, fontSize: 45)),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Email",
              icon: Icons.mail,
              onChanged: (value) {
                getEmail = value;
              },
              controller: mailController,
            ),
            RoundedPasswordField(
              hintText: "Password",
              onChanged: (value) {
                getPassword = value;
              },
              controller: passwordController,
            ),
            RoundedButton(
              text: "LOGIN",
              color: lightBackgroundColor,
              textColor: greenBlockColor,
              press: () async {
                var url = Uri.parse(dotenv.env['API_URL'] +
                    "/user/login?email=" +
                    getEmail +
                    "&password=" +
                    getPassword);
                var response = await http.get(url);
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('token', response.body);

                if (response.statusCode == 401 || response.statusCode == 404) {
                  final scaffold = ScaffoldMessenger.of(context);
                  scaffold.showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Please check your Email and Password!',
                      ),
                      backgroundColor: redCheck,
                      action: SnackBarAction(
                          label: 'Close',
                          onPressed: scaffold.hideCurrentSnackBar,
                          textColor: Colors.white),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  mailController.clear();
                  passwordController.clear();
                }

                if (response.statusCode == 200) {
                  mailController.clear();
                  passwordController.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ItemScreen();
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.02),
            AlreadyHaveAnAccountCheck(
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
