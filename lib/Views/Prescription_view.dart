import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/Views/Login_view.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:flutter_app/Views/View_images.dart';

class Landingscreen extends StatefulWidget {
  @override
  _prescription createState() => _prescription();
}

class _prescription extends State<Landingscreen> {


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


  File imageFile;

  @override
  void initState() {
    super.initState();
  }

  _openGallery(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
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
      imageFile = picture;
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
    if(imageFile == null){
      return Image.asset('Images/Default_image.jpg',width: 300,height: 400);
    }
    else{
      return Image.file(imageFile,width: 500,height: 500,);
    }

  }

  void backbutton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
          backbutton();
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Capture Prescription Image',style: TextStyle(fontSize: 18),),
            backgroundColor: Color.fromRGBO(236, 85, 156, 1),
            actions: <Widget>[
              PopupMenuButton(
                  onSelected: (String val){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return MyAp();
                        }));
                  },
                  itemBuilder: (BuildContext context) => _pop
              )
            ],
          ),
          body: Container(
            child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 10),
                  _decideImageView(),
                  SizedBox(height: 25),
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
                                    child: Text('Take Photo',
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
                            width: 150,
                            child: Material(
                              borderRadius: BorderRadius.circular(0.0),
                              color: Color.fromRGBO(4, 154, 232, 1),
                              elevation: 7.0,
                              child: InkWell(
                                  onTap: () {
                                    // _showChoiceDialog(context);
                                  },
                                  child: Center(
                                    child: Text('Submit',
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
        )
    );
  }
}


