import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/Screens/Login/components/background.dart';
import 'package:left_over/Screens/Products/products_screen.dart';
import 'package:left_over/Screens/Signup/signup_screen.dart';
import 'package:left_over/components/already_have_an_account_acheck.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
            const Text(
              "LOGIN",
              style: GoogleFonts.comfortaa(fontSize: 45),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                getEmail = value;
              },
            ),
            RoundedPasswordField(
              hintText: "Password",
              onChanged: (value) {
                getPassword = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                var url = Uri.parse(dotenv.env['API_URL'] +
                    "/user/login?email=" +
                    getEmail +
                    "&password=" +
                    getPassword);
                var response = await http.get(url);
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('token', 'Bearer ${response.body}');

                if (response.statusCode == 200) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductsScreen();
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
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
