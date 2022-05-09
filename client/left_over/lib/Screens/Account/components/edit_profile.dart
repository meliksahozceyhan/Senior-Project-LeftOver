import 'dart:convert';
import 'dart:io' ;


import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Models/User.dart';
import 'package:left_over/Screens/Account/account_screen.dart';
import 'package:left_over/Screens/Account/components/account_body.dart';
import 'package:left_over/Screens/Account/components/profile.dart';
import 'package:left_over/Screens/Login/components/body.dart';
import 'package:left_over/Screens/SearchItem/search_item_screen.dart';
import 'package:left_over/Screens/Welcome/welcome_screen.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/components/rounded_date_field.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_password_field.dart';
import 'package:left_over/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class EditProfileScreen extends StatefulWidget {
  //const EditProfileScreen({Key key}) : super(key: key);
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User user;

  @override
  void initState()  {
    getUserDetailsFromSharedPrefs();
    super.initState();
  }

  var getName = "";

  var getEmail = "";

  var oldPassword = "";

  var newPassword = "";

  var getDateofBirth = "";

  var getCity = "";

  var getAddress = "";

  var getImageId = "";

  //var getOldPassword = "";

  //var getNewPassword = "";

  Future<File> file;
  String base64Image ;
  File tmpFile;
  String background = "assets/images/profile_avatar.jpg";

  void getUserDetailsFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    //userId = payload['id'];
    setState(() {
      user = User.fromJson(payload);
      getName = user.fullName;
      getEmail = user.email;
      getDateofBirth =  DateFormat('dd-MM-yyyy').format(DateTime.parse(user.dateOfBirth));
      getCity = user.city;
      getAddress = user.address;
      //getOldPassword = user.password;
      //getNewPassword = "";
      getImageId = user.profileImage;

       if(getImageId != null){
         background = getImageId;
      }
      
      DateTime currentDate = DateTime.now();
      age = currentDate.year - int.parse(getDateofBirth.substring(getDateofBirth.length-5)) ; 
      int month1 = currentDate.month;
      int month2 = int.parse(getDateofBirth.substring(getDateofBirth.length-8,getDateofBirth.length-5));
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = int.parse(getDateofBirth.substring(0,getDateofBirth.length-8));
        if (day2 > day1) {
          age--;
        }
      }

      nameController.text = getName ;
      mailController.text = getEmail;
      birthDateController.text = getDateofBirth;
      cityController.text = getCity;
      addressController.text = getAddress;

      //passwordController.clear();
      //newPasswordController.clear();

    });

  }

  var birthDateController = TextEditingController();

  var nameController = TextEditingController();

  var mailController = TextEditingController();

  //var passwordController = TextEditingController();

  //var newPasswordController = TextEditingController();

  var cityController = TextEditingController();

  var addressController = TextEditingController();

  int age;

  var isValidationOK = true;  

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 30),
          title: const Text('How do you want to upload image?',
              style: TextStyle(color: Colors.white)),
          backgroundColor: darkBackgroundColor,
          actions: <Widget>[
            RoundedButton(
                text: 'Upload From Gallery',
                color: lightBackgroundColor,
                textColor: pinkBlockColor,
                press: () {
                  //imageMethod = 0;
                  Navigator.of(context).pop();
                  //print('upload from gallery is selected');
                  //getStateOfCategories();
                  chooseImageFromGallery();
                }),
            RoundedButton(
                text: 'Take a Photo',
                color: lightBackgroundColor,
                textColor: lightPinkBlockColor,
                press: () {
                  //imageMethod = 1;
                  Navigator.of(context).pop();
                  //print('upload from camera is selected');
                  //getStateOfCategories();
                  chooseImageFromCamera();
                }),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close',
                    style: TextStyle(color: greenBlockColor))),
          ],
        );
      },
    );
  }

  chooseImageFromGallery() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery)  ;
    });
  }

  chooseImageFromCamera() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera) ;
    });
  }

  Widget changeProfilePicture() {
    //print("Inside change Profile Picture");
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return CircleAvatar(backgroundImage: FileImage(snapshot.data) ); 
          // Image.file(
          //       snapshot.data,
          //       fit: BoxFit.fill,
          //     );
        } else if (null != snapshot.error) {
          return CircleAvatar(
            backgroundImage: AssetImage(background),
            );
        } else {
          return CircleAvatar(
            backgroundImage: AssetImage(background),
            );
        }
      },
    );
  }

  uploadImage() async {
    if (base64Image != "" && base64Image != null) {
      print("Inside Image Upload.");

      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var stream = http.ByteStream(tmpFile.openRead());
      var length = await tmpFile.length();

      var url = Uri.parse(dotenv.env['API_URL'] + "/image");

      var request = http.MultipartRequest("POST", url);
      request.headers["Authorization"] = "Bearer " + token;
      request.fields["name"] = tmpFile.path.split('/').last;

      var multipartFile =
          http.MultipartFile('file', stream, length, filename: tmpFile.path);

      request.files.add(multipartFile);
      var response = await http.Response.fromStream(await request.send());
      //print("after Save Actions");
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("201");
        final body = json.decode(response.body);
        print(body["_id"]+"image");
        getImageId = body["_id"];

        /*if (getName != "" && getEmail != "" && getDateofBirth != "" && getCity != "" && getAddress != "") {
          await uploadItem(body["_id"]);
          //navigator to item datail page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          final scaffold = ScaffoldMessenger.of(context);
          scaffold.showSnackBar(
            SnackBar(
              content: const Text(
                'Profile is updated!',
              ),
              backgroundColor: lightGreenBlockColor,
              action: SnackBarAction(
                  label: 'Close',
                  onPressed: scaffold.hideCurrentSnackBar,
                  textColor: darkBackgroundColor),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          final scaffold = ScaffoldMessenger.of(context);
          scaffold.showSnackBar(
            SnackBar(
              content: const Text(
                'Empty fields are not accepteed!',
              ),
              backgroundColor: redCheck,
              action: SnackBarAction(
                  label: 'Close',
                  onPressed: scaffold.hideCurrentSnackBar,
                  textColor: Colors.white),
              behavior: SnackBarBehavior.floating,
            ),
          );
          getUserDetailsFromSharedPrefs();
        }*/
      } else {
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            content: const Text(
              'Upload Image Failed!',
            ),
            backgroundColor: redCheck,
            action: SnackBarAction(
                label: 'Close',
                onPressed: scaffold.hideCurrentSnackBar,
                textColor: Colors.white),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } 
    await uploadItem(getImageId);
    
  }

  uploadItem(String imageId) async {
    //print("Inside Upload Item");
    var url = Uri.parse(dotenv.env['API_URL'] + "/user/");

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var userid = payload["id"];
    Map data = null;

    data = {
        'user': {'id': userid},
        'fullname': getName,
        'email': getEmail,
        'dateOfBirth': getDateofBirth,
        //'oldPassword': getOldPassword,
        //'newPassword' : getNewPassword,
        'city': getCity,
        'address' : getAddress,
        'profileImage': imageId
    };

    
    Map<String, String> headers = new Map<String, String>();
    headers["Authorization"] = "Bearer " + token;
    headers["Content-Type"] = "application/json";

    var body = json.encode(data);
    print(body);

    var response = await http.put(url, headers: headers, body: body);

    if (response.statusCode != 201) {
      var deleteUrl = Uri.parse(dotenv.env['API_URL'] + "/user/updateProfile" + imageId);
      await http.delete(deleteUrl, headers: headers);
    }
    //print("${response.request}");
    //print("${response.statusCode}");
    //print("${response.body}");

    // return response;
  }

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
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      changeProfilePicture(),
                      Positioned(
                        right: -16,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: lightBackgroundColor),
                              ),
                              primary: Colors.white,
                              backgroundColor: lightBackgroundColor,
                            ),
                            onPressed: () {
                              _showDialog();
                  
                            },
                            child: Icon(Icons.add),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                RoundedInputField(
                  hintText: "fullname",
                  icon: Icons.person,
                  onChanged: (value) {
                    getName = value;
                  },
                  controller: nameController,
                ),
                RoundedInputField(
                  hintText: "e-mail",
                  icon: Icons.mail,
                  onChanged: (value) {
                    getEmail = value;
                  },
                  controller: mailController,
                ),
                /*RoundedPasswordField(
                  hintText: "Password",
                  onChanged: (value) {
                    oldPassword = value;
                  },
                  controller: passwordController,
                ),
                RoundedPasswordField(
                  hintText: "New Password",
                  onChanged: (value) {
                    newPassword = value;
                  },
                  controller: newPasswordController,
                ),*/
                RoundedDateField(
                    hintText: "Birthday",
                    textEditingController: birthDateController,
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
                        birthDateController.text = DateFormat('dd-MM-yyyy').format(date);
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
                        getDateofBirth != "" &&
                        getCity != "" &&
                        getAddress != "") {

                      /*if (oldPassword == newPassword) {
                        isValidationOK = false;
                        final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(SnackBar(
                          content: const Text(
                            'Password must be different than the previous one!',
                          ),
                          backgroundColor: redCheck,
                          action: SnackBarAction(
                              label: 'Close',
                              onPressed: scaffold.hideCurrentSnackBar,
                              textColor: Colors.white),
                          behavior: SnackBarBehavior.floating,
                        ));
                        //passwordController.clear();
                        //newPasswordController.clear();
                      } else*/ 
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+\.[a-zA-Z]+").hasMatch(getEmail)) {
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
                              'Update Failure! \n Your age should be greater than 18!',
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
                        //passwordController.clear();
                        //newPasswordController.clear();
                        birthDateController.clear();
                        cityController.clear();
                        addressController.clear();
                        getName = "";
                        getEmail = "";
                        //oldPassword = "";
                       // newPassword = "";
                        getDateofBirth = "";
                        getCity = "";
                        getAddress = "";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                        );
                      } else {
                        uploadImage();

                        isValidationOK = true;
                        Future<http.Response> putRequest() async {
                          var url = Uri.parse(dotenv.env['API_URL'] + "/user/updateProfile");

                          //var url = Uri.parse(urlAndParams);

                          Map data = {
                            'id':user.id,
                            'email': getEmail,
                            'fullName': getName,
                            'oldPassword': oldPassword,
                            'newPassword' : newPassword,
                            'dateOfBirth': DateTime.parse(getDateofBirth.split("-").reversed.join("-")).toString(),
                            'city': getCity,
                            'address': getAddress,
                            'profileImage' : getImageId
                          };
                          //encode Map to JSON
                          var body = json.encode(data);

                          final prefs = await SharedPreferences.getInstance();
                          var token = prefs.getString('token');
                          Map<String, String> headers = new Map<String, String>();
                          headers["Authorization"] = "Bearer " + token;
                          headers["Content-Type"] = "application/json";

                          //print(headers);

                          var response = await http.put(url,
                              headers: headers,
                              body: body);
                          //print(response.statusCode);
                          //print(response.body);
                          if (response.statusCode == 200) {
                            isValidationOK = true;
                            prefs.setString('token', response.body);
                            final scaffold = ScaffoldMessenger.of(context);
                            scaffold.showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Profile is successfully updated!',
                                ),
                                backgroundColor: greenBlockColor,
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
                                builder: (context) => ProfileScreen()),
                              
                            );
                          }
                          return response;
                        }

                        if (isValidationOK) {
                          putRequest();
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
                      //passwordController.clear();
                      //newPasswordController.clear();
                      birthDateController.clear();
                      cityController.clear();
                      addressController.clear();
                      getName = "";
                      getEmail = "";
                      oldPassword = "";
                      newPassword= "";
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
