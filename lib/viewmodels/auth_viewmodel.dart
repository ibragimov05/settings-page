import 'package:settings_page/services/http/auth_http_service.dart';

class AuthViewmodel {
  final AuthHttpService _authHttpService = AuthHttpService();

  Future<void> register(
      {required String email, required String password}) async {
    try {
      await _authHttpService.register(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _authHttpService.login(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword({required String password}) async {
    try {
      await _authHttpService.resetPassword(newPassword: password);
    } catch (e) {
      rethrow;
    }
  }
}
