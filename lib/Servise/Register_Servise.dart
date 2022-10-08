import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class RegisterServise {
  static Futureregister(Map<String, dynamic> reqBody) async {
    http.Response response = await http.post(
      Uri.parse('https://codelineinfotech.com/student_api/User/signup.php'),
      body: reqBody,
    );
    var result = jsonDecode(response.body);
    print("Status-->> ${response.body}");
    return result;
  }
}
