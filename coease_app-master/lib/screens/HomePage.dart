import 'dart:io';
import '../screens/PreviewPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipedetector/swipedetector.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _xrayImage;
  File _ctImage;
  bool isXRayImage = false;
  bool isCtImage = false;
  bool isgallery = false;
  bool isCamera = false;
  String cat = '';

  getXrayImage() async {
    if (isCamera) {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _xrayImage = image;
        isXRayImage = true;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    PreviewPage(_xrayImage, 'xray')));
      });
    } else if (isgallery) {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _xrayImage = image;
        isCtImage = true;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    PreviewPage(_xrayImage, 'xray')));
      });
    } else {}
  }

  getCtImage() async {
    print('THIS IS GET CT FUNCTION');
    if (isCamera) {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _ctImage = image;
        isCtImage = true;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    PreviewPage(_ctImage, 'ct')));
      });
    } else if (isgallery) {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _ctImage = image;
        isCtImage = true;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    PreviewPage(_ctImage, 'ct')));
      });
    } else {}
  }

  askSource(BuildContext context, String cat) {
    print("ASK SOURCE CALLED");
    print(cat);
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              width: double.infinity,
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'SOURCE',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Color(0xffE8903E),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('Camera',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        isCamera = true;
                        isgallery = false;
                        if (cat == 'xray') {
                          Navigator.of(context).pop();
                          await getXrayImage();
                        } else {
                          Navigator.of(context).pop();
                          await getCtImage();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Color(0xffE8903E),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Icon(
                                Icons.photo_album,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('Gallery',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        isgallery = true;
                        isCamera = false;
                        if (cat == 'xray') {
                          Navigator.of(context).pop();
                          await getXrayImage();
                        } else {
                          Navigator.of(context).pop();
                          await getCtImage();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SwipeDetector(
        onSwipeRight: () {
          Navigator.of(context).pop();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'COEASE - 19',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff484848),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/HomePage.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: RaisedButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      color: Color(0xffE8903E),
                      onPressed: () async {
                        cat = 'xray';
                        askSource(context, cat);
                      },
                      child: Row(children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 19,
                        ),
                        Text(
                          'X-RAY',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      color: Color(0xffE8903E),
                      onPressed: () async {
                        cat = 'ct';
                        askSource(context, cat);
                      },
                      child: Row(children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'CT-Scan',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
