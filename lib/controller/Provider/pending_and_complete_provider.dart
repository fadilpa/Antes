import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/model/completed_model.dart';
import 'package:mentegoz_technologies/model/pending_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class ServiceProvider extends ChangeNotifier{

  Future<List<Autogenerated>>? pendingData;

Future<List<CompletedServicesModel>> fetchCompletedAlbum() async {
  final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
  String? firebase_Id = prefs.getString('Firebase_Id');

  final response = await http.post(
    Uri.parse('https://antes.meduco.in/api/get_services_completed'),
    body: {
      'firebase.id': firebase_Id,
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Datum.fromJson(jsonDecode(response.body));

    var data = CompletedServicesfromjson(response.body);
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

setdata(){
  pendingData=fetchAlbum();
  // notifyListeners();
}

Future<List<Autogenerated>> fetchAlbum() async {
  final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
  String? Firebase_Id = prefs.getString('Firebase_Id');
  // final firebaseIdProvider =
  //     Provider.of<FirebaseIdProvider>(context, listen: false);
  final response = await http.post(
    Uri.parse('https://antes.meduco.in/api/get_services'),
    body: {
      'firebase.id': Firebase_Id,
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Datum.fromJson(jsonDecode(response.body));

   var data = GeneratedFromJson(response.body);
  //  pendingData= data;
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  
}

}