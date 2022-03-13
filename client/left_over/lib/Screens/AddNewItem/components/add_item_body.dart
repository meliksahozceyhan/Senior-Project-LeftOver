import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:left_over/Screens/Login/components/background.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_date_field.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/Screens/item/components/categorries.dart';

import 'package:http/http.dart' as http;
import 'package:left_over/constants.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() => _UploadingImageToFirebaseStorageState();  
}

class _UploadingImageToFirebaseStorageState extends State<UploadingImageToFirebaseStorage> {
  File _imageFile;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }
  
}*/

class AddNewItemBody extends StatefulWidget {
  @override
  _NewItemBodyState createState() => _NewItemBodyState();
}

class _NewItemBodyState extends State<AddNewItemBody> {
  var getItemName = "";
  var getCategory = "";
  var getSubcategory = "";
  var getCondition = "";
  var getSharerId = "";
  var getImage = "";
  var txt = TextEditingController();
  var uploadEndPoint = Uri.parse(dotenv.env['API_URL'] + "/image");
  Future<File> file;
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  static int selectedCategoryIndex = 0;
  static int defaultCategory = selectedCategoryIndex; // both 0 at the beginning
  static int imageMethod; //0 for gallery , 1 for camera

  static List<List> spinnerItems = [
    ['Bakery', 'Charcuterie', 'GreenGrocery'],
    [
      'TopWear',
      'BottomClothing',
      'Book',
      'Shoes',
      'Accessories',
      'Decoration',
      'Tools'
    ]
  ];
  static List<String> conditionList = [
    'New',
    'Almost New',
    'Underused',
    'Tolerable',
    'Old'
  ];

  static List<String> subcategory =
      List<String>.from(spinnerItems.elementAt(0));
  static String subdropdownvalue = subcategory.elementAt(0);
  static String conditiondropdownvalue = conditionList.elementAt(0);
  static int selectedSubIndex = 0;
  static int selectedConditionIndex = 0;

