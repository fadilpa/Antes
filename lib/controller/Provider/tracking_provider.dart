import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/tracking_api.dart';
import 'package:mentegoz_technologies/model/tracking_model.dart';


class JourneyProvider extends ChangeNotifier {
  TrackingRespones? _apiResponse;
  bool _isLoading = true;

  TrackingRespones? get apiResponse => _apiResponse;
  bool get isLoading => _isLoading;

  Future<void> fetchJourneys({firebase_id, serviceId}) async {
    _isLoading = true;
    notifyListeners();

    try {
      TrackingApiService apiService = TrackingApiService();
      _apiResponse = await apiService.fetchJourneys(serviceId);
    } catch (e) {
      print("Error fetching journeys: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
