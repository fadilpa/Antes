import 'package:flutter/material.dart';

class FirebaseIdProvider extends ChangeNotifier {
  String? _firebaseId;

  String? get firebaseId => _firebaseId;

  void setFirebaseId(String id) {
    _firebaseId = id;
    notifyListeners();
  }
}
