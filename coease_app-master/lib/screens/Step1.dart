import '../screens/Step2.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';  

class Step1 extends StatefulWidget {
  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SwipeDetector(
        onSwipeLeft: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Step2()));
        },
        onSwipeRight: () {
          Navigator.of(context).pop();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Step - 1',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff484848),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/Step1.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  'Take an image from your phone or upload an existing image of your scan .',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff454545),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Text(
                  'Make sure the image is clear for better results.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff454545),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
