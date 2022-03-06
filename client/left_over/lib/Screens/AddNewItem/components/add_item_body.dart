import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:left_over/Screens/Login/components/background.dart';
import 'package:left_over/components/rounded_input_field.dart';
import 'package:left_over/components/rounded_date_field.dart';
import 'package:left_over/components/rounded_button.dart';
import 'package:left_over/Screens/item/components/categorries.dart';

import 'package:left_over/constants.dart';

class AddNewItemBody extends StatelessWidget {
  var getItemName = "";
  var getCategory = "";
  var getSubcategory = "";
  var getCondition = "";
  var getSharerId = "";
  var getImage = "";
  var txt = TextEditingController();

  static List<String> spinnerItems = ['One', 'Two', 'Three', 'Four', 'Five'];

  static List<String> conditionList = [
    'new',
    'almost new',
    'underused',
    'tolerable',
    'old'
  ];

  String dropdownvalue = spinnerItems.elementAt(0);
  String conditiondropdownvalue = conditionList.elementAt(0);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Padding(
            //padding: const EdgeInsets.only(top: 5, left: 20.0),
            //child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //children: [
            Text(
              "Add Item",
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
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
                            maxTime: DateTime.now().add(Duration(days: 7)),
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
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      }),
                ])),
            /*
            SizedBox(
                width: 160,
                height: 60,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: LiteRollingSwitch(
                    //initial value
                    value: true,
                    textOn: 'Reusable',
                    textOff: 'Consumable',
                    colorOn: lightBlueColor,
                    colorOff: bDarkBlue,
                    iconOn: Icons.autorenew,
                    iconOff: Icons.restaurant,
                    textSize: 12.0,
                    onChanged: (bool state) {
                      //Use it to manage the different states
                      print('Current State of SWITCH IS: $state');
                      if (state == true) {
                        getCategory = 'reusable';
                      } else {
                        getCategory = 'consumable';
                      }
                    },
                  ),
                )),*/

            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownvalue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style:
                          TextStyle(color: lightPinkBlockColor, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: lightPinkBlockColor,
                      ),
                      onChanged: (String data) {
                        dropdownvalue = data;
                        getSubcategory = dropdownvalue;
                      },
                      items: spinnerItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      value: conditiondropdownvalue,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: pinkBlockColor, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: pinkBlockColor,
                      ),
                      onChanged: (String data) {
                        conditiondropdownvalue = data;
                        getCondition = conditiondropdownvalue;
                      },
                      items: conditionList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                )),
            RoundedButton(
              text: "UPLOAD PHOTO",
              color: lightBackgroundColor,
              textColor: lightBlueBlockColor,
              press: () {
                print("add image is pressed");
              },
            ),
            RoundedButton(
              text: "SAVE",
              color: lightBlueBlockColor,
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
