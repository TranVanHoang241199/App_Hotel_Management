import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String apiUrl = "http://hotel.somee.com/api/v1/auth/login";

  // Login
  static Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    final Map<String, String> data = {
      "userName": username,
      "password": password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'accessToken': responseData['accessToken'],
          'message': responseData['message'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'],
        };
      }
    } catch (error) {
      return {
        'success': false,
        'message': 'Error occurred while processing the request.',
      };
    }
  }

  // register
  static Future<Map<String, dynamic>> registerUser({
    required String username,
    required String password,
    required String fullName,
    required String phone,
    required String email,
    required bool isDeleted,
    required String role,
  }) async {
    final Map<String, dynamic> data = {
      "userName": username,
      "password": password,
      "fullName": fullName,
      "phone": phone,
      "email": email,
      "businessAreas": 0,
      "isDeleted": isDeleted,
      "role": role,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData['data'],
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'],
        };
      }
    } catch (error) {
      return {
        'success': false,
        'message': 'Error occurred while processing the request.',
      };
    }
  }
}
