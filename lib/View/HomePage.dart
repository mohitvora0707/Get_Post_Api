import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Get_Data_Api.dart';
import '../Servise/Get_Service_Api.dart';
import 'Wellcome_Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Get_Servise.getData(),
      builder: (BuildContext context, AsyncSnapshot<CodlineModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.users!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data!.users![index].username.toString(),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('username').then(
                          (value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WellcomeScreen(),
                            ),
                          ),
                        );
                  },
                  child: Text("Log Out"),
                )
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
