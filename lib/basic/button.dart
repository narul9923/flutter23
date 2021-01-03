import 'package:flutter/material.dart';

class CobaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedButton(
          onPressed: (){
            print('raised pressed');
          },
          child: Text('Login'),
        ),
        FlatButton(
          onPressed: (){
            print('flat button pressed');
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}