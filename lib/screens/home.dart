import 'package:flutter/material.dart';
import 'package:sekolahku/domain/student.dart';
import 'package:sekolahku/screens/detail_student.dart';
import 'package:sekolahku/screens/form_student.dart';
import 'package:sekolahku/service/app_service.dart';
import 'package:sekolahku/util/capitalize.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //List<Student> _students;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sekolah ku'),
      ),
      body: FutureBuilder<List<Student>>(
        future: AppService.studentService.findAllStudents(),
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) ||
              snapshot.connectionState == ConnectionState.waiting) {
            // print('project snapshot data is: ${snapshot.data}');
            return LinearProgressIndicator();
          } else if (snapshot.data.length == 0) {
            return Container();
          }
          
          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (BuildContext context, int i) => Divider(
              color: Colors.grey[400],
            ),
            itemBuilder: (BuildContext context, int i) {
              final Student student = snapshot.data[i];
              return ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailStudent(id: student.id)
                    )
                  );
                },
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
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormStudent(title: 'Buat siswa')
            ),
          );
        },
        child: Icon(Icons.add)
      ),
    );
  }
}