// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:left_over/Screens/Login/login_screen.dart';
import 'package:left_over/Screens/Products/products_screen.dart';
import 'package:left_over/Screens/Signup/components/background.dart';
import 'package:left_over/Screens/Signup/components/or_divider.dart';
import 'package:left_over/Screens/Signup/components/social_icon.dart';
import 'package:left_over/components/already_have_an_account_acheck.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/components/rounded_date_field.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
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
            Text(
              "Register",
              style: GoogleFonts.comfortaa(fontSize: 45),
            ),
            SizedBox(height: size.height * 0.01),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            RoundedInputField(
              hintText: "Fullname",
              onChanged: (value) {
                getName = value;
              },
            ),
            RoundedInputField(
              hintText: "Email",
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
              onChanged: (value) {
                getCity = value;
              },
            ),
            RoundedInputField(
              hintText: "Address",
              onChanged: (value) {
                getAddress = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
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
            SizedBox(height: size.height * 0.03),
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
