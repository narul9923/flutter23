import 'dart:core';
import 'dart:async';
import 'package:sekolahku/domain/student.dart';
import 'package:sekolahku/model/model_provider.dart';
import 'package:sekolahku/seed/seed_student.dart';

class StudentRepository {
  static const String tableName = 'Siswa';
  List<Student> students = generateStudents();
  final ModelProvider modelProvider;

  StudentRepository(this.modelProvider);

  Future<int> create(Student domain) {
    final siswa = domain.toMap();
    print('[db] is creating $siswa');
    return modelProvider
        .getDatabase()
        .then((database) => database.insert(tableName, siswa));
  }

  Future<List<Student>> findAll() {
    var sql = '''
    SELECT
        id_siswa AS id,
        first_name AS firstName,
        last_name AS lastName,
        mobile_phone AS mobilePhone,
        gender,
        grade,
        hobbies,
        address,
        created_at AS createdAt,
        updated_at AS updatedAt
      FROM
        $tableName
      ORDER BY created_at DESC;
    ''';
    return modelProvider
        .getDatabase()
        .then((database) => database.rawQuery(sql))
        .then((data) {
      print('[db] success retrieve $data');
      if (data.length == 0) {
        return [];
      }
      final List<Student> students = [];
      for (var i = 0; i < data.length; i++) {
        Student student = Student();
        student.fromMap(data[i]);
        students.add(student);
      }

      return students;
    });
  }

  Future<Student> findOne(int id) {
    final sql = '''
      SELECT
        id_siswa AS id,
        first_name AS firstName,
        last_name AS lastName,
        mobile_phone AS mobilePhone,
        gender,
        grade,
        hobbies,
        address,
        created_at AS createdAt,
        updated_at AS updatedAt
      FROM
        $tableName
      WHERE id_siswa = $id;
    ''';
    return modelProvider
        .getDatabase()
        .then((database) => database.rawQuery(sql))
        .then((data) {
      print('[db] success retrieve $data by id = $id');
      if (data.length == 1) {
        final Student student = Student();
        student.fromMap(data[0]);

        return student;
      }

      return null;
    });
    // return students[index];
  }

  Future<int> delete(int index) {
    return modelProvider
      .getDatabase()
      .then((database) => 
        database.delete(tableName, where: 'id_siswa = ?', whereArgs: [index])
      );
  }
}