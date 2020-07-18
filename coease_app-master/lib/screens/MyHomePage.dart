import '../screens/Introduction.dart';
import 'package:flutter/material.dart';
import '../widgets/harsh.dart';

// import 'package:flutter_otp/flutter_otp.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // bool _isMobile = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/MyHomePage.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  'COEASE-19',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff484848),
                  ),
                ),
              ),
              SizedBox(
                  height: 40, 
                ),
              Container(
                child: Text(
                  'Faster way to detect COVID -19',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff484848),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 0,
                ),
              ),
              Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 35, right: 35, bottom: 60),
                child: RaisedButton(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide()),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              // color: Colors.amber,
                              // borderRadius: BorderRadius.circular(10),
                              ),
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            child: Image.asset(
                              'assets/images/google.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      signInWithGoogle().whenComplete(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Introduction();
                            },
                          ),
                        );
                      });
                    }),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
