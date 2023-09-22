import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentegoz_technologies/api.dart';
import 'package:mentegoz_technologies/compledted_model.dart';
import 'package:mentegoz_technologies/custom_button.dart';
import 'package:mentegoz_technologies/get_user_name_number.dart';
import 'package:mentegoz_technologies/uploadedbill.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedServicePage extends StatefulWidget {
  const CompletedServicePage(
      {super.key,
      required this.index,
      required this.servicename,
      this.refNo,
      this.startdate,
      this.starttime,
      this.enddate,
      this.endtime,
      this.priority,
      this.clientName,
      this.phone,
      this.email,
      this.address,
      this.landmark,
      this.category});

  final int index;
  final clientName;
  final refNo;
  final category;
  final startdate;
  final enddate;
  final servicename;
  final endtime;
  final starttime;
  final priority;
  final phone;
  final email;
  final address;
  final landmark;

  @override
  State<CompletedServicePage> createState() => _CompletedServicePageState();
}

class _CompletedServicePageState extends State<CompletedServicePage> {
  GetUserNameAndNumber nameandnumber = GetUserNameAndNumber();
  String? name;
  String? number;
  LocationData? currentLocation;
  String address = "";
  bool journeyStarted = false;
  TimeOfDay currentTime = TimeOfDay.now();
  final geolocate = Geolocator();

  getusername_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name');
    number = prefs.getString('Mobile');
  }

  @override
  void initState() {
    super.initState();
    getusername_and_number();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List<CompletedServicesModel> serviceData = [];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<CompletedServicesModel>>(
        future: fetchCompletedAlbum(), // Provide the correct firebaseId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator while fetching data
          } else if (snapshot.hasData) {
            // Data is available, update the serviceData variable
            serviceData = snapshot.data!;

            // Continue building your UI with the fetched data
            return SafeArea(
              child: Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        expandedHeight: screenHeight * 0.13,
                        forceElevated: true,
                        elevation: 3,
                        backgroundColor: Colors.white,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(
                            "Services",
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    name!.split(' ').first ?? "User Name",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    number ?? "Emp_no",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 30,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: screenWidth / 30),
                                child: CircleAvatar(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ];
                  },
                  body: Container(
                    height: screenHeight / 1,
                    width: screenWidth / 2,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight / 15,
                          ),
                          Text(
                            widget.servicename.toUpperCase() ??
                                "No Service Name".toUpperCase(),
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.person_solid,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                widget.clientName.toUpperCase() ??
                                    "No Client Name".toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.location_solid,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Flexible(
                                child: Text(
                                  widget.address.toUpperCase() ??
                                      "Not Address Added".toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.landscape,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                widget.landmark.toUpperCase() ??
                                    "No Categorised".toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                (widget.startdate == null
                                        ? "Date Not Defined".toUpperCase()
                                        : widget.startdate) +
                                    (widget.starttime != null
                                        ? " (${widget.starttime})"
                                        : "Time Not Defined".toUpperCase()),
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                (widget.enddate == null
                                        ? "Date Not Defined".toUpperCase()
                                        : widget.enddate) +
                                    (widget.endtime != null
                                        ? " (${widget.endtime})"
                                        : "Time Not Defined".toUpperCase()),
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 15,
                          ),
                          Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustmButton(
                                        butoontext: 'Upload Bill',
                                        buttonaction: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => UpLoadBill(),
                                          ));
                                        }),
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container(
            color: Colors.amber,
          );
        });
  }
}
