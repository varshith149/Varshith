import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app/presenter/Medical_presenter.dart';
//import 'package:flutter_app/viewmodel/Login_model.dart';
import 'package:flutter_app_1/Views/Prescription_view.dart';
import 'package:flutter_app_1/Views/Sign_up.dart';
//import 'package:flutter_app/views/View_random.dart';
import 'package:flutter_app_1/Views/Forget_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class MyAp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Easy Medico',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),//new BasicCounterPresenter(), title: 'Sign In'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  //final CounterPresenter presenter;

  //MyHomePage(this.presenter, {Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> /*implements CounterView*/ {
  //GlobalKey<NavigatorState> _key = GlobalKey();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool toggleValue = false;
  bool _isLoading = false;

  //CounterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    //this.widget.presenter.counterView = this as CounterView;
  }

 /* @override
  void refreshCounter(CounterViewModel viewModel) {
    setState(() {
      this._viewModel = viewModel;
    });
  }*/

  String _email;
  String _password;

  /*void backbutton() {
    Navigator.pop(context);
  }*/

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return /*WillPopScope(
      onWillPop: (){
        backbutton();
        //return Future.value(false);
      },
      child: */new Scaffold(
      appBar: AppBar(
          title: Text('Sign In',//widget.title,
              style: TextStyle(fontSize: 25)
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(236, 85, 156, 1)
      ),
      body: SingleChildScrollView(
        child: //_isLoading ? Center(child: CircularProgressIndicator()) :
         Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /* Container(
                child: Stack(
                children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0,65, 0.0, 0.0),
                  child: Text(
                        'Easymedico',
                         style: TextStyle(
                          fontSize: 50,fontWeight: FontWeight.bold, color: Colors.black)
                             ),
                        )
                                   ],
                            ),
                      ),*/
              Container (
                  padding: EdgeInsets.fromLTRB(15, 60, 15,0 ),
                  child: Form(
                      key: _formKey,
                      child: Column(
                          children: <Widget>[
                            TextFormField(
                              style:
                              TextStyle(fontSize: 22.0, color: Color.fromRGBO(100, 100, 100, 1)),
                              controller: emailController,
                              decoration: InputDecoration(
                                //contentPadding: EdgeInsets.all(30),
                                  labelText: 'Email *',
                                  labelStyle: TextStyle(
                                      fontFamily:'Montserrat',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(97, 97, 97, 1)
                                  ),
                                  focusedBorder: UnderlineInputBorder(

                                      borderSide: BorderSide(color: Colors.blue)
                                  )
                              ),
                              validator: (String val) =>
                              /*  if(val.isEmpty){
                          return 'Invalid Email';
                        }
                       },
                       onSaved: (String val){
                        _email = val;
                       },*/
                              !val.contains('@') ? 'Invalid Email' :null,
                              onSaved: (val) => _email=val,
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(

                              style:
                              TextStyle(fontSize: 22.0, color: Color.fromRGBO(100, 100, 100, 1)),
                              controller: passwordController,
                              decoration: InputDecoration(
                                //contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                labelText: 'Password *',
                                labelStyle: TextStyle(
                                    fontFamily:'Montserrat',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(97, 97, 97, 1)
                                ),

                              ),
                              validator: (val)  =>
                              val.length<6 ? 'Password too short' :null,
                              onSaved: (val) => _password=val,
                              obscureText: true,
                            ),


                            SizedBox(height: 25.0),
                            Container(
                                alignment: Alignment(1.0,0.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return resetPage();
                                    }));
                                    //of(context).pushNamed('/password_reset');
                                    //this.widget.presenter.onButton1Clicked();
                                  },
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      fontFamily:'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromRGBO(99, 99, 99, 1),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                            ),

                          ]
                      )
                  )
              ),

              SizedBox(height: 45.0),
              Row(
                  mainAxisAlignment : MainAxisAlignment.start,
                  children :<Widget>[
                    SizedBox(width: 10),
                    Text(
                      'Remember Me ',
                      style: TextStyle(fontFamily: 'Montserrat',fontSize: 20),

                    ),

                    SizedBox(width: 5.0),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: toggleValue ? Color.fromRGBO(4, 154, 232, 1) : Color.fromRGBO(4, 154,232, 1)
                      ),
                      child: Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                              duration: Duration(milliseconds: 1000),
                              top: 1,
                              left: toggleValue ? 25.0 : 0.0,
                              right: toggleValue ? 0 : 25,
                              child: InkWell(
                                onTap: togglebutton,
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 1000),
                                  transitionBuilder:
                                      (Widget child, Animation<double> animation){
                                    return RotationTransition(
                                        child: child , turns: animation);
                                  },
                                  child: toggleValue ? Icon(Icons.check_circle,color: Colors.green,size: 25,
                                      key:UniqueKey()
                                  ) : Icon(Icons.check_circle, color: Colors.redAccent,size: 25,
                                    key: UniqueKey(),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),

                  ]
              ),


              SizedBox(height: 45.0),
              FlatButton(
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 40,
                  child: Material(

                    borderRadius: BorderRadius.circular(0.0),
                    //shadowColor: Colors.greenAccent,
                    color: Color.fromRGBO(4, 154, 232, 1),
                    elevation: 7.0,
                    child: InkWell(
                      onTap: () {
                        if(!_formKey.currentState.validate()){
                          return;
                        }
                      /*  else {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Landingscreen();
                              }));
                        }*/
                        _formKey.currentState.save();
                        setState(() {
                          _isLoading = true;
                        });
                        SignIn(emailController.text, passwordController.text);
                        //this.widget.presenter.onButton1Clicked();
                        //Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //return pass();
                      },
                      child: Center(
                        child: Text(
                          'Login',
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
              SizedBox(height: 10),
              if(_isLoading == true)
                Center(child: CircularProgressIndicator()),
              SizedBox(height:75.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have account?",
                    style: TextStyle(fontFamily: 'Montserrat',fontSize: 20),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      //this.widget.presenter.onButton1Clicked();
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SignupPage();
                      }
                      ));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Color.fromRGBO(99, 99, 99, 1),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              /*  Container (
                          child: Form(
                          child: Column(
                          children: <Widget>[
                          TextFormField(
                          decoration: InputDecoration(
                          labelText: _viewModel?.counter.toString(),
                          labelStyle: Theme.of(context).textTheme.display1,
        )
        )
        ]
        )
        )
        ),*/


            ]),
      ),

      /* floatingActionButton: new FloatingActionButton(
            onPressed: () => this.widget.presenter.onButton1Clicked(),
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          ),*/
    );
  }

  SignIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse = null;
    var response = await http.post("https://reqres.in/api/login", body: {
      'email': email,
      'password': pass
    }
    );
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Landingscreen()), (Route<dynamic> route) => false);
      }
    }
    else {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Error'),
          content: new Text("User doesn't found?"),
          actions: <Widget>[
            new FlatButton(
              child: Text("ok"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyAp();
                }
                ));
              }
            ),
          ],
        ),
      );



      /*setState(() {
        _isLoading = false;
      });*/
      print(response.body);
    }
  }

  togglebutton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