  void getStateOfCategories() {
    setState(() {
      selectedCategoryIndex = CategoriesState.selectedIndex;
      subcategory =
          List<String>.from(spinnerItems.elementAt(selectedCategoryIndex));
      if (defaultCategory != selectedCategoryIndex) {
        //if selected category is changed then it detects the change
        selectedSubIndex = 0; // so it cancels sub category selection
        defaultCategory =
            selectedCategoryIndex; //sets default as selected to be able to control later changes
        selectedConditionIndex = 0;
      }
      if (selectedCategoryIndex == 1) {
        conditiondropdownvalue =
            conditionList.elementAt(selectedConditionIndex);
      }

      subdropdownvalue = subcategory.elementAt(selectedSubIndex);
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How do you want to upload image?'),
          actions: <Widget>[
            RoundedButton(
                text: 'Upload From Gallery',
                press: () {
                  imageMethod = 0;
                  Navigator.of(context).pop();
                  print('upload from gallery is selected');
                  chooseImage();
                }),
            RoundedButton(
                text: 'Take a Photo',
                press: () {
                  imageMethod = 1;
                  Navigator.of(context).pop();
                  print('upload from gallery is selected');
                }),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close')),
          ],
        );
      },
    );
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  upload() async {

    print("Before save Actions");

    Map<String, String> headers = new Map<String, String>();
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    
    String fileName = tmpFile.path.split('/').last;
    final request = await http.post(uploadEndPoint, body: {
      "name": fileName,
      "file": base64Image,
    }, headers: {
      "Authorization": "Bearer " + token,
    }).then((value) => print(value.statusCode));

    // Map<String, String> headers = new Map<String, String>();
    // final prefs = await SharedPreferences.getInstance();
    // var token = prefs.getString('token');

    // var stream = http.ByteStream(tmpFile.openRead());
    // var length = await tmpFile.length();

    
    // var url = Uri.parse(dotenv.env['API_URL'] + "/image?name=" + tmpFile.path);

    // var request = http.MultipartRequest("POST", url);
    // request.headers["Authorization"] = "Bearer " + token;
    
    // var multipartFile = http.MultipartFile('file', stream, length,filename: tmpFile.path);

    // request.files.add(multipartFile);
    // var response = request.send();
    // print("after Save Actions");
    // response.then((value) => print(value.statusCode));
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return SizedBox(
            height: 70,
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: (_) {
          getStateOfCategories();
        },
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Padding(
                //padding: const EdgeInsets.only(top: 5, left: 20.0),
                //child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //children: [
                const Text(
                  "Add Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: Categories(),
                ),

                // ],
                //),
                // ),

                Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: Column(children: [
                      RoundedInputField(
                        hintText: "Item Name",
                        icon: Icons.edit,
                        onChanged: (value) {
                          getItemName = value;
                        },
                      ),
                      Visibility(
                        visible: selectedCategoryIndex == 0 ? true : false,
                        child: RoundedDateField(
                            hintText: "Expiration Date",
                            textEditingController: txt,
                            onChanged: (value) {
                              getCondition = value;
                            },
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime.now()
                                      .add(const Duration(days: 7)),
                                  onChanged: (date) {
                                //print('change $date');
                                //return date;
                              }, onConfirm: (date) {
                                getCondition = date.toString();
                                txt.text = date
                                    .toUtc()
                                    .toString()
                                    .split(" ")[0]
                                    .split("-")
                                    .reversed
                                    .join("-");
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            }),
                      ),
                    ])),

                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        DropdownButton<String>(
                          isExpanded: true,
                          //hint: Text('Choose subcategory'),
                          value: subdropdownvalue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: lightPinkBlockColor, fontSize: 18),
                          underline: Container(
                            height: 2,
                            color: lightPinkBlockColor,
                          ),
                          onChanged: (String data) {
                            selectedSubIndex = subcategory.indexOf(data);
                            getSubcategory = data;
                            getStateOfCategories();
                            print(getSubcategory);
                            print(selectedSubIndex);
                          },
                          items: subcategory
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Visibility(
                            visible: selectedCategoryIndex == 1 ? true : false,
                            child: DropdownButton<String>(
                              // hint: Text('Select condition of the item'),
                              value: conditiondropdownvalue,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: pinkBlockColor, fontSize: 18),
                              underline: Container(
                                height: 2,
                                color: pinkBlockColor,
                              ),
                              onChanged: (String data) {
                                selectedConditionIndex =
                                    conditionList.indexOf(data);
                                getStateOfCategories();
                                conditiondropdownvalue = data;
                                getCondition = data;
                              },
                              items: conditionList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                      ],
                    )),
                RoundedButton(
                  text: "UPLOAD PHOTO",
                  color: lightBackgroundColor,
                  textColor: lightBlueBlockColor,
                  press: () {
                    _showDialog();
                    print("add image is pressed");
                  },
                ),
                showImage(),
                RoundedButton(
                  text: "SAVE",
                  color: lightBlueBlockColor,
                  textColor: Colors.white,
                  press: () {
                    print("SAVE is pressed");
                    upload();
                    /* 

                () async {
                Future<http.Response> postRequest() async {
                  //var url = Uri.parse(dotenv.env['API_URL'] + "/user/");

                final prefs = await SharedPreferences.getInstance();
                var token = prefs.getString('token');
                Map<String, dynamic> payload = Jwt.parseJwt(token);
                var userid= payload["id"];
                getCategory = categories.elementAt(categoryindex);

                Map data = {
                    'userid': userid,
                    'itemname': getItemName,
                    'category': getCategory,
                    'subcategory': getSubcategory,
                    'condition': getCondition,
                    //image will be added
                  };

                  //var body =  json.encode(data);

                   //var response = await http.post(url,
                    //  headers: {"Content-Type": "application/json"},
                    //  body: body);
                  //final prefs = await SharedPreferences.getInstance();
                  //prefs.setString('token', response.body);
                  //print("${response.request}");
                  //print("${response.statusCode}");
                  //print("${response.body}");

                 // return response;
                }
                //postRequest();
                print('item sent');
                */
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
