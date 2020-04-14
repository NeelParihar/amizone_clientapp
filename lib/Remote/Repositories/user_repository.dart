
import 'package:amizone_clientapp/Remote/Models/attendance.dart';
import 'package:amizone_clientapp/Remote/Models/user.dart';
import 'package:amizone_clientapp/Remote/api_manager.dart';

class UserRepository {
  static final UserRepository instance = UserRepository._internal();

  UserRepository._internal();

  /// Returns user profile with the specified id
  Future<User> getUser(int userId) async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.userService.getUser(userId));
    return User.fromJson(body);
  }
  /// Returns current user profile
  Future<User> getCurrentUser() async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.userService.getCurrentUser());
    return User.fromJson(body);
  }

  Future<List<Attendance>> getAllTasks() async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.userService.getAllAttendance());
    List<Attendance> tasks = [];

    for (var user in body) {
      tasks.add(Attendance.fromJson(user));
    }

    return tasks;
  }

}
