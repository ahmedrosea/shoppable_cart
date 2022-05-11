import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  Future<dynamic> post(
      {required String url, required Map<String, String> postBody}) async {
    http.Response response = await http.post(
      Uri.parse(url),
      body: postBody,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'There is an error in the status code and it is ${response.statusCode}');
    }
  }
  Future<dynamic> get(url) async {
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else {
      throw Exception("There is an error in the status code and it is ${response
          .statusCode}");
    }

  }
}
