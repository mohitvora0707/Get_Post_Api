import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/LogIn_Model.dart';
import '../Servise/LogIn_Servise.dart';
import 'HomePage.dart';
import 'Wellcome_Screen.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isChecked = false;
  bool isView = true;
  bool isLording = false;
  final userName = TextEditingController();
  final password = TextEditingController();

  bool isEnabled = true;
  final Formkye = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF272F32),
        body: SingleChildScrollView(
          child: Form(
            key: Formkye,
            child: Column(
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WellcomeScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xFF272F32),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Text(
                          'Welcome\nBack!',
                          style: TextStyle(
                            color: Color(0xFF272F32),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Continue your adventire',
                          style: TextStyle(
                              color: Color(0xFF272F32),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.04),
                      TextFormField(
                        enabled: isEnabled,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter UserName';
                          }
                        },
                        controller: userName,
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'UserName',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      TextFormField(
                        enabled: isEnabled,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          }
                        },
                        controller: password,
                        obscureText: isView,
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isView = !isView;
                              });
                            },
                            child: isView == true
                                ? Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.grey,
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                          ),
                          contentPadding: EdgeInsets.only(
                              top: 20, right: 20, left: 20, bottom: 15),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(
                                () {
                                  isChecked = value!;
                                },
                              );
                            },
                          ),
                          Text(
                            'Remember me',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (Formkye.currentState!.validate()) {
                            setState(() {
                              isLording = true;
                              isEnabled = false;
                            });

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            LogIn_Model Model = LogIn_Model();
                            Model.username = userName.text;
                            Model.password = password.text;
                            var Status =
                                await LogInServise.login(Model.toJson());

                            if (Status['status'] == true) {
                              prefs.setString('username', userName.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(Status['message'])));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                            } else {
                              setState(() {
                                isLording = false;
                                isEnabled = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(Status['message'])));
                            }
                          }
                        },
                        color: Colors.white,
                        height: 50,
                        minWidth: 300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: isLording == true
                            ? CircularProgressIndicator(
                                color: Color(0xFF272F32),
                              )
                            : Text(
                                'Sing in',
                                style: TextStyle(
                                  color: Color(0xFF272F32),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
