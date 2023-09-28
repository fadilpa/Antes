import 'package:flutter/material.dart';

class FirebaseIdProvider extends ChangeNotifier {

  String? _firebaseId;

  String? get firebaseId => _firebaseId;

  void setFirebaseId(String id) {
    _firebaseId = id;
    notifyListeners();
  }
}

class NameProvider extends ChangeNotifier {
  // late var userdatalist=get_profile_data
  late var userName;

  String? get userName_data => userName;

  void setuserName(String id) {
    userName = id;
    notifyListeners();
  }
}

class MobileProvider extends ChangeNotifier {
  String? _mobileNumber;

  String? get mobileNumber => _mobileNumber;

  void setmobileNumber(String id) {
    _mobileNumber = id;
    notifyListeners();
  }
}
