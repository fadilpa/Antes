import 'package:flutter/material.dart';

class JourneyStateProvider extends ChangeNotifier {
  bool journeyStarted = false;

  void setJourneyStarted(bool journeyStarted) {
    this.journeyStarted = journeyStarted;
    notifyListeners();
  }
}
