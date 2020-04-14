import 'dart:io';

import 'package:amizone_clientapp/Remote/Services/auth_service.dart';
import 'package:amizone_clientapp/Remote/Services/user_service.dart';
import 'package:amizone_clientapp/failure.dart';
import 'package:amizone_clientapp/typedefs.dart';
import 'package:logging/logging.dart';


/// Singleton class that gathers all services in one place.
class ApiManager {
  static final instance = ApiManager._internal();

  final AuthService authService = AuthService.create();
  final UserService userService = UserService.create();

  ApiManager._internal();

  /// Convenience method to reduce boilerplate. Invokes API function
  /// and catches all possible errors.
  static Future<T> callSafely<T>(ApiFunction apiFunction) async {
    try {
      final response = await apiFunction();

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      return response.body;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }
}
