import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String get baseUrl {
    if (kIsWeb) {
      return "http://127.0.0.1:5000";
    } else {
      // Your laptop Wi-Fi IPv4 address
      return "http://10.107.38.110:5000";
    }
  }

  // ================= LOGIN =================

  static Future<Map<String, dynamic>> login(
      String username,
      String password) async {
    try {
      final url = Uri.parse("$baseUrl/auth/login");

      print("====================================");
      print("LOGIN URL : $url");
      print("USERNAME  : $username");
      print("====================================");

      final response = await http
          .post(
            url,
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "username": username,
              "password": password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      print("STATUS CODE : ${response.statusCode}");
      print("BODY : ${response.body}");

      return jsonDecode(response.body);
    } on TimeoutException {
      return {
        "status": "error",
        "message": "Connection Timeout",
      };
    } catch (e) {
      print("LOGIN ERROR : $e");

      return {
        "status": "error",
        "message": e.toString(),
      };
    }
  }

  // ================= SENSOR DATA =================

  static Future<Map<String, dynamic>> getSensorData() async {
    try {
      final url = Uri.parse("$baseUrl/api/sensors/");

      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception("Failed to load sensor data");
    } catch (e) {
      print("SENSOR ERROR : $e");
      throw Exception(e.toString());
    }
  }
}