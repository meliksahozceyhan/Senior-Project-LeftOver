// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/Screens/Login/login_screen.dart';
import 'package:left_over/Screens/item/item_screen.dart';
import 'package:left_over/Screens/Signup/components/background.dart';
import 'package:left_over/components/already_have_an_account_acheck.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/components/rounded_date_field.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_password_field.dart';
import 'package:http/http.dart' as http;
import 'package:left_over/constants.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget {
  var getName = "";
  var getEmail = "";
  var getPassword = "";
  var getPasswordConfirmation = "";
  var getDateofBirth = "";
  var getCity = "";
  var getAddress = "";
  var txt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.04),
            Text(
              "Register",
              style: TextStyle(fontSize: 45, color: kPrimaryLightColor),
              //GoogleFonts.comfortaa(fontSize: 45),
            ),
            SizedBox(height: size.height * 0.01),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            RoundedInputField(
              hintText: "Full Name",
              icon: Icons.person,
              onChanged: (value) {
                getName = value;
              },
            ),
            RoundedInputField(
              hintText: "E-mail",
              icon: Icons.mail,
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
            RoundedPasswordField(
              hintText: "Password Confirmation",
              onChanged: (value) {
                getPasswordConfirmation = value;
              },
            ),
            RoundedDateField(
                hintText: "Date of Birth",
                textEditingController: txt,
                onChanged: (value) {
                  getDateofBirth = value;
                },
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1921, 1, 1),
                      maxTime: DateTime.now(), onChanged: (date) {
                    //print('change $date');
                    //return date;
                  }, onConfirm: (date) {
                    getDateofBirth = date.toString();
                    txt.text = date
                        .toUtc()
                        .toString()
                        .split(" ")[0]
                        .split("-")
                        .reversed
                        .join("-");
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                }),
            RoundedInputField(
              hintText: "City",
              icon: Icons.location_city,
              onChanged: (value) {
                getCity = value;
              },
            ),
            RoundedInputField(
              hintText: "Address",
              icon: Icons.location_on,
              onChanged: (value) {
                getAddress = value;
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: lightBackgroundColor,
              press: () async {
                Future<http.Response> postRequest() async {
                  var url = Uri.parse(dotenv.env['API_URL'] + "/user/");

                  //var url = Uri.parse(urlAndParams);

                  Map data = {
                    'email': getEmail,
                    'fullName': getName,
                    'password': getPassword,
                    'dateOfBirth': getDateofBirth,
                    'city': getCity,
                    'address': getAddress
                  };
                  //encode Map to JSON
                  var body = json.encode(data);

                  var response = await http.post(url,
                      headers: {"Content-Type": "application/json"},
                      body: body);
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('token', 'Bearer ${response.body}');
                  print("${response.request}");
                  print("${response.statusCode}");
                  print("${response.body}");

                  if (response.statusCode == 500) {
                    final scaffold = ScaffoldMessenger.of(context);
                    scaffold.showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Please enter required fields!',
                        ),
                        backgroundColor: redCheck,
                        action: SnackBarAction(
                            label: 'Close',
                            onPressed: scaffold.hideCurrentSnackBar,
                            textColor: Colors.white),
                      ),
                    );
                  }

                  if (getPassword != getPasswordConfirmation) {
                    final scaffold = ScaffoldMessenger.of(context);
                    scaffold.showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Passwords should be matched!',
                        ),
                        backgroundColor: redCheck,
                        action: SnackBarAction(
                            label: 'Close',
                            onPressed: scaffold.hideCurrentSnackBar,
                            textColor: Colors.white),
                      ),
                    );
                  }

                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+\.[a-zA-Z]+")
                      .hasMatch(getEmail)) {
                    final scaffold = ScaffoldMessenger.of(context);
                    scaffold.showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Please enter valid Email format!',
                        ),
                        backgroundColor: redCheck,
                        action: SnackBarAction(
                            label: 'Close',
                            onPressed: scaffold.hideCurrentSnackBar,
                            textColor: Colors.white),
                      ),
                    );
                  }

                  //DateTime.now(year)

                  //if(DateTime(now.year) - getDateofBirth)

                  if (response.statusCode == 201) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ItemScreen();
                        },
                      ),
                    );
                  }

                  return response;
                }

                print("endddd");

                postRequest();

                // GET REQUEST
                // print("heree");
                // var url = Uri.parse('http://10.0.2.2:43951/api/User/GetAllUsers');
                // var response = await http.get(url);
                // print('${response.statusCode}');
                // print('${response.body}');
              },
            ),
            SizedBox(height: size.height * 0.02),
            AlreadyHaveAnAccountCheck(
              login: false,
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
            //OrDivider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocalIcon(
            //       iconSrc: "assets/icons/facebook.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/twitter.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/google-plus.svg",
            //       press: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
