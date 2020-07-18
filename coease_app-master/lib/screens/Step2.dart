import '../screens/HomePage.dart';
import 'package:flutter/material.dart';

class Step2 extends StatefulWidget {
  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              child: Text(
                'Step - 2',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff484848),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/Step2.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
              child: Text(
                'This is based on a machine learning model and thus the results are based on past data given to it.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 10),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'The ',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'results shown are not 100 percent certain',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 10),
              child: Text(
                'and this has been just made for preventive measures to be taken by the person if tested positive.',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xffE8903E),
                child: Text(
                  'Welcome',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
