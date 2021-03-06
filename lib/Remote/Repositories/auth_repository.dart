import 'package:amizone_clientapp/Remote/Requests/login.dart';
import 'package:amizone_clientapp/Remote/Responses/auth_token.dart';
import 'package:amizone_clientapp/Remote/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';


/// Repository taking care of authentication. Its main task is to serve as an abstraction
/// layer over [AuthService]. [AuthRepository] exposes following actions:
/// - user login and logout
/// - user registration
/// - persisting JWT tokens
/// - deleting JWT tokens
class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();
  static const AUTH_TOKEN = "auth-token";
  final _storage = FlutterSecureStorage();

  AuthRepository._internal();

  Future<AuthToken> login(Login login) async {
    final body = await ApiManager.callSafely(() => ApiManager.instance.authService.login(login));
    return AuthToken.fromJson(body);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: AUTH_TOKEN);
    Logger.root.info("Deleted token.");
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: AUTH_TOKEN, value: "Bearer $token");
    Logger.root.info("Persisted token.");
  }

  Future<String> getToken() async {
    final String token = await _storage.read(key: AUTH_TOKEN);

    if (token != null) {
      Logger.root.info("Has token!");
    } else {
      Logger.root.info("Does not have token!");
    }

    return token;
  }
}
