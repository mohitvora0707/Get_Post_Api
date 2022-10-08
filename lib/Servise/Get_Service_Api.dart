import 'package:http/http.dart' as http;

import '../Model/Get_Data_Api.dart';

class Get_Servise {
  static Future<CodlineModel?> getData() async {
    http.Response response = await http.get(
      Uri.parse('https://codelineinfotech.com/student_api/User/allusers.php'),
    );
    if (response.statusCode == 200) {
      return codlineModelFromJson(response.body);
    }
  }
}
