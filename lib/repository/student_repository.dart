import 'package:sekolahku/domain/student.dart';
import 'package:sekolahku/seed/seed_student.dart';

class StudentRepository {
  List<Student> students = generateStudents();
  
  void create(Student domain) {
    students.add(domain);
  }

  List<Student> findAll() {
    return students;
  }

  Student findOne(int index) {
    return students[index];
  }

  void delete(int index) {
    students.removeAt(index);
  }
}