/*
import 'package:flutter/material.dart';
import 'package:flutter_app/presenter/Medical_presenter.dart';
import 'package:flutter_app/views/Login_view.dart';
import 'dart:async';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Easy Medico',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(new BasicCounterPresenter(), title: 'login Page'),
    );
  }
}
*/

//multi_image_picker: ^3.0.14
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/Views/Login_view.dart';
import 'package:splashscreen/splashscreen.dart';
//import 'package:flutter_app/views/Login_view.dart';
//import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      //routes: <String, WidgetBuilder>{
      //'/login_view': (BuildContext context) => new MyAp()
      //},
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*GlobalKey<NavigatorState> _key = GlobalKey();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),()=> Navigator.push(context,MaterialPageRoute(builder: (context){
      return MyAp();
    }
    )));
 }*/


  /*Future<bool> _onBackPressed() {
   //Navigator.of(context).pop();

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
       ],
     ),
   ) ??
       false;
 }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return Navigator.canPop(context);
      },
      child: SplashScreen(
        seconds: 5,
        backgroundColor: Colors.white,

        image: Image.asset('Images/Logo_easymedico.png'),
        loaderColor: Colors.white,
        photoSize: 150,
        navigateAfterSeconds: MyAp(),

        loadingText: Text('Your Health Our Care..!',
          style: TextStyle(
              fontSize: 30,
              color: Colors.green
          ),
        ),
      ),

    );
  }}


// Akkarleni Sodhi
/*WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.red),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                  child: Icon(
                                    Icons.medical_services,
                                    color: Colors.green,
                                    size: 50,
                                  ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 10.0)
                              ),
                              Text(
                                "EasyMedico",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                    Expanded(
                        flex:1,
                      child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Padding(
                              padding: EdgeInsets.only(top:20),
                          ),
                          Text("E-PHARMACY",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],

            ),

      ),
    );

  }}*/











/*
      body: Center(
        child: Text('Hello Amigos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('click'),
        backgroundColor: Colors.red,
      ),
    ),
  ));
}
*/






