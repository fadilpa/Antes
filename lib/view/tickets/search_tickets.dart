import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/api_data_providers.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_and_complete_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/view/app_bars/tickets_app_bar.dart';
import 'package:mentegoz_technologies/view/tickets/ticket_tracking.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/ticket_model.dart';
import 'package:http/http.dart' as http;

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  late Future<List<Tickets>> ticketsFuture;
  getusername_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('Name');
      number = prefs.getString('Mobile');
    });
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<LocationProvider>(context, listen: false)
    //     .getLocationAndAddress();
    getusername_and_number();
    ticketsFuture = fetchTickets();
  }

  String? name;
  String? number;
// PostData postData;

  @override
  Widget build(BuildContext context) {
    // var datas= Provider.of<ServiceProvider>(context)
    //                         .getTickes(context);
    var userProvider = Provider.of<UserNameAndNumber>(context);
    userProvider.get_user_name_and_number();
    // var firebase_id=   prefs.getString('Firebase_Id');;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            // expandedHeight: ,
            forceElevated: true,
            elevation: 1,
            backgroundColor: Colors.white,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Tickets",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
              tooltip: 'Back',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userProvider.name?.split(' ').first ?? "User Name",
                          style: mainTextStyleBlack.copyWith(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(userProvider.number ?? "",
                          style: mainTextStyleBlack.copyWith(fontSize: 12)),
                    ],
                  ),
                  SizedBox(
                    width: screenWidth / 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth / 30),
                    child: CircleAvatar(
                      backgroundColor: mainThemeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height: screenHeight - 100,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: screenHeight / 30,
                    // ),
                    // SizedBox(
                    //   height: screenHeight / 60,
                    // ),
                    Expanded(
                      child: FutureBuilder<List<Tickets>>(
                        future: ticketsFuture,
                        // shrinkWrap: true,
                        // future: p.getTickes(firebase_id:"" ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            ); // or any other loading indicator
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Text('No data available');
                          } else {
                            // List<Datum> tickets = snapshot.data!.data;
                            var data = snapshot.data![0].data;
                            // print(data![0].reason);
                            return ListView.builder(

                                // gridDelegate:
                                //     SliverGridDelegateWithMaxCrossAxisExtent(
                                //         maxCrossAxisExtent: screenHeight / 3.5),
                                itemCount: data!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      
                                                  Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TicketTracking(ticket_id: data[index].ticketNumber)));
                                             
                                    },
                                    child: SizedBox(
                                      height: screenHeight / 7,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data[index].serviceName ?? "",
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    data[index].ticketNumber ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                data[index].reason ?? "",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  data[index].status != null
                                                      ? data[index].status ==
                                                              'Accepted'
                                                          ? Text(
                                                              data[index]
                                                                      .status ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .green),
                                                            )
                                                          : Text(
                                                              data[index]
                                                                      .status ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          232,
                                                                          0,
                                                                          0)),
                                                            )
                                                      : Text(""),
                                              
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Tickets>> fetchTickets({firebase_id}) async {
    final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
    String? Firebase_Id = prefs.getString('Firebase_Id');
    //  print("hgvhbjknk");
    // final firebaseIdProvider =
    //     Provider.of<FirebaseIdProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse('http://antesapp.com/api/ticket_list'),
      body: {
        'firebase.id': Firebase_Id,
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Datum.fromJson(jsonDecode(response.body));
      print("nnb");
      var data = ticketsFromJson(response.body);
      //  pendingData= data;
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
