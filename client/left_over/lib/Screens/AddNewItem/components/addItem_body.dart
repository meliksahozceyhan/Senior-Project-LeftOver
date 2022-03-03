// ignore_for_file: sdk_version_set_literal

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:left_over/Screens/Login/components/background.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_password_field.dart';
import 'package:left_over/components/rounded_date_field.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/components/rounded_date_field.dart';


import 'package:left_over/constants.dart';
import 'package:left_over/constants.dart';
import 'package:left_over/Models/Product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;

import 'categorries.dart';
import 'item_card.dart';

class AddNewItemBody extends StatelessWidget {  

  var getItemName = "";
  var getCategory = "";
  var getSubcategory = "";
  var getCondition = "";
  var getSharerId = "";
  var getImage = "";
  var txt = TextEditingController();

  static List <String> subCategoryR = ['TopWear','BottomClothing','Book','Shoes','Accessories','Decoration','Tools'];
  static List <String> subCategoryC = ['Bakery','Charcuterie','GreenGrocery'];
  static List <String> subcategory = subCategoryR;

  static List <String> conditionList = ['Old','UnderUsed','Good','New'];
  String conditiondropdownvalue = conditionList.elementAt(0);

  static bool isReusable = true;

    @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Add Item",
              style: GoogleFonts.comfortaa(fontSize: 45),
              //GoogleFonts.comfortaa(fontSize: 45),
            ),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            ElevatedButton.icon(
              icon: const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
              ),
             onPressed:(){
               print('add image pressed');
             } ,
              label: Text(
                      "Add Image",
                      style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 3, 133, 194),
              fixedSize: const Size(208, 43),
              ),
            ),
            RoundedInputField(
              hintText: "Item Name",
              icon: Icons.edit,
              onChanged: (value) {
                getItemName = value;
              },
            ),
            Title(
              color: Colors.white,
              child: Text('Select a category:')
              ),
            LiteRollingSwitch(
            //initial value
              value: true,
              textOn: 'REUSABLE',
              textOff: 'CONSUMABLE',
              colorOn: bExclamationColor,
              colorOff: bDarkBlue,
              iconOn: Icons.autorenew,
              iconOff: Icons.restaurant,
              textSize: 13.0,              
              onChanged: (bool state) async {
              //Use it to manage the different states
                print('Current State of SWITCH IS: $state');
                if(state == true){
                  getCategory='reusable';
                  subcategory =  subCategoryR;
                  isReusable = true;
                }else{
                  getCategory='consumable';
                  subcategory =  subCategoryC;
                  isReusable = false;
                }
              },
            ),
            Title(
              color: Colors.white,
              child: Text('Select a sub-category:')
            ),
            DropdownButton<String>(
            value: subcategory.elementAt(0) ,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.red, fontSize: 18),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String data) {
                getSubcategory =data;
            },
            items:subcategory.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(), 
          ),
          Visibility(
            visible : !isReusable,
            child :RoundedDateField(
                hintText: "Expiration Date",
                textEditingController: txt,
                onChanged: (value) {
                  getCondition = value;
                },
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime.now().add(Duration(days: 7)), onChanged: (date) {
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
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
              })
            ),
            Visibility(
              visible : isReusable,
              child :DropdownButton<String>(
                value: conditiondropdownvalue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.red, fontSize: 18),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String data) {
                  conditiondropdownvalue = data;
                  getCondition =conditiondropdownvalue;
                },
                items: conditionList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
              );
            }).toList(),
          )
            ),
          RoundedButton(
              text: "SAVE",
              color: bgreen,
              textColor: Colors.white,
              press: () async {
                Future<http.Response> postRequest() async {
                  //var url = Uri.parse(dotenv.env['API_URL'] + "/user/");

                final prefs = await SharedPreferences.getInstance();                
                var token = prefs.getString('token');
                Map<String, dynamic> payload = Jwt.parseJwt(token);
                var userid= payload["id"];

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
                print('item sended');
              
              },
            ),
          ],
        ),
      ),
    );
  }
}
