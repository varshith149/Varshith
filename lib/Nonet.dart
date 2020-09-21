import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class noNet extends StatefulWidget {
  @override
  _Network createState() => _Network();
}

class _Network extends State<noNet> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(child: Text('No Internet',
      style: TextStyle(
        fontSize: 25,
        color: Colors.black,
      ),)),
    );
  }
}