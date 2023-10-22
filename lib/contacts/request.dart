import 'dart:convert';
import 'dart:io';

import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:contact_app/utils/constants.dart';

class ContactRequest {
  static Future<Map<String, dynamic>> createNewContact(
      ContactInfo contact) async {
    String url = '$baseUrl/contact';

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

  static Future<Map<String, dynamic>> uploadContactPicture(
      String userId, String imageUrl) async {
    String url = '$baseUrl/contact/$userId';
    final request = http.MultipartRequest("PATCH", Uri.parse(url));

    try {
      request.files.add(http.MultipartFile.fromBytes(
          'profile_picture', File(imageUrl).readAsBytesSync(),
          filename: imageUrl));
      request.headers.addAll({"authorization": "Bearer ${UserData.token}"});
      http.StreamedResponse res = await request.send();
      var response = await http.Response.fromStream(res);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'status': true,
          'message': data["message"],
          "result": data["result"]
        };
      } else {
        return {'status': false, 'message': data["message"]};
      }
    } catch (_) {
      return {'status': false, 'message': 'An error occurred'};
    }
  }

  static Future<Map<String, dynamic>> updateContact(ContactInfo contact) async {
    String url = '$baseUrl/contact/${contact.identifier}';

    try {
      final response = await http
          .put(
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
      if (response.statusCode == 200) {
        return {
          'status': true,
          'message': data["message"],
          "result": data["result"]
        };
      } else {
        return {'status': false, 'message': data["message"]};
      }
    } catch (_) {
      return {'status': false, 'message': 'An error occurred'};
    }
  }

  static Future<Map<String, dynamic>> deleteContact(String contactId) async {
    String url = '$baseUrl/contact/$contactId';

    try {
      final response = await http
          .delete(
            Uri.parse(url),
            headers: {
              'Content-Type': "application/json",
              "authorization": "Bearer ${UserData.token}"
            },
          )
          .timeout(const Duration(seconds: 60));

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'status': true,
          'message': data["message"],
          "result": data["result"]
        };
      } else {
        return {'status': false, 'message': data["message"]};
      }
    } catch (_) {
      return {'status': false, 'message': 'An error occurred'};
    }
  }

  static Future<Map<String, dynamic>> getContacts() async {
    String url = '$baseUrl/contact';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': "application/json",
          "authorization": "Bearer ${UserData.token}"
        },
      ).timeout(const Duration(seconds: 60));

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'status': true,
          'message': data["message"],
          "result": data["result"]
        };
      } else {
        return {'status': false, 'message': data["message"]};
      }
    } catch (_) {
      return {'status': false, 'message': 'An error occurred'};
    }
  }
}
