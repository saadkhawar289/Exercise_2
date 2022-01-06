import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  final String _email = 'saad123@gmail.com';
  final String _pass = '123456';
  late SharedPreferences preferences;

  Future<bool> authenticate(String email, String pass) async {
    if (email == _email && pass == _pass) {
      return true;
    } else {
      return false;
    }
  }

  void addTokenToLocale() async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool("token", true);
  }

  Future<bool> fetchTokenFromLocale() async {
    bool val;
    preferences = await SharedPreferences.getInstance();
    val = preferences.getBool("token")!;
    return val;
  }

  Future<void> delToken() async {
    preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
