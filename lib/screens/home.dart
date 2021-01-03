import 'package:flutter/material.dart';
import 'package:sekolahku/domain/student.dart';
import 'package:sekolahku/service/app_service.dart';
import 'package:sekolahku/util/capitalize.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Student> _students;

  @override
  void initState() { 
    super.initState();
    _students = AppService.studentService.findAllStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sekolahku'),
      ),
      body: ListView.separated(
        itemCount: _students.length,
        separatorBuilder: (BuildContext context, int i) => Divider(
          color: Colors.grey[400],
        ),
        itemBuilder: (BuildContext context, int i) {
          final Student student = _students[i];
          return ListTile(
            onTap: (){},
            leading: Icon(Icons.person),
            title: Text(capitalize(student.fullName)),
            subtitle: Text(capitalize(student.gender)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(student.grade.toUpperCase()),
                Text(student.mobilePhone),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add)
      ),
    );
  }
}