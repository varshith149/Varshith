import 'package:flutter/material.dart';
//import 'package:flutter_app/views/Login_view.dart';
//import 'dart:async';


class resetPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}


class _SignupPageState extends State<resetPage> {
  //GlobalKey<NavigatorState> _key = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email;
  /*
  Future<bool> _onBackPressed() {
    Navigator.of(context).pushNamed('/login_page');

    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            child: Text("NO"),
            onPressed: () => Navigator.pop(context,false),
          ),
          new FlatButton(
            child: Text("Yes"),
            onPressed: () => Navigator.pop(context,true),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('true'),
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
  }*/


  @override
  Widget build(BuildContext context) {
    return /*WillPopScope(
      onWillPop: () async {
        if (_key.currentState.canPop()) {
          _key.currentState.pop();
          return false;
        }
        return true;
      },
      child:*/ new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Forgot Password', style: TextStyle(fontSize: 25),),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(236, 85,156,1),
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        /* Container(
                  padding: EdgeInsets.fromLTRB(15.0, 100, 0.0, 0.0),
                  child: Text(
                  'Easymedico',
                    style: TextStyle(
                    fontSize: 50,fontWeight: FontWeight.bold, color: Colors.black)
        ),
        ),
        ],
        ),
        ),*/
                        Container (
                          padding: EdgeInsets.fromLTRB(15, 100, 15, 0),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style:
                                TextStyle(fontSize: 22.0, color: Color.fromRGBO(100, 100, 100, 1)),
                                decoration: InputDecoration(
                                    labelText: 'Email *',
                                    labelStyle: TextStyle(
                                        fontFamily:'Montserrat',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(97, 97, 97, 1)
                                    )

                                  //focusedBorder: UnderlineInputBorder(
                                  //borderSide: BorderSide(color: Colors.green)
                                  //)
                                ),
                                validator: (String val) =>
                                !val.contains('@') ? 'Invalid Email' :null,
                                onSaved: (val) => _email=val,
                              ),
                              SizedBox(height:55.0),
                              FlatButton(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 40,
                                  child: Material(

                                    borderRadius: BorderRadius.circular(0.0),
                                    shadowColor: Colors.greenAccent,
                                    color: Color.fromRGBO(4, 154, 232, 1),
                                    elevation: 7.0,
                                    child: InkWell(
                                      onTap: () {
                                        if(!_formKey.currentState.validate()){
                                          return;
                                        }
                                        _formKey.currentState.save();
                                        //this.widget.presenter.onButton1Clicked();
                                        //Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        //return pass();
                                      },
                                      child: Center(
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                ),
              ]
          ),
        )
    );

  }}

//written in appbar
/*
leading: new IconButton(
icon: new
Icon(Icons.arrow_back),
onPressed: () {
Navigator.of(context).pushNamed('/view_component');
}),*/
