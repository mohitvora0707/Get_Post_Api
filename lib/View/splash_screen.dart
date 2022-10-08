import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_login_ui/View/HomePage.dart';
import 'package:google_login_ui/View/Wellcome_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userName;
  @override
  void initState() {
    getUserName().whenComplete(() => Timer(
          Duration(seconds: 2),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  userName == null ? WellcomeScreen() : HomePage(),
            ),
          ),
        ));
    super.initState();
  }

  Future getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('username');
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          textScaleFactor: 3,
        ),
      ),
    );
  }
}
