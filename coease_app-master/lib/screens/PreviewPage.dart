import 'dart:convert';
import 'dart:io';
import '../screens/SingleReport.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PreviewPage extends StatefulWidget {
  final File previewimage;
  final String cat;
  PreviewPage(this.previewimage, this.cat);
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  getNewResponse() async {
    FormData formData = new FormData.fromMap({
      "": await MultipartFile.fromFile(widget.previewimage.path),
    });
    Dio dio = Dio();
    Response response = await dio.post(
      "http://13.232.214.38:81/predict",
      data: formData,
    );

    var extractdata = json.decode(response.toString()) as Map;
    print(extractdata);
  }

  @override
  void initState() {
    getNewResponse();
    super.initState();
  }

  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                'Preview',
                style: TextStyle(
                  color: Color(0xff484848),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                width: double.infinity,
                height: 400,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    widget.previewimage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 45,
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 30,
                  top: 20,
                ),
                child: Center(
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignLabelWithHint: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff707070)),
                        ),
                        hintText: 'Enter Name',
                        hintStyle: TextStyle(fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff707070)),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        SingleReport(widget.previewimage,
                                            widget.cat, nameController.text)));
                          },
                          child: Row(
                            children: [
                              Container(
                                  child: Icon(
                                Icons.photo,
                                size: 25,
                                color: Colors.white, 
                              )),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Report',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ],
                          )),
                    ),
                    // Container(
                    //   width: 55,
                    //   height: 50,
                    //   child: RaisedButton(
                    //     elevation: 4,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(7),
                    //     ),
                    //     padding: EdgeInsets.all(0),
                    //     color: Color(0xffE8903E),
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (BuildContext context) =>
                    //                   MultiPreview(
                    //                       widget.previewimage, widget.cat)));
                    //     },
                    //     child: Icon(
                    //       Icons.add_to_photos,
                    //       color: Colors.white,
                    //       size: 40,
                    //     ),
                    //   ),
                    // )
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
