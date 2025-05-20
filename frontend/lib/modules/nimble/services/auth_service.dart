import 'dart:convert';
import 'package:frontend/modules/nimble/models/login_request.dart';
import 'package:frontend/modules/nimble/models/user_registration.dart';
import 'package:frontend/resources/strings.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> register(UserRegistration user) async {
    final url = Uri.parse("$authURL/registration");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print("Registration failed: ${response.body}");
      return false;
    }
  }

  Future<bool> login(LoginRequest request) async {
    final url = Uri.parse('$authURL/authentication');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      // You can store token here if needed
      print("Login successful: ${response.body}");
      return true;
    } else {
      print("Login failed: ${response.body}");
      return false;
    }
  }
}
