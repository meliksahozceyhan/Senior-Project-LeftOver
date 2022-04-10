import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:left_over/Screens/Account/components/profile_pic.dart';
import 'package:left_over/Screens/Login/login_screen.dart';
import 'package:left_over/Screens/SearchItem/search_item_screen.dart';
import 'package:left_over/Screens/Welcome/welcome_screen.dart';
import 'package:left_over/components/already_have_an_account_acheck.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/components/rounded_date_field.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_password_field.dart';
import 'package:left_over/constants.dart';
import 'package:http/http.dart' as http;
import 'package:left_over/components/discover_small_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatelessWidget {
  //const EditProfileScreen({Key key}) : super(key: key);
  var getName = "";
  var getEmail = "";
  var getPassword = "";
  var getPasswordConfirmation = "";
  var getDateofBirth = "";
  var getCity = "";
  var getAddress = "";
  var txt = TextEditingController();
  var nameController = TextEditingController();
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();
  int age;
  var isValidationOK = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(context),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RoundedInputField(
                  hintText: "Full Name",
                  icon: Icons.person,
                  onChanged: (value) {
                    getName = value;
                  },
                  controller: nameController,
                ),
                RoundedInputField(
                  hintText: "E-mail",
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
                RoundedPasswordField(
                  hintText: "Password Confirmation",
                  onChanged: (value) {
                    getPasswordConfirmation = value;
                  },
                  controller: passwordConfirmController,
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
                          maxTime: DateTime.now(),
                          onChanged: (date) {}, onConfirm: (date) {
                        DateTime currentDate = DateTime.now();
                        age = currentDate.year - date.year;
                        int month1 = currentDate.month;
                        int month2 = date.month;
                        if (month2 > month1) {
                          age--;
                        } else if (month1 == month2) {
                          int day1 = currentDate.day;
                          int day2 = date.day;
                          if (day2 > day1) {
                            age--;
                          }
                        }
                        getDateofBirth = date.toString();
                        txt.text = DateFormat('dd-MM-yyyy').format(date);
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    }),
                RoundedInputField(
                  hintText: "City",
                  icon: Icons.location_city,
                  onChanged: (value) {
                    getCity = value;
                  },
                  controller: cityController,
                ),
                RoundedInputField(
                  hintText: "Address",
                  icon: Icons.location_on,
                  onChanged: (value) {
                    getAddress = value;
                  },
                  controller: addressController,
                ),
                RoundedButton(
                  text: "Save",
                  color: lightGreenBlockColor,
                  press: () async {
                    if (getName != "" &&
                        getEmail != "" &&
                        getPassword != "" &&
                        getPasswordConfirmation != "" &&
                        getDateofBirth != "" &&
                        getCity != "" &&
                        getAddress != "") {
                      if (getPassword != getPasswordConfirmation) {
                        isValidationOK = false;
                        final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(SnackBar(
                          content: const Text(
                            'Passwords should be matched!',
                          ),
                          backgroundColor: redCheck,
                          action: SnackBarAction(
                              label: 'Close',
                              onPressed: scaffold.hideCurrentSnackBar,
                              textColor: Colors.white),
                          behavior: SnackBarBehavior.floating,
                        ));
                        passwordController.clear();
                        passwordConfirmController.clear();
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+\.[a-zA-Z]+")
                          .hasMatch(getEmail)) {
                        isValidationOK = false;
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
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        mailController.clear();
                      } else if (age < 18) {
                        isValidationOK = false;
                        final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Your age should be greater than 18!',
                            ),
                            backgroundColor: redCheck,
                            action: SnackBarAction(
                                label: 'Close',
                                onPressed: scaffold.hideCurrentSnackBar,
                                textColor: Colors.white),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        nameController.clear();
                        mailController.clear();
                        passwordController.clear();
                        passwordConfirmController.clear();
                        txt.clear();
                        cityController.clear();
                        addressController.clear();
                        getName = "";
                        getEmail = "";
                        getPasswordConfirmation = "";
                        getDateofBirth = "";
                        getCity = "";
                        getAddress = "";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                        );
                      } else {
                        isValidationOK = true;
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
                          prefs.setString('token', response.body);

                          if (response.statusCode == 500) {
                            isValidationOK = false;
                            final scaffold = ScaffoldMessenger.of(context);
                            scaffold.showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'You are already have an account!',
                                ),
                                backgroundColor: redCheck,
                                action: SnackBarAction(
                                    label: 'Close',
                                    onPressed: scaffold.hideCurrentSnackBar,
                                    textColor: Colors.white),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          }

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

                        if (isValidationOK) {
                          postRequest();
                        }
                      }
                    } else {
                      isValidationOK = false;
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
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      nameController.clear();
                      mailController.clear();
                      passwordController.clear();
                      passwordConfirmController.clear();
                      txt.clear();
                      cityController.clear();
                      addressController.clear();
                      getName = "";
                      getEmail = "";
                      getPasswordConfirmation = "";
                      getDateofBirth = "";
                      getCity = "";
                      getAddress = "";
                    }
                  },
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: darkishBlue,
      title: Text("Edit Profile"),
      centerTitle: true,
      elevation: 0,
    );
  }
}
