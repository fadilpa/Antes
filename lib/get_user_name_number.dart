import 'package:shared_preferences/shared_preferences.dart';

class GetUserNameAndNumber {
  String? name;
  String? number;

  getusername_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name');
    number = prefs.getString('Mobile');
    print(name);
    print(number);
  }
}
