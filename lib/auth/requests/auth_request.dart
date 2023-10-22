import 'dart:convert';
import 'package:contact_app/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:contact_app/utils/constants.dart';

class AuthRequest {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    String url = '$baseUrl/auth/login';

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(
            {
              'email': email,
              'password': password,
            },
          ),
          headers: {
            'Content-Type': 'application/json'
          }).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final result = data['result'];

        UserData.email = result['user_payload']['email'] ?? '';
        UserData.fullName= result['full_name'] ?? '';
        UserData.identifier = result['user_payload']['_id'] ?? '';
        UserData.token = result['token'];

        return {'status': true, 'message': 'sign in successful'};
      }
      if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return {'status': false, 'message': data['message']};
      }
      if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        if(data["error"] !=null){
          return {'status': false, 'message': (data["error"] as Map<String,dynamic>).values.first[0]};
        }
          return {'status': false, 'message': data["message"]};
      }
      return {'status': false, 'message': 'An error occurred'};
    } catch (e) {
      return {'status': false, 'message': 'An error occurred'};
    }
  }

  static Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String fullName
  }) async {
    String url = '$baseUrl/auth/signup';

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(
            {
              'email': email,
              'password': password,
              "full_name":fullName
            },
          ),
          headers: {
            'Content-Type': 'application/json'
          }).timeout(const Duration(seconds: 60));
          print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        final result = data['result'];

        UserData.email = result['user_payload']['email'] ?? '';
        UserData.fullName= result['full_name'] ?? '';
        UserData.identifier = result['user_payload']['_id'] ?? '';
        UserData.token = result['token'];

        return {'status': true, 'message': 'sign in successful'};
      }
      if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        return {'status': false, 'message': data['message']};
      }
      if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        if(data["error"] !=null){
          return {'status': false, 'message': (data["error"] as Map<String,dynamic>).values.first[0]};
        }
          return {'status': false, 'message': data["message"]};
      }
      return {'status': false, 'message': 'An error occurred'};

    } catch (e) {
      return {'status': false, 'message': 'An error occurred'};
    }
  }
}
