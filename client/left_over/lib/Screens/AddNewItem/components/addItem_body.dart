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

  static List <String> spinnerItems = [
    'One', 
    'Two', 
    'Three', 
    'Four', 
    'Five'
    ] ;

    static List <String> conditionList = [
    'new', 
    'almost new', 
    'underused', 
    'tolerable', 
    'old'
    ] ;

    String dropdownvalue = spinnerItems.elementAt(0);
    String conditiondropdownvalue = conditionList.elementAt(0);

 
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
            RoundedButton(
              text: "Add Image",
              color: bgreen,
              textColor: Colors.white,
              press: () {
                print("add image is pressed");
              },
            ),
            RoundedInputField(
              hintText: "Item Name",
              icon: Icons.edit,
              onChanged: (value) {
                getItemName = value;
              },
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
              
              onChanged: (bool state) {
              //Use it to manage the different states
                print('Current State of SWITCH IS: $state');
                if(state == true){
                  getCategory='reusable';
                }else{
                  getCategory='consumable';
                }
              },
            ),
            DropdownButton<String>(
            value: dropdownvalue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.red, fontSize: 18),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String data) {
                dropdownvalue = data;
                getSubcategory =dropdownvalue;
            },
            items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
            RoundedDateField(
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
                }),
            DropdownButton<String>(
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
          ),
          RoundedButton(
              text: "SAVE",
              color: bgreen,
              textColor: Colors.white,
              press: () {
                print("SAVE is pressed");
              },
            ),
          ],
        ),
      ),
    );
  }
}
