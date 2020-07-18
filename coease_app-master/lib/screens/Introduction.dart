import '../screens/Step1.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SwipeDetector(
        onSwipeLeft: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Step1()));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 29,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Introduction',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff484848),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/Introduction.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: Text(
                  'Faster way to detect COVID19', 
                  style: TextStyle(
                    fontSize: 23,
                    color: Color(0xff454545),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Login once using your phone number.Take an image of your X-RAY or CT-scan. Upload an image of the scan taken before Once the image has been uploaded to the app ,Wait for the results.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff454545),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 20, right: 20),
              //   width: double.infinity,
              //   child: Text(
              //     'Wait for the results.',
              //     style: TextStyle(
              //       fontSize: 18,
              //       color: Color(0xff454545),
              //       fontWeight: FontWeight.w900,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
