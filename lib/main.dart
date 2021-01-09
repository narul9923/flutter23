import 'package:flutter/material.dart';
import 'package:sekolahku/basic/button.dart';
import 'package:sekolahku/basic/center_container.dart';
import 'package:sekolahku/basic/form_label.dart';
import 'package:sekolahku/basic/listview.dart';
import 'package:sekolahku/screens/detail_student.dart';
import 'package:sekolahku/screens/form_student.dart';
import 'package:sekolahku/screens/home.dart';
import 'package:sekolahku/service/app_service.dart';
import 'package:sekolahku/util/lifecycle_event_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool databaseIsReady = false;
  LifecycleEventHandler _lifecycleEventHandler;

  @override
  void initState() {
    super.initState();
    AppService.open().then((database) {
      setState(() {
        databaseIsReady = true;
      });
    });
    _lifecycleEventHandler = LifecycleEventHandler(onResume: (state) async {
      return AppService.open().then((database) {
        setState(() {
          databaseIsReady = true;
        });

        return databaseIsReady;
      });
    }, onSuspend: (state) async {
      return AppService.close().then((val) {
        setState(() {
          databaseIsReady = false;
        });

        return databaseIsReady;
      });
    });
    WidgetsBinding.instance.addObserver(_lifecycleEventHandler);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleEventHandler);
    AppService.close().then((val) {
      setState(() {
        databaseIsReady = false;
      });
    });
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: databaseIsReady 
            ? Home()
            : Scaffold(
              body:Center(
                child: CircularProgressIndicator(),
              )
            ),
    );
  }
}