import 'package:expand_widget/expand_widget.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentegoz_technologies/api.dart';
import 'package:mentegoz_technologies/compledted_model.dart';
import 'package:mentegoz_technologies/custom_button.dart';
import 'package:mentegoz_technologies/get_user_name_number.dart';
import 'package:mentegoz_technologies/pending_service_page.dart';
import 'package:mentegoz_technologies/ticketpage.dart';
import 'package:mentegoz_technologies/uploadedbill.dart';
import 'package:mentegoz_technologies/util/styles.dart';
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
                            "Completed Services",
                            style:mainTextStyleBlack.copyWith(fontWeight: FontWeight.w600,fontSize: 12)
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
                                    style:   mainTextStyleBlack.copyWith(fontSize: 12,fontWeight: FontWeight.bold)
                                  ),
                                  Text(
                                    number ?? "Emp_no",
                                    style:  mainTextStyleBlack.copyWith(fontSize: 12)
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
                  body: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight / 25,
                        ),
                        Padding(
                            padding:
                                   const EdgeInsets.only(left: 30),
                          child: Text(
                            captilaize(widget.servicename) ??
                                "No Service Name".toUpperCase(),
                            style:  mainTextStyleBlack.copyWith(fontWeight: FontWeight.w600,decoration: TextDecoration.underline)
                          ),
                        ),
                        SizedBox(
                          height: screenHeight / 25,
                        ),
                        Padding(
                          padding:
                                    const EdgeInsets.only(left: 30),
                          child: Column(
                            children:[
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.person_solid,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Flexible(
                                child: Text(
                                 captilaize(widget.clientName)  ??
                                      "No Client Name".toUpperCase(),
                                   style:mainTextStyleBlack.copyWith(fontSize: 16)
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
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
                                  widget.address ??
                                      "Not Address Added".toUpperCase(),
                                  style: mainTextStyleBlack.copyWith(fontSize: 16)
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
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
                                widget.landmark ??
                                    "No Categorised",
                                style: mainTextStyleBlack.copyWith(fontSize: 16)
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.clock_fill,
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
                                        ? " ,${widget.starttime}"
                                        : "Time Not Defined".toUpperCase()),
                                style: mainTextStyleBlack.copyWith(fontSize: 16)
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.clock_fill,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                (widget.enddate == null
                                        ? "Date Not Defined"
                                        : widget.enddate) +
                                    (widget.endtime != null
                                        ? " , ${widget.endtime}"
                                        : "Time Not Defined"),
                                style: mainTextStyleBlack.copyWith(fontSize: 16)
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: ExpandChild(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.arrow_up_circle_fill,
                                        color:
                                            Color.fromARGB(255, 60, 180, 229),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 50,
                                      ),
                                      Text(
                                        widget.priority ??
                                            "No Priority",
                                        style: mainTextStyleBlack.copyWith(fontSize: 16)
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 25,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                       Icons.phone,
                                        color:
                                            Color.fromARGB(255, 60, 180, 229),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 50,
                                      ),
                                      Text(
                                        widget.phone??
                                            "No Landmark".toUpperCase(),
                                        style: mainTextStyleBlack.copyWith(fontSize: 16)
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 25,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.mail,
                                        color:
                                            Color.fromARGB(255, 60, 180, 229),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 50,
                                      ),
                                      Flexible(
                                        child: Text(
                                          widget.email??
                                              "No Email".toUpperCase(),
                                          style: mainTextStyleBlack.copyWith(fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 25,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                       CupertinoIcons.tag_fill,
                                        color:
                                            Color.fromARGB(255, 60, 180, 229),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 50,
                                      ),
                                      Text(
                                        widget.refNo.toUpperCase() ??
                                            "No refno".toUpperCase(),
                                        style:mainTextStyleBlack.copyWith(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                                              ]),
                        ),
                        SizedBox(height: screenHeight/15,),
                        Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustmButton(
                                      butoontext: 'Raise a Ticket',
                                      buttonaction: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              RaisedTicket(),
                                        ));
                                      }),
                                ],
                              ),
                            ]),
                            SizedBox(height: screenHeight/20,),
                      ],
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
