import 'package:sekolahku/domain/student.dart';
import 'package:sekolahku/repository/student_repository.dart';

class StudentService {
  final StudentRepository repository;

  const StudentService(this.repository);

  void createStudent(Student domain) {
    return repository.create(domain);
  }

  List<Student> findAllStudents() {
    return repository.findAll();
  }

  Student findStudentBy({int index}) {
    return repository.findOne(index);
  }
  
  void deleteStudentBy({ int index}) {
    return repository.delete(index);
  }
}