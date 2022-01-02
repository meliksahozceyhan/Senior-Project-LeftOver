import 'package:flutter/material.dart';
import 'package:left_over/Screens/Login/components/background.dart';
import 'package:left_over/Screens/Products/products_screen.dart';
import 'package:left_over/Screens/Signup/signup_screen.dart';
import 'package:left_over/components/already_have_an_account_acheck.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

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
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                getEmail = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                getPassword = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async{

                var url = Uri.parse('http://10.0.2.2:43951/api/User/GetAuthUser?userEmail=' + getEmail + "&userPassword=" + getPassword);
                var response = await http.get(url);

                print('${response.statusCode}');
                print('${response.body}');

                if(response.statusCode == 200) {
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
