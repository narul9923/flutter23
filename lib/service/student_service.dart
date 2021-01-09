import 'package:sekolahku/domain/student.dart';
import 'package:sekolahku/repository/student_repository.dart';
import 'dart:async';
class StudentService {
  final StudentRepository repository;

  const StudentService(this.repository);

  Future<int> createStudent(Student domain) {
    return repository.create(domain);
  }

  Future<List<Student>> findAllStudents() {
    return repository.findAll();
  }

  Future<Student> findStudentBy({int index}) {
    return repository.findOne(index);
  }
  
  Future<int> deleteStudentBy({ int index}) {
    return repository.delete(index);
  }
}