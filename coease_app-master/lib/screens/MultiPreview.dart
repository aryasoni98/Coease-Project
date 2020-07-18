import '../screens/MultiReport.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MultiPreview extends StatefulWidget {
  final File previewImage;
  final String cat;

  MultiPreview(this.previewImage, this.cat);

  @override
  _MultiPreviewState createState() => _MultiPreviewState();
}

class _MultiPreviewState extends State<MultiPreview> {
  File _image2;
  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image2 = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 35,
              ),
              Text(
                'Preview',
                style: TextStyle(
                  color: Color(0xff484848),
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: ClipRRect(
                            child: Image.file(widget.previewImage,
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          height: 250,
                          width: 150,
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 30),
                            width: 150,
                            height: 40,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      )),
                                  hintText: 'Enter Name',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ))),
                            ))
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              getImage();
                            },
                            child: _image2 == null
                                ? Container(
                                    child: Center(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: Colors.transparent,
                                    ),
                                    height: 250,
                                    width: 150,
                                  )
                                : Container(
                                    width: 150,
                                    height: 250,
                                    child: ClipRRect(
                                      child: Image.file(
                                        _image2,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  )),
                        Container(
                            margin: EdgeInsets.only(top: 30),
                            width: 150,
                            height: 40,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      )),
                                  hintText: 'Enter Name',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ))),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 25, top: 110),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: RaisedButton(
                          padding: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Color(0xffE8903E),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MultiReport(
                                            _image2, widget.previewImage)));
                          },
                          child: Row(
                            children: [
                              Container(
                                  child: Icon(
                                Icons.photo,
                                size: 35,
                                color: Colors.white,
                              )),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Upload',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white)),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
