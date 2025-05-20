import 'package:flutter/foundation.dart';
import 'package:frontend/modules/nimble/models/login_request.dart';
import 'package:frontend/modules/nimble/models/user_registration.dart';
import 'package:frontend/modules/nimble/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String errorMessage = '';

  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    notifyListeners();

    final user = UserRegistration(name: name, email: email, password: password);
    final success = await _authService.register(user);

    isLoading = false;
    if (!success) {
      errorMessage = "Registration failed. Please try again.";
      notifyListeners();
    }

    return success;
  }

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final request = LoginRequest(email: email, password: password);
    final success = await _authService.login(request);

    isLoading = false;
    if (!success) {
      errorMessage = "Invalid email or password";
      notifyListeners();
    }

    return success;
  }
}
