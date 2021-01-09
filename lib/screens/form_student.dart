import 'package:flutter/material.dart';
import 'package:sekolahku/basic/form_label.dart';
import 'package:sekolahku/domain/student.dart';
import 'package:sekolahku/screens/home.dart';
import 'package:sekolahku/service/app_service.dart';
import 'package:sekolahku/util/capitalize.dart';
import 'package:sekolahku/widgets/check_box.dart';
import 'package:sekolahku/widgets/radio_button.dart';

class FormStudent extends StatefulWidget {
  final String title;

  const FormStudent({Key key, @required this.title}) : super(key: key);
  @override
  _FormStudentState createState() => _FormStudentState();
}

class _FormStudentState extends State<FormStudent> {
  
  static const genders = Student.genders;
  static const grades = Student.grades;
  static const hobbies = Student.hobbiesList;

  final _formKey = GlobalKey<FormState>();
  double _gap = 16.0;
  FocusNode _firstNameFocus, _mobilePhoneFocus, _lastNameFocus;
  String _firstName, _lastName, _mobilePhone, _address, _gender, _grade;
  List<String> _hobbies = [];
  final List<DropdownMenuItem<String>> _gradeItems = grades
      .map((String val) => DropdownMenuItem<String>(
            value: val,
            child: Text(val.toUpperCase()),
          ))
      .toList();

  @override
  void initState() {
    super.initState();

    _gender = 'pria';
    _firstNameFocus = FocusNode();
    _mobilePhoneFocus = FocusNode();
    _lastNameFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _firstNameFocus.dispose();
    _mobilePhoneFocus.dispose();
    _lastNameFocus.dispose();
    _formKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            focusNode: _firstNameFocus,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nama Depan',
                            ),
                            onSaved: (String value) {
                              // will trigger when saved
                              print('onsaved firstName: $value');
                              _firstName = value;
                            },
                            onFieldSubmitted: (term) {
                              // process
                              _firstNameFocus.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_lastNameFocus);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            focusNode: _lastNameFocus,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nama Belakang',
                            ),
                            onSaved: (String value) {
                              // will trigger when saved
                              print('onsaved _lastName $value');
                              _lastName = value;
                            },
                            onFieldSubmitted: (term) {
                              // process
                              _lastNameFocus.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_mobilePhoneFocus);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _gap,
                  ),
                  TextFormField(
                    focusNode: _mobilePhoneFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'No. Hp',
                    ),
                    onSaved: (String value) {
                      // will trigger when saved
                      print('onsaved _mobilePhone $value');
                      _mobilePhone = value;
                    },
                    onFieldSubmitted: (term) {
                      // process
                    },
                  ),
                  SizedBox(
                    height: _gap,
                  ),
                  FormLabel('Jenis Kelamin'),
                  Row(
                    children: genders
                        .map((String val) => RadioButton<String>(
                            value: val,
                            groupValue: _gender,
                            label: Text(capitalize(val)),
                            onChanged: (String value) {
                              setState(() => _gender = value);
                            }))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: DropdownButton(
                      value: _grade,
                      hint: Text('Pilih jenjang'),
                      items: _gradeItems,
                      isExpanded: true,
                      onChanged: (String value) {
                        setState(() {
                          _grade = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: _gap,
                  ),
                  FormLabel('Hobi'),
                  Column(
                    children: hobbies
                        .map((String val) => CheckBox(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              value: _hobbies.contains(val),
                              onChanged: (bool value) {
                                setState(() {
                                  if (_hobbies.contains(val)) {
                                    _hobbies.remove(val);
                                  } else {
                                    _hobbies.add(val);
                                  }
                                });
                              },
                              label: capitalize(val),
                            ))
                        .toList(),
                  ),
                  SizedBox(
                    height: _gap,
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Alamat',
                    ),
                    onSaved: (String value) {
                      // will trigger when saved
                      print('onsaved _address $value');
                      _address = value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () {
          final form = _formKey.currentState;
          if (form.validate()) {
            // Process data.
            form.save(); // required to trigger onSaved props
            Student _student = Student();
            _student.firstName = _firstName;
            _student.lastName = _lastName;
            _student.mobilePhone = _mobilePhone;
            _student.grade = _grade;
            _student.gender = _gender;
            _student.hobbies = _hobbies;
            _student.address = _address;
            print(_student);
            AppService.studentService
              .createStudent(_student)
              .then((int idx) => Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false,
              )
            );
          }
        }
      ),
    );
  }
}