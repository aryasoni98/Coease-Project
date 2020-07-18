import '../widgets/harsh.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:dio/dio.dart';

import 'dart:convert';

class SingleReport extends StatefulWidget {
  final File previewImage;
  final String cat;
  final name;

  SingleReport(this.previewImage, this.cat, this.name);

  @override
  _SingleReportState createState() => _SingleReportState();
}

class _SingleReportState extends State<SingleReport> {
  String symptoms = '';
  Map<dynamic, dynamic> responseData;
  var count;
  var wantedList;
  bool isList = false;
  List<String> diseasesList;
  List<String> revisedDiseasesList;
  List<String> percentageList;
  bool _isSymptomsComplete = false;

  displayDiseases() {
    diseasesList = List.generate(count.length - 1, (index) {
      if (index % 2 == 0) {
        // return wantedList["${index + 1}:"];
        return wantedList[index];
      } else {
        return null;
      }
    });

    setState(() {
      diseasesList.removeWhere((element) {
        bool ifNull = (element == null);
        return ifNull;
      });
    });

    print(diseasesList);
  }

  displayPercentages() {
    percentageList = List.generate(count.length - 1, (index) {
      if (index % 2 != 0) {
        return wantedList[index];
      } else {
        return null;
      }
    });

    setState(() {
      percentageList.removeWhere((element) {
        bool ifNull = (element == null);
        return ifNull;
      });
    });

    print(percentageList);
  }

  List<Widget> getDiseases() {
    isList = false;
    wantedList = List.generate(count.length - 1, (index) {
      return responseData["${index + 1}:"];
    });

    setState(() {
      isList = true;
    });
    // print(wantedList);
    displayDiseases();
    displayPercentages();

    // print(responseData["1: "]);
    return [
      Container(),
    ];
  }

  getNewResponse() async {
    isList = false;
    FormData formData = new FormData.fromMap({
      "": await MultipartFile.fromFile(widget.previewImage.path),
    });
    Dio dio = Dio();
    Response response = await dio.post(
      "http://13.232.214.38:81/predict",
      data: formData,
    );
    var extractdata = await json.decode(response.toString()) as Map;
    // print(extractdata["Symptoms: "]);

    setState(() {
      symptoms = extractdata["Symptoms: "];
      _isSymptomsComplete = true;
      responseData = extractdata;
    });

    count = responseData.values.toList();
    getDiseases();
  }

  warningData() async {}

  uploadData() async {}

  @override
  void initState() {
    isList = false;
    // getNewResponse();
    print(widget.cat);
    print(widget.name);

    super.initState();
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
                'Report',
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
                  left: 60,
                  right: 60,
                ),
                width: double.infinity,
                height: 360,
                color: Colors.transparent,
                child: ClipRRect(
                  child: Image.file(widget.previewImage, fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: RaisedButton(
                        elevation: 10,
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Color(0xffE8903E),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text(
                                    'Disclaimer',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                    'The results shown are not 100 percent certain !',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      onPressed: () {
                                        getNewResponse();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            'Report',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      child: RaisedButton(
                        elevation: 10,
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Color(0xffE8903E),
                        onPressed: () {
                          signOutGoogle();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             MyHomePage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name :',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _isSymptomsComplete
                        ? Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 8,
                            ),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Symptoms :',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Text(
                        symptoms,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    isList
                        ? Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 30),
                            decoration: BoxDecoration(border: Border.all()),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(
                                          'Predicted Disease',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 22),
                                        // width: MediaQuery.of(context).size.width-22,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              diseasesList.map((variable) {
                                            return Container(
                                              margin: EdgeInsets.all(5),
                                              child: Text(
                                                variable,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 20),
                                        child: Text(
                                          'Percentage',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 22),
                                        // width: MediaQuery.of(context).size.width-22,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              percentageList.map((variable) {
                                            return Container(
                                              margin: EdgeInsets.all(5),
                                              child: Text(
                                                double.parse(variable)
                                                    .toStringAsFixed(4),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          )
                        : Container(),
                    // Container(
                    //   margin: EdgeInsets.only(
                    //     left: 20,
                    //     right: 20,
                    //     bottom: 10,
                    //   ),
                    //   width: double.infinity,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Predicted Disease :',
                    //         style: TextStyle(
                    //           fontSize: 22,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       Text(
                    //         'HARSH',
                    //         style: TextStyle(
                    //           fontSize: 22,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
