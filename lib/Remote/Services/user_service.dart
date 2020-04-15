import 'package:amizone_clientapp/Remote/auth_interceptor.dart';
import 'package:amizone_clientapp/constants.dart';
import 'package:chopper/chopper.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class UserService extends ChopperService {
  /// Returns the current user's home screen statistics
  @Get(path: "attendance")
  Future<Response<List<dynamic>>> getAllAttendance();

  @Get(path: "schedule")
  Future<Response<List<dynamic>>> getAllSchedule();

  @Get(path: "user")
  Future<Response<Map<String, dynamic>>> getCurrentUser();

  /// Returns a specified user's public profile of the system
  @Get(path: "user/{userId}")
  Future<Response<Map<String, dynamic>>> getUser(@Path("userId") int userId);

  static UserService create() {
    final client = ChopperClient(
        baseUrl: API_URL,
        services: [
          _$UserService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          AuthInterceptor(),
        ]);

    return _$UserService(client);
  }
}
