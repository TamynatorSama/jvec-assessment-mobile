import 'dart:convert';

import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:contact_app/utils/constants.dart';

class ContactRequest {
  static Future<Map<String, dynamic>> createNewContact(
      ContactInfo contact) async {
    String url = '$baseUrl/contact';
    print(UserData.token);

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': "application/json",
              "authorization": "Bearer ${UserData.token}"
            },
            body: jsonEncode(
              contact.toJson(),
            ),
          )
          .timeout(const Duration(seconds: 60));

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {
          'status': true,
          'message': data["message"],
          "result": data["result"]
        };
      } else if (response.statusCode == 422) {
        if (data["error"] != null) {
          return {
            'status': false,
            'message': (data["error"] as Map<String, dynamic>).values.first[0]
          };
        }
        return {'status': false, 'message': data["message"]};
      } else {
        return {'status': false, 'message': data["message"]};
      }
    } catch (_) {
      return {'status': false, 'message': 'An error occurred'};
    }
  }
}
