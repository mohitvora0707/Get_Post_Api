import 'package:flutter/material.dart';

import 'View/Wellcome_Screen.dart';
import 'View/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.grey, unselectedWidgetColor: Colors.grey),
      home: SplashScreen(),
    );
  }
}
