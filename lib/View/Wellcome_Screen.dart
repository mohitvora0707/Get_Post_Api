import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'LogIn_Screen.dart';
import 'Register_Screen.dart';

class WellcomeScreen extends StatelessWidget {
  const WellcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'asset/image/derick-anies-hDJT_ERrB-w-unsplash.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: Text(
                      'Start a new\nsocial adventure.',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 215,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get involved with people and events\naround you.',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogInScreen(),
                                ),
                              );
                            },
                            color: Color(0xFF272F32),
                            height: 50,
                            minWidth: 300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Sing in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Or Create Account',
                                  style: TextStyle(
                                      color: Color(0xFF272F32),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen(),
                                        ));
                                  },
                                  child: Image.asset(
                                    'asset/image/right-arrow (2).png',
                                    height: 25,
                                    width: 25,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
