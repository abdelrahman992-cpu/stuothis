import 'package:flutter/material.dart';
import 'dart:async';
import 'package:students/models/student.dart';
import 'package:students/utilities/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'students_list.dart';

class StudentDetail extends StatefulWidget {
  String screenTitle;

  late Student student;

  StudentDetail(this.student, this.screenTitle);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Students(this.student, screenTitle);
  }
}

class Students extends State<StudentDetail> {
  static var _status = ["successed", "failed"];
  late String screenTitle;
  late Student student;
  SQL_Helper helper = new SQL_Helper();

  Students(this.student, this.screenTitle);
  TextEditingController studentName = new TextEditingController();
  TextEditingController studentDetail = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle();
    studentName.text = student.name;
    studentDetail.text = student.description;
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(screenTitle),
            leading: IconButton(
                onPressed: () {
                  goback();
                },
                icon: Icon(Icons.arrow_back_ios)),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: DropdownButton(
                    items: _status.map((String dropDownItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownItem,
                        child: Text(dropDownItem),
                      );
                    }).toList(),
                    style: textStyle,
                    value: getPassing(student.pass),
                    onChanged: (selectedItem) {
                      setState(() {
                        debugPrint("User Select ${selectedItem}");
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: studentName,
                    style: textStyle,
                    onChanged: (value) {
                      student.name = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Name :",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: studentDetail,
                    style: textStyle,
                    onChanged: (value) {
                      student.description = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Description :",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              //todo
                              //  color: Theme.of(context).primaryColorDark,
                              // textColor: Theme.of(context).primaryColorLight,
                              ),
                          child: Text(
                            'SAVE',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("User Click SAVED");
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              //todo
                              //   color: Theme.of(context).primaryColorDark,
                              // textColor: Theme.of(context).primaryColorLight,
                              ),
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("User Click Delete");
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: null);
  }

  void goback() {
    Navigator.pop(context);
  }

  void setPassing(String value) {
    switch (value) {
      case "successed":
        student.pass = 1;
        break;
      case "failed":
        student.pass = 2;
        break;
    }
  }

  String getPassing(int value) {
    late String pass = _status[0];
    switch (value) {
      case 1:
        pass = _status[0];
        break;
      case 2:
        pass = _status[1];
        break;
    }
    return pass;
  }
}
