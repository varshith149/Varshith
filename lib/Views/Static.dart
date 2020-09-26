import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
                  //backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text(POSTING_WAIT,style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}


class internet {
  static Future<void>
  showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(NETWORK_CONNECTION_ERROR),
        //content: new Text("User doesn't found?"),
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

class error_response_statuscode {
  static Future<void>
  showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog(
    context: context,
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

class BouncyPageRoute extends PageRouteBuilder{
  final Widget widget;
  
  BouncyPageRoute({this.widget})
      :super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
            Widget child){
              animation = CurvedAnimation(
                parent: animation, curve: Curves.elasticInOut);
              return FadeTransition(
                  opacity: animation,
              child: child,
              );/*ScaleTransition(
                  scale: animation,
                  alignment: Alignment.bottomCenter,
                  child: child,
              );*/
            },
            
            pageBuilder: (BuildContext context,Animation<double>animation,
            Animation<double> secAnimation){
              return widget;
            }
  );
}