import 'package:flutter/material.dart';
import 'package:sekolahku/basic/button.dart';
import 'package:sekolahku/basic/center_container.dart';
import 'package:sekolahku/basic/form_label.dart';
import 'package:sekolahku/basic/listview.dart';
import 'package:sekolahku/screens/detail_student.dart';
import 'package:sekolahku/screens/form_student.dart';
import 'package:sekolahku/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FormStudent(title: 'Tambah Siswa'),
    );
  }
}