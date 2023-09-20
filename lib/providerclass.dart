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
  String? _userName;

  String? get userName => _userName;

  void setuserName(String id) {
    _userName = id;
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
