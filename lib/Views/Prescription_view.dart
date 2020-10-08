import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/Views/Login_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app2/util/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_app2/util/Util_file.dart';
import 'package:intl/intl.dart';

class Landingscreen extends StatefulWidget {
  @override
  _prescription createState() => _prescription();
}

class _prescription extends State<Landingscreen> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();


  static const _popItem= <String>[
    "Logout"
  ];

  static List<PopupMenuItem<String>> _pop = _popItem.map((String val)=>
      PopupMenuItem<String>(
        value: val,
        child: Text(val),
      )
  ).toList();
  String value;


  File imagefile;


  _openGallery(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imagefile = picture ;
    });
    Navigator.of(context).pop();
  }
  /*var picture = await MultiImagePicker.pickImages(maxImages: 5,enableCamera: true);
    this.setState(() {
      imageFile = picture as File;
    });
    Navigator.of(context).pop();
  }*/

  _openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imagefile = picture ;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text('Choose one'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: (){
                  _openGallery(context);
                  /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Multi_Images();
                  }
                  ));                */},
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Camera'),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],

          ),
        ),
      );
    });
  }

  Widget _decideImageView(){
    /*return FutureBuilder<File>(
      future: imagefile ,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Image.file(snapshot.data,width: 500,height: 500,);

          /*return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );*/
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Image.asset('Images/Default_image.jpg',width: 300,height: 400);
        }
      },
    );*/
    final _height = MediaQuery.of(context).size.height-
        MediaQuery.of(context).padding.top-
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;

    if(imagefile == null){
      return Image.asset('Images/Default_image.jpg',width: width,height: _height*0.85);
    }
    else{
      // String base64Image = base64Encode(imagefile.readAsBytesSync());
      // Uint8List image = base64Decode(base64Image);


      //return Image.memory(image);
      return Image.file(imagefile,width:width*1 ,height: _height*0.85,);
    }
  }
  //String fileName = imagefile.path.split("/").last;

  String result = '';


 /* var _connectionStatus = 'Unknown';
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

          }
          else
          {
            checkstatus(_connectionStatus);
          }
        });
    //this.widget.presenter.counterView = this as CounterView;
  }*/

  @override
  void dispose() {
    //subscription.cancel();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    exit(0);
  }



  @override
  Widget build(BuildContext context) {
    checkConnectivity1();


    return WillPopScope(
      onWillPop: ()async {
        _onBackPressed();
        return true;
      },
      child: new Scaffold(
        appBar: AppBar(
          title: Text(APPBAR_PRESCRIPTION,style: TextStyle(fontSize: 18),),
          backgroundColor: Color.fromRGBO(236, 85, 156, 1),
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (String val){
                  //String result = checkConnectivity1();
                  result == 'None' ? Dialogs.showGeneralDialog(context, _keyLoader,NETWORK_CONNECTION_ERROR) :
                  logout_check();
                },
                itemBuilder: (BuildContext context) => _pop
            )
          ],
          leading: new IconButton(
            icon: new
            Icon(Icons.arrow_back),
            onPressed: () => exit(0),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 10),
                  _decideImageView(),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Container(
                            height: 40,
                            width: 150,
                            child: Material(
                              borderRadius: BorderRadius.circular(0),
                              color: Color.fromRGBO(4, 154, 232, 1),
                              elevation: 7.0,

                              child: InkWell(
                                  onTap: () {
                                    _showChoiceDialog(context);
                                  },
                                  child: Center(
                                    child: Text(CAPTURE_BUTTON,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),),
                                  )
                              ),
                            ),
                          ),
                        ),
                        //Expanded(
                        //child: buildGridView(),
                        //),
                        SizedBox(height: 5),
                        FlatButton(
                          child: Container(
                            //alignment: Alignment.center,
                            height: 40,
                            width: 140,
                            child: Material(
                              borderRadius: BorderRadius.circular(0.0),
                              color: Color.fromRGBO(4, 154, 232, 1),
                              elevation: 7.0,
                              child: InkWell(
                                  onTap: () {
                                   // String result = checkConnectivity1();
                                    result == 'None' ? Dialogs.showGeneralDialog(context, _keyLoader,NETWORK_CONNECTION_ERROR) :
                                    Upload(imagefile);
                                  },
                                  child: Center(
                                    child: Text(UPLOAD_BUTTON,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ]
                  )

                ],
              ),
            ),
          ),
        ),

      ),
    );
  }

  Future<void> logout_check() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dialogs.showLoadingDialog(context, _keyLoader);

    final int ID = sharedPreferences.getInt('USER_ID');
    final String email = sharedPreferences.getString('EMAIL_ID');
    final String deviceID = sharedPreferences.getString('DEVICE_ID');
    bool toggleValue = sharedPreferences.getBool('Islogin');
print(ID);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': Token
    };
    final msg = jsonEncode({"id": ID,"EMAIL_ID": email ,"DEVICE_ID": deviceID});

    var jsonResponse = null;
    try {
      var response = await http.post(URL +'Logout/',
        headers: headers,
        body: msg,
      ).timeout(const Duration(seconds: 10));
      print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

        jsonResponse = json.decode(response.body);
        if(jsonResponse['RESPONSE_CODE']==200) {
        toggleValue = false; //!toggleValue;
        print(toggleValue);
        sharedPreferences.setBool("Islogin", toggleValue);

        Navigator.push(
            context, BouncyPageRoute(widget: MyAp()));
        }

        else {
        Dialogs.showGeneralDialog(
               context, _keyLoader, SERVER_ERROR);
        }
      }
      else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Dialogs.showGeneralDialog(context, _keyLoader,SERVER_ERROR);
      }
    } on TimeoutException catch (_) {
      //print('timeout');
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      Dialogs.showGeneralDialog(context, _keyLoader,CONNECTION_TIMEOUT);
    }
  }


  Future<void> Upload(imagefile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String ID = sharedPreferences.getString('User_ID');
    final String deviceID = sharedPreferences.getString('device_ID');
    String filename = imagefile.path.split('/').last;
    print(filename);
    String base64Image = base64Encode(imagefile.readAsBytesSync());
    final DateTime now = DateTime.now();
    print(now);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    String time = "${now.hour}:${now.minute}:${now.second}";
    print(formatted);
    print(time);
    Dialogs.showLoadingDialog(context, _keyLoader);

    Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
    final msg = jsonEncode({"ID":ID,"device_ID":deviceID,"Image_Name":filename,
      "Image_Base64":base64Image,"date":formatted,"Time":time});

    var jsonResponse = null;
    try {
      var response = await http.post("https://reqres.in/api/login",
        headers: headers,
        body:msg,
      ).timeout(const Duration(seconds: 10));


      if(response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
        // if(jsonResponse['RESPONSE_CODE']==200) {
        Dialogs.showGeneralDialog(context, _keyLoader,jsonResponse['RESPONSE_MESSAGE']);


        /*  else if(jsonResponse['RESPONSE_CODE']==202){
       Dialogs.showGeneralDialog(context, _keyLoader,jsonResponse['RESPONSE_MESSAGE']);
        }
         else{
         Dialogs.showGeneralDialog(context, _keyLoader,SERVER_ERROR);
        }*/

      }
      else {
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
        Dialogs.showGeneralDialog(context, _keyLoader,SERVER_ERROR);

        print(response.body);
      }
    } on TimeoutException catch (_) {
      print('timeout');
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      Dialogs.showGeneralDialog(context, _keyLoader,CONNECTION_TIMEOUT);
    }
  }

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
/*

  void checkstatus(String resultval) {
    setState(() {
      result = resultval;
    });
  }*/
}

