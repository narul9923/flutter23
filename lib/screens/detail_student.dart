import 'package:flutter/material.dart';
import 'package:sekolahku/domain/student.dart';
import 'package:sekolahku/service/app_service.dart';
import 'package:sekolahku/util/capitalize.dart';

class DetailStudent extends StatefulWidget {
  @override
  _DetailStudentState createState() => _DetailStudentState();
}

class _DetailStudentState extends State<DetailStudent> {
  Student _student;

  @override
  void initState() { 
    super.initState();
    _student = AppService.studentService.findStudentBy(index: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Siswa'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){},
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                "assets/images/${_student.gender}.png",
                width: 150,
                height: 150,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text(_student.fullName),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(_student.mobilePhone),
            ),
            ListTile(
              leading: Icon(Icons.label),
              title: Text(capitalize(_student.gender)),
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text(_student.grade.toUpperCase()),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(_student.address),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(_student.hobbies.map((val) => capitalize(val)).join(', ')),
            ),
          ],
        ),
      ),
    );
  }
}