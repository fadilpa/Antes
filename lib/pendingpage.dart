import 'dart:async';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentegoz_technologies/model.dart';
import 'package:mentegoz_technologies/providerclass.dart';
import 'package:provider/provider.dart';

class PendingPage extends StatefulWidget {
  const PendingPage({super.key});

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  late Future<List<Services>> futureDataList;

  @override
  void initState() {
    super.initState();
    futureDataList = fetchAlbum();
  }

  Future<List<Services>> fetchAlbum() async {
    final firebaseIdProvider =
        Provider.of<FirebaseIdProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse('https://antes.meduco.in/api/get_services'),
      body: {
        'firebase.id': firebaseIdProvider.firebaseId ?? '',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Datum.fromJson(jsonDecode(response.body));
      print("Got Response!");

      var data = servicesFromJson(response.body);
      print(data);
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Services>>(
          future: futureDataList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              print("Data fetched");
              print(snapshot.data!);
              final dataList = snapshot.data![0].data;
              print(dataList!.length);
              print("Printing lists of data");
              if (dataList.isEmpty) {
                return Text('No Data');
              }
              if (dataList == null) {
                return Text('No Data');
              }

              return Column(
                children:
                    dataList.map((data) => Text(data.clientName!)).toList(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('No Data');
            }
          },
        ),
      ),
    );
  }
}
