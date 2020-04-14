
import 'package:amizone_clientapp/Remote/Requests/login.dart';
import 'package:amizone_clientapp/constants.dart';
import 'package:chopper/chopper.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class AuthService extends ChopperService {
  @Post(path: "login")
  Future<Response<Map<String, dynamic>>> login(@Body() Login login);

  static AuthService create() {
    final client = ChopperClient(
        baseUrl: API_URL,
        services: [
          _$AuthService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
        ]);

    return _$AuthService(client);
  }
}
