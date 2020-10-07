import 'dart:async';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app2/Model/Model.dart';
import 'package:flutter_app2/Views/Login_view.dart';
import 'package:flutter_app2/Views/Prescription_view.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter_app2/util/Constant.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_app2/util/Util_file.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}



class _SignupPageState extends State<SignupPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  //UserModel _user;

  String _email;
  String _password;
  Position _currentPosition;
  String _currentAddress;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String result = '';
  bool status_GPS = false;


 /* var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;*/
    /*   checkstatus(result);*/
   /* connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _connectionStatus = result.toString();
          print(1);
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
        });*/
    //this.widget.presenter.counterView = this as CounterView;
 // }

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
    checkConnectivity1();
    _check_GPS_connectivity();
    if(status_GPS==true)
    {
      //print(1);
      _getCurrentLocation();
    }

//_getCurrentLocation();
    //checkstatus(result);
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
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null: EMAIL_ERROR,
                              onSaved: (val) => _email=val,
                              //!val.contains('@') ? EMAIL_ERROR :null,
                              //onSaved: (val) => _email=val,

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
                       // print(1);
                      //  _getCurrentLocation();
                        print(2);

                        if(status_GPS==false)
                          {
                          Dialogs.showGeneralDialog(context, _keyLoader,ENABLE_LOCATION);
                          return ;
                        }

                       // String result = checkConnectivity1();
                        result == 'None' ? Dialogs.showGeneralDialog(context, _keyLoader,NETWORK_CONNECTION_ERROR) :
                        createUser(emailController.text, passwordController.text,_currentPosition.latitude.toStringAsPrecision(4),
                                  _currentPosition.longitude.toStringAsPrecision(4),_currentAddress);

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


  Future<void> createUser(String email, String password, //) async{
            String Latitude,String Longitude,String Address) async{
  //_getCurrentLocation();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dialogs.showLoadingDialog(context, _keyLoader);
    final String deviceID = sharedPreferences.getString('DEVICE_ID');
    final String apiUrl = URL+'Signup/';
    print(deviceID);

    Map<String,String> headers = {'Content-Type':'application/json','Authorization': Token};
    final msg = jsonEncode({"EMAIL_ID":email,"PASSWORD":password,
      "LATITUDE": Latitude,//_currentPosition.latitude.toStringAsPrecision(4),
      "LONGITUDE" : Longitude, //_currentPosition.longitude.toStringAsPrecision(4),
      "ADDRESS" : Address,
      "DEVICE_ID":deviceID});
    try {
      final response = await http.post(apiUrl,
          headers: headers,
        body: msg,
      ).timeout(const Duration(seconds: 30));
      print(response.body);
      print(response.headers);
      print(response);
      print(response.statusCode);

      if (response.statusCode == 200) {
        //response.body ={"ID": "78", "EMAIL_ID": "test@123", "RESPONSE_CODE":"200" , "RESPONSE_MESSAGE": "Record Created Successfully"};
        final responseString = response.body;//'''{"ID": 78, "EMAIL_ID": "test@123", "RESPONSE_CODE":200 , "RESPONSE_MESSAGE": "Record Created Successfully"}'''; //response.body;
        //final
        Map parsedJson = json.decode(responseString);

        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (parsedJson['RESPONSE_CODE'] == 200) {
          print('Success');
          sharedPreferences.setString('EMAIL_ID', email);
          sharedPreferences.setInt('USER_ID', parsedJson['ID']);
         // Dialogs.showGeneralDialog(context, _keyLoader, parsedJson['REPONSE_MESSAGE']);
          Navigator.push(
              context, BouncyPageRoute(widget: Landingscreen()));
        }
        else if (parsedJson['RESPONSE_CODE'] == 201) {
          print('Failed');
          //show alert dialog with Email_ID already exists
          Dialogs.showGeneralDialog(context, _keyLoader,parsedJson['RESPONSE_MESSAGE']);
        }
        else
          {
            Dialogs.showGeneralDialog(
                context, _keyLoader, SERVER_ERROR);
          }
        //return  //userModelFromJson(responseString);
      }
      else {
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

//  String _networkStatus1 = '';

  Connectivity connectivity = Connectivity();

  void checkConnectivity1() async {
    var connectivityResult = await connectivity.checkConnectivity();
    var conn = getConnectionValue(connectivityResult);
    setState(() {
      result =  conn;
    //  print(result);
    });
  }

// Method to convert the connectivity to a string value
  String getConnectionValue(var connectivityResult) {
    String status = '';
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'Mobile';
        break;
      case ConnectivityResult.wifi:
        status = 'Wi-Fi';
        break;
      case ConnectivityResult.none:
        status = 'None';
        break;
     /* default:
        status = 'None';
        break;*/
    }
    return status;
  }


/*  void checkstatus(String resultval) async {
    SharedPreferences NetPreference = await SharedPreferences.getInstance();
    print(result);
    result = NetPreference.getString('NetResult');
    print(100);
    print(result);
    //setState(() {
      //result = resultval;
    //});
  }*/

  _getCurrentLocation() {
   // print(11);
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
       // print('asdfgh');
        _currentPosition = position;
      });
  //print(_currentPosition);
      _getAddressFromLatLng();
    }).catchError((e) {
      print('abccc');
      print(e);
    });
  }

  _check_GPS_connectivity() async{
   status_GPS = await Geolocator().isLocationServiceEnabled() ;
  // print(status_GPS);
  /* if (status_GPS) {
     print('nice1');
     /*geolocator
         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
         .then((Position position) {
       setState(() {
         _currentPosition = position;
       });
       // print(_currentPosition);

       _getAddressFromLatLng();*/
     }).catchError((e) {
       print(e);
     });*/
   }// else {
     //print('perfect2');
     //Dialogs.showGeneralDialog(context, _keyLoader, ENABLE_LOCATION);
   //}

  //}

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.name},${place.subLocality},${place.locality},${place.thoroughfare},${place.subAdministrativeArea},${place.administrativeArea}, ${place.postalCode}, ${place.country}";
       // print(_currentAddress);
      });
    } catch (e) {
     // print(e);
    }
  }
}