import 'package:flutter/material.dart';
import 'package:flutter_app_1/util/constant.dart';

class Dialogs {
  static Future<void>
  showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}


class internet {
  static Future<void>
  showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                       // CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text(NETWORK_CONNECTION_ERROR,
                          style: TextStyle(color: Colors.greenAccent, fontSize: 20)),
                        Text("Please Try Again",
                        style: TextStyle(color: Colors.greenAccent,fontSize: 20 ))
                      ]),
                    ),
                     new FlatButton(
                           child: Text("ok",style: TextStyle(color: Colors.white,fontSize: 25)),
                            onPressed: () {
                             Navigator.pop(context);
                            /*  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                      return MyAp();
                                  }
                                  ));*/
                            }
                            ),
               ]));
        });

  }
}

//const url = '';
