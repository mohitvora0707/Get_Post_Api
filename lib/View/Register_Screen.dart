import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_login_ui/View/LogIn_Screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Register_Model.dart';
import '../Servise/Register_Servise.dart';
import 'HomePage.dart';
import 'package:dio/dio.dart' as dio;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isEnabled = true;
  bool isLording = false;
  bool isChecked = true;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final formkye = GlobalKey<FormState>();

  ImagePicker picker = ImagePicker();
  File? image;
  void getImageFromCamera() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<String?> uploadUserImage() async {
    dio.FormData formData = dio.FormData.fromMap({
      'avatar': await dio.MultipartFile.fromFile(image!.path),
    });
    dio.Response response = await dio.Dio().post(
        'https://codelineinfotech.com/student_api/User/user_avatar_upload.php',
        data: formData);
    if (response.data['url'] != null) {
      return response.data['url'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final wight = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF272F32),
        body: SingleChildScrollView(
          child: Form(
            key: formkye,
            child: Column(
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xFF272F32),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Create\nAccount.',
                              style: TextStyle(
                                color: Color(0xFF272F32),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            getImageFromCamera();
                          },
                          child: Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                  color: Color(0xFF272F32),
                                  shape: BoxShape.circle),
                              child: ClipOval(
                                child: image == null
                                    ? Icon(
                                        Icons.person_add_alt_1_outlined,
                                        color: Colors.white,
                                        size: 25,
                                      )
                                    : Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: wight * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.025),
                      TextFormField(
                        enabled: isEnabled,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter firstName';
                          }
                        },
                        controller: firstName,
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'First Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          //border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      TextFormField(
                        enabled: isEnabled,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter lastname';
                          }
                        },
                        controller: lastName,
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'Last Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          //border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      TextFormField(
                        enabled: isEnabled,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter userName';
                          }
                        },
                        controller: userName,
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'User Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          //border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      TextFormField(
                        enabled: isEnabled,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                        },
                        controller: password,
                        obscureText: true,
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
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
                            'Agree to terms and conditions',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      MaterialButton(
                        onPressed: () async {
                          if (formkye.currentState!.validate()) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            setState(() {
                              isEnabled = false;
                              isLording = true;
                            });
                            final imageUrl = await uploadUserImage();
                            Register_Model Model = Register_Model();
                            Model.firstName = firstName.text;
                            Model.lastName = lastName.text;
                            Model.username = userName.text;
                            Model.password = password.text;
                            Model.avatar = imageUrl;

                            var status = await RegisterServise.Futureregister(
                                Model.toJson());

                            if (status['status'] == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(status['message'])));
                              prefs.setString('username', userName.text);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            } else {
                              setState(() {
                                isLording = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(status['message'])));
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
                            ? CircularProgressIndicator()
                            : Text(
                                'Sing Up',
                                style: TextStyle(
                                  color: Color(0xFF272F32),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.white),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogInScreen(),
                                  ));
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
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
