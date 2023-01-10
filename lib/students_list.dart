import 'package:flutter/material.dart';
import 'package:students/student_detail.dart';
import 'dart:async';
import 'package:students/models/student.dart';
import 'package:students/utilities/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StudentsState();
  }
}

class StudentsState extends State<StudentsList> {
  SQL_Helper helper = new SQL_Helper();
  List<Student> studentsList = [
    Student('mohammed ', ' lorim posdafp0o jsdpof posjkf sd f', 1,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('Sadd ', ' lorim posdafp0o jsdpof posjkf sd f', 2,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('mmed ', ' lorim posdafp0o jsdpof posjkf sd f', 1,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('mopd ', ' lorim posdafp0o jsdpof posjkf sd f', 1,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('ohamd ', ' lorim posdafp0o jsdpof posjkf sd f', 1,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('posdafp0o ', ' lorim posdafp0o jsdpof posjkf sd f', 1,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('mohammed ', ' lorim posdafp0o jsdpof posjkf sd f', 2,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('posd ', ' lorim posdafp0o jsdpof posjkf sd f', 1,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('afp0o ', ' lorim posdafp0o jsdpof posjkf sd f', 2,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('Mojahed ', ' lorim posdafp0o jsdpof posjkf sd f', 2,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('Ahmed ', ' lorim posdafp0o jsdpof posjkf sd f', 1,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
    Student('Amani ', ' lorim posdafp0o jsdpof posjkf sd f', 1,
        '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
  ];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (studentsList == null) {
      var studentsList = <List<Student>>[];
      updateListView();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Students"),
        ),
        body: getStudentsList(), //يعرف ليست اسمها جيت ستيودنت
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToStudent(Student('', '', 0, ''), "Edit Student");
          },
          tooltip: 'Add Student',
          child: const Icon(Icons.add),
        ));
  }

  ListView getStudentsList() {
    return ListView.builder(
        itemCount: studentsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    studentsList[index].pass == 2 ? Colors.red : Colors.amber,
                child: studentsList[index].pass == 2
                    ? Icon(Icons.close)
                    : Icon(Icons.check),
              ),
              title: Text(this.studentsList[index].name),
              subtitle: Text(this.studentsList[index].description +
                  " | " +
                  this.studentsList[index].date),
              trailing: const Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onTap: () {
                navigateToStudent(this.studentsList[index], "Edit Student");
              },
            ),
          );
        });
  }

  Color isPassed(Student student) {
    switch (student.pass) {
      case 1:
        return Colors.amber;
        break;
      case 2:
        return Colors.red;
        break;
      default:
        return Colors.amber;
    }
  }

  Icon getIcon(Student student) {
    switch (student.pass) {
      case 1:
        return Icon(Icons.check);
        break;
      case 2:
        return Icon(Icons.close);
        break;
      default:
        return Icon(Icons.check);
    }
  }

  void _delete(BuildContext context, Student student) async {
    int ressult = await helper.deleteStudent(student.id);
    if (ressult != 0) {
      _showSenckBar(context, "Student has been deleted");
      updateListView();
    }
  }

  void _showSenckBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Student>> students = helper.getStudentList();
      students.then((theList) {
        setState(() {
          this.studentsList = theList;
          this.count = theList.length;
        });
      });
    });
  }

  void navigateToStudent(Student student, String appTitle) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StudentDetail(student, appTitle);
    }));
  }
}
