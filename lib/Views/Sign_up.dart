import 'dart:async';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/Model/Login_model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter_app_1/util/constant.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_app_1/util/Utilfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Prescription_view.dart';



class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}



Future<UserModel> createUser(String email, String password) async{
                            //double Latitude,double Longitude,String Address
  final String apiUrl = "https://reqres.in/api/users";

  //Map<String,String> headers = {'Content-Type':'application/json','Authorization': Token};
  final msg = jsonEncode({"email":email,"password":password
                //"Latitude": Latitude,"Longitude" : Longitude,"Address" : Address
  });

  final response = await http.post(apiUrl,
    //  headers: headers,// <String, String>{
        //'Content-Type': 'application/json, charset=UTF-8'
      //},
      body: msg,/*{
        "email": email,
        "password": password,
        //"Latitude": Latitude,
        //Longitude" : Longitude",
        //"Address" : Address

  }*/);


  if(response.statusCode == 201){
   //response.body ={"ID": "78", "EMAIL_ID": "test@123", "RESPONSE_CODE":"200" , "RESPONSE_MESSAGE": "Record Created Successfully"};
    final responseString = '''{"ID": 78, "EMAIL_ID": "test@123", "RESPONSE_CODE":200 , "RESPONSE_MESSAGE": "Record Created Successfully"}''';//response.body;

    Map parsedJson = json.decode(responseString);
     if(parsedJson['RESPONSE_CODE']==200)
       {
        /* Navigator.push(
            context,BouncyPageRoute(widget: Landingscreen()));
         }
         ));*/
       }
     else if(parsedJson['RESPONSE_CODE']==201)
       {
         //show alert dialog with Email_ID already exists
         return showDialog(
           builder: (context) => new AlertDialog(
             content: new Text(EMAIL_ID_EXISTS),
             actions: <Widget>[
               new FlatButton(
                   child: Text("ok",style: TextStyle(fontSize: 20)),
                   onPressed: () {
                     Navigator.pop(context);
                   }
               ),
             ],
           ),
         );
       }

    int User_ID = parsedJson['ID'];
    print(User_ID);
    print(parsedJson);
    //return  //userModelFromJson(responseString);
  }else{
    return showDialog(
       // context: context,
        builder: (context) => new AlertDialog(
      content: new Text(SERVER_ERROR),
      actions: <Widget>[
        new FlatButton(
            child: Text("ok",style: TextStyle(fontSize: 20)),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ],
    ),
    );
  }
}



class _SignupPageState extends State<SignupPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  UserModel _user;

  String _email;
  String _password;
  Position _currentPosition;
  String _currentAddress;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 // String result = '';

/*
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _connectionStatus = result.toString();

          print(_connectionStatus);
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            checkstatus(_connectionStatus);
            _getCurrentLocation();

          }
          else
          {
            checkstatus(_connectionStatus);
          }
        });
    //this.widget.presenter.counterView = this as CounterView;
  }
*/
  @override
  void dispose() {
  //  subscription.cancel();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {

    return /*WillPopScope(
        onWillPop: _onBackPressed,
    child: */ new Scaffold(
        appBar: AppBar(
            title: Text(APPBAR_SIGNUP, style: TextStyle(fontSize: 25),),
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
                              //controller: emailController,
                              style:
                              TextStyle(fontSize: 22.0, color: Color.fromRGBO(100, 100, 100, 1)),
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: EMAIL,
                                  labelStyle: TextStyle(
                                      fontFamily:'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color.fromRGBO(97, 97, 97, 1)
                                  )
                              ),
                              validator: (String val) =>
                              !val.contains('@') ? EMAIL_ERROR :null,
                              onSaved: (val) => _email=val,

                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              //controller: passwordController,
                              style:
                              TextStyle(fontSize: 22.0, color: Color.fromRGBO(100, 100, 100, 1)),
                              controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: PASSWORD,
                                  labelStyle: TextStyle(
                                      fontFamily:'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color.fromRGBO(97, 97, 97, 1)
                                  )
                              ),
                              validator: (val)  =>
                              val.length<6 ? PASSWORD_ERROR :null,
                              onSaved: (val) => _password=val,
                              obscureText: true,
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              style:
                              TextStyle(fontSize: 22.0, color: Color.fromRGBO(100, 100, 100, 1)),
                              decoration: InputDecoration(
                                  labelText: CONFIRM_PASSWORD,
                                  labelStyle: TextStyle(
                                      fontFamily:'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color.fromRGBO(97, 97, 97, 1)
                                  )
                              ),
                              validator: (val) {
                            if(val != passwordController.text)
                              return 'it should match with Password';
                            return null;
                              },
                              obscureText: true,
                            ),
                          ]
                      )
                  ),
                ),
                 SizedBox(height: 32),

              //    _user == null ? Container() :
               //   Text("The user ${_user.email},is created successfully"),


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
                        String result = checkConnectivity1();
                        result == 'None' ? Dialogs.showGeneralDialog(context, _keyLoader,NETWORK_CONNECTION_ERROR) :
                        createUser(emailController.text, passwordController.text);

                //final UserModel user = await createUser(email, password);//_currentPosition.latitude,
                                                        //_currentPosition.longitude,_currentAddress);

             //   setState(() {
             //     _user = user;
             //   });


                        //Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //return pass();
                      },
                      child: Center(
                        child: Text(
                          SIGNUP_BUTTON,
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


  Future<UserModel> createUser(String email, String password) async{
    //double Latitude,double Longitude,String Address
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dialogs.showLoadingDialog(context, _keyLoader);
    final String deviceID = sharedPreferences.getString('Device_ID');
    final String apiUrl = "https://reqres.in/api/users";

    //Map<String,String> headers = {'Content-Type':'application/json','Authorization': Token};
    final msg = jsonEncode({"email":email,"password":password
      //"Latitude": Latitude,"Longitude" : Longitude,"Address" : Address
    });
    try {
      final response = await http.post(apiUrl,
        //  headers: headers,// <String, String>{
        //'Content-Type': 'application/json, charset=UTF-8'
        //},
        body: msg,
      ).timeout(const Duration(seconds: 10));


      if (response.statusCode == 201) {
        //response.body ={"ID": "78", "EMAIL_ID": "test@123", "RESPONSE_CODE":"200" , "RESPONSE_MESSAGE": "Record Created Successfully"};
        final responseString = '''{"ID": 78, "EMAIL_ID": "test@123", "RESPONSE_CODE":200 , "RESPONSE_MESSAGE": "Record Created Successfully"}'''; //response.body;

        Map parsedJson = json.decode(responseString);

        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (parsedJson['RESPONSE_CODE'] == 200) {
          sharedPreferences.setString('email', email);
          //sharedPreferences.setString('User_ID', parsedJson['ID']);

          Navigator.push(
              context, BouncyPageRoute(widget: Landingscreen()));
        }
        else if (parsedJson['RESPONSE_CODE'] == 201) {
          //show alert dialog with Email_ID already exists
          Dialogs.showGeneralDialog(context, _keyLoader,parsedJson['RESPONSE_MESSAGE']);
        }

        int User_ID = parsedJson['ID'];
        print(User_ID);
        print(parsedJson);
        //return  //userModelFromJson(responseString);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Dialogs.showGeneralDialog(
            context, _keyLoader, SERVER_ERROR);
      }
    } on TimeoutException catch (_) {
      print('timeout');
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      Dialogs.showGeneralDialog(context, _keyLoader,CONNECTION_TIMEOUT);
    }
  }
    


 /* void checkstatus(String resultval) {
    setState(() {
      result = resultval;
    });
  }*/

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}



