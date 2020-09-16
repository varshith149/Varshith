import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app/viewmodel/Login_model.dart';
//import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //UserModel _user;

  String _email;
  String _password;

  void backbutton() {
    Navigator.pop(context);
  }
/*
  Future<UserModel> createUser(String name, String jobTitle) async{
    final String apiUrl = "https://reqres.in/api/users";

    final response = await http.post(apiUrl, body: {
      "name": name,
      "job": jobTitle
    });

    if(response.statusCode == 201){
      final String responseString = response.body;

      return userModelFromJson(responseString);
    }else{
      return null;
    }
  }
*/

  @override
  Widget build(BuildContext context) {

    //  final TextEditingController emailController = TextEditingController();
    //  final TextEditingController passwordController = TextEditingController();


    return new/* WillPopScope(
        onWillPop: (){
      backbutton();
      //return Future.value(false);
    },
    child: */Scaffold(
        appBar: AppBar(
            title: Text('Sign Up', style: TextStyle(fontSize: 25),),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(236, 85, 156, 1)
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container (
                  padding: EdgeInsets.fromLTRB(15, 70, 15, 0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                          children: <Widget>[
                            TextFormField(
                              style:
                              TextStyle(fontSize: 22.0, color: Color.fromRGBO(100, 100, 100, 1)),
                              //controller: emailController,
                              decoration: InputDecoration(
                                  labelText: 'Email *',
                                  labelStyle: TextStyle(
                                      fontFamily:'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color.fromRGBO(97, 97, 97, 1)
                                  )
                              ),
                              validator: (String val) =>
                              !val.contains('@') ? 'Invalid Email' :null,
                              onSaved: (val) => _email=val,

                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              style:
                              TextStyle(fontSize: 22.0, color: Color.fromRGBO(100, 100, 100, 1)),
                              //controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Password *',
                                  labelStyle: TextStyle(
                                      fontFamily:'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color.fromRGBO(97, 97, 97, 1)
                                  )
                              ),
                              validator: (val)  =>
                              val.length<6 ? 'Password too short' :null,
                              onSaved: (val) => _password=val,
                              obscureText: true,
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              style:
                              TextStyle(fontSize: 22.0, color: Color.fromRGBO(100, 100, 100, 1)),
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password *',
                                  labelStyle: TextStyle(
                                      fontFamily:'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color.fromRGBO(97, 97, 97, 1)
                                  )
                              ),
                              validator: (val)  =>
                              val !=  _password  ? 'it should match with Password' :null,
                              onSaved: (val) => _password=val,
                              obscureText: true,
                            ),
                          ]
                      )
                  ),
                ),
                // SizedBox(height: 32,),

                //    _user == null ? Container() :
                //  Text("The user ${_user.email}, ${_user.id} is created successfully at time ${_user.createdAt.toIso8601String()}"),


                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  width: 150,
                  child: Material(
                    borderRadius: BorderRadius.circular(0.0),
                    shadowColor: Colors.greenAccent,
                    color: Color.fromRGBO(4, 154, 232, 1),
                    elevation: 7.0,
                    child: InkWell(
                      onTap: () async {
                        if(!_formKey.currentState.validate()){
                          return;
                        }
                        _formKey.currentState.save();
/*
                final String name = emailController.text;
                final String jobTitle = passwordController.text;

                final UserModel user = await createUser(name, jobTitle);
*/

                        //Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //return pass();
                      },
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),



              ]

          ),
        )

    );

  }

}

