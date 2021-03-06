import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:left_over/Screens/Account/account_screen.dart';
import 'package:left_over/Screens/Login/components/background.dart';
import 'package:left_over/Screens/MyListings/components/my_listings_item_body.dart';
import 'package:left_over/Screens/MyListings/my_listings_screen.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_date_field.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/Screens/item/components/categorries.dart';
import 'package:left_over/Screens/item/item_screen.dart';

import 'package:http/http.dart' as http;
import 'package:left_over/constants.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var nameController = TextEditingController();
  var uploadEndPoint = Uri.parse(dotenv.env['API_URL'] + "/image");
  Future<File> file;
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  static int selectedCategoryIndex = 0;
  static int defaultCategory = selectedCategoryIndex; // both 0 at the beginning
  //static int imageMethod; //0 for gallery , 1 for camera

  static List<List> spinnerItems = [
    ['Bakery', 'Charcuterie', 'GreenGrocery','Other'],
    [
      'TopWear',
      'BottomClothing',
      'Book',
      'Shoes',
      'Accessories',
      'Decoration',
      'Tools',
      'Other'
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
        file = null;
        base64Image = null;
        tmpFile = null;
        nameController.clear();
        getItemName = "";
        getSubcategory = "";
        getCondition = "";
      }
      if (selectedCategoryIndex == 1) {
        conditiondropdownvalue =
            conditionList.elementAt(selectedConditionIndex);
      }
      subdropdownvalue = subcategory.elementAt(selectedSubIndex);

      /*if(imageMethod == 0){
        file = ImagePicker.pickImage(source: ImageSource.gallery);
      }else if(imageMethod == 1){
        file = ImagePicker.pickImage(source: ImageSource.camera);
      }*/
    });
  }

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
                  print('upload from gallery is selected');
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
                  print('upload from camera is selected');
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
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  chooseImageFromCamera() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
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
      print("after Save Actions");
      print(response.statusCode);
      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        print(body["_id"]);

        if (getItemName != "" && getCondition != "" && getSubcategory != "") {
          await uploadItem(body["_id"]);
          //navigator to item datail page
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyListingsItemScreen()),
          );
          final scaffold = ScaffoldMessenger.of(context);
          scaffold.showSnackBar(
            SnackBar(
              content: const Text(
                'Item Successfully Added',
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
          txt.clear();
          getItemName = "";
          getSubcategory = "";
          getCondition = "";
        }
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
    } else {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text(
            'Please upload an image!',
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

  uploadItem(String imageId) async {
    print("Inside Upload Item");
    var url = Uri.parse(dotenv.env['API_URL'] + "/item/");

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var userid = payload["id"];
    getCategory = CategoriesState.categories[CategoriesState.selectedIndex];
    getSubcategory = subdropdownvalue;
    Map data = null;

    if (getCategory == "Consumable") {
      data = {
        'user': {'id': userid},
        'itemName': getItemName,
        'category': getCategory,
        'subCategory': getSubcategory,
        'expirationDate': getCondition,
        'itemImage': imageId
      };
    } else {
      data = {
        'user': {'id': userid},
        'itemName': getItemName,
        'category': getCategory,
        'subCategory': getSubcategory,
        'itemCondition': conditiondropdownvalue,
        'itemImage': imageId
      };
    }
    Map<String, String> headers = new Map<String, String>();
    headers["Authorization"] = "Bearer " + token;
    headers["Content-Type"] = "application/json";

    var body = json.encode(data);
    print(body);

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode != 201) {
      var deleteUrl = Uri.parse(dotenv.env['API_URL'] + "/item/" + imageId);
      await http.delete(deleteUrl, headers: headers);
    }
    print("${response.request}");
    print("${response.statusCode}");
    print("${response.body}");

    // return response;
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 70,
              child: Image.file(
                snapshot.data,
                fit: BoxFit.fill,
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_rounded),
              color: Colors.white,
              onPressed: () {
                file = null;
                base64Image = null;
                tmpFile = null;
                getStateOfCategories();
              },
            )
          ]);
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            style: TextStyle(color: Colors.white),
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
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add Item",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 10),
                        child: Categories(),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(children: [
                      RoundedInputField(
                        hintText: "Item Name",
                        icon: Icons.edit,
                        onChanged: (value) {
                          getItemName = value;
                        },
                        controller: nameController,
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
                                txt.text =
                                    DateFormat('dd-MM-yyyy').format(date);
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
                          itemHeight: 60,
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
                              itemHeight: 60,
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
                    file = null;
                    base64Image = null;
                    tmpFile = null;
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
                    uploadImage();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
