import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_and_complete_provider.dart';
import 'package:mentegoz_technologies/controller/capitalize.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/model/completed_model.dart';
import 'package:mentegoz_technologies/controller/custom_button.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/view/app_bars/complete_page_app_bar.dart';
import 'package:mentegoz_technologies/view/app_bars/sevice_app_bar.dart';
import 'package:mentegoz_technologies/view/tickets/ticket_page.dart';
import 'package:mentegoz_technologies/view/tickets/ticket_raised_box.dart';
import 'package:provider/provider.dart';

class CompletedServicePage extends StatelessWidget {
  const CompletedServicePage(
      {super.key,
      this.id,
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
  final int? id;
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

  // GetUserNameAndNumber nameandnumber = GetUserNameAndNumber();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserNameAndNumber>(context);
    userProvider.get_user_name_and_number();
    // ignore: unused_local_variable
    List<CompletedServicesModel> serviceData = [];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // return FutureBuilder<List<CompletedServicesModel>>(
    //     future: Provider.of<ServiceProvider>(context)
    //         .fetchCompletedAlbum(), // Provide the correct firebaseId
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //             child:
    //                 CircularProgressIndicator()); // Show a loading indicator while fetching data
    //       } else if (snapshot.hasData) {
    //         // Data is available, update the serviceData variable
    //         serviceData = snapshot.data!;

            // Continue building your UI with the fetched data
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    CompleteAppBar(
                        screenHeight: screenHeight,
                        userProvider: userProvider,
                        screenWidth: screenWidth),
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
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                            captilaize(servicename) ?? "No Service Name",
                            style: mainTextStyleBlack.copyWith(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline)),
                      ),
                      SizedBox(
                        height: screenHeight / 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Column(children: [
                          Row(
                            children: [
                               Icon(
                                CupertinoIcons.person_solid,
                                color: mainThemeColor,
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Flexible(
                                child: Text(clientName ?? "No Client Name",
                                    style: mainTextStyleBlack.copyWith(
                                        fontSize: 14)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Row(
                            children: [
                               Icon(
                                CupertinoIcons.location_solid,
                                color: mainThemeColor,
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Flexible(
                                child: Text(address ?? "Not Address Added",
                                    style: mainTextStyleBlack.copyWith(
                                        fontSize: 14)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Row(
                            children: [
                               Icon(
                                Icons.landscape,
                                color: mainThemeColor,
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(landmark ?? "No Categorised",
                                  style: mainTextStyleBlack.copyWith(
                                      fontSize: 14))
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Row(
                            children: [
                               Icon(
                                CupertinoIcons.clock_fill,
                                color: mainThemeColor,
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                  (startdate == null
                                          ? "Date Not Defined"
                                          : startdate) +
                                      (starttime != null
                                          ? " ($starttime)"
                                          : "Time Not Defined"),
                                  style: mainTextStyleBlack.copyWith(
                                      fontSize: 14))
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Row(
                            children: [
                               Icon(
                                CupertinoIcons.clock_fill,
                                color: mainThemeColor,
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                  (enddate == null
                                          ? "Date Not Defined"
                                          : enddate) +
                                      (endtime != null
                                          ? " ($endtime)"
                                          : "Time Not Defined"),
                                  style: mainTextStyleBlack.copyWith(
                                      fontSize: 14))
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          // Row(
                          //   children: [
                          //      Icon(
                          //       CupertinoIcons.arrow_up_circle_fill,
                          //       color: mainThemeColor,
                          //     ),
                          //     // SizedBox(
                          //     //   width: screenWidth / 50,
                          //     // ),
                          //     // Text(priority ?? "No Priority",
                          //     //     style: mainTextStyleBlack.copyWith(
                          //     //         fontSize: 14))
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: screenHeight / 25,
                          // ),
                          Padding(
                            padding:  EdgeInsets.only(right: screenWidth/11),
                            child: ExpandChild(
                              child: Column(children: [
                                Row(
                                  children: [
                                     Icon(
                                      Icons.phone,
                                      color:
                                          mainThemeColor,
                                    ),
                                    SizedBox(
                                      width: screenWidth / 50,
                                    ),
                                    Text(
                                      phone ?? "No Phone",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight / 25,
                                ),
                                Row(
                                  children: [
                                     Icon(
                                      CupertinoIcons.mail,
                                      color:
                                          mainThemeColor,
                                    ),
                                    SizedBox(
                                      width: screenWidth / 50,
                                    ),
                                    Flexible(
                                      child: Text(email ?? "No Email",
                                          style: mainTextStyleBlack.copyWith(
                                              fontSize: 14)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight / 25,
                                ),
                                Row(
                                  children: [
                                     Icon(
                                      CupertinoIcons.tag_fill,
                                      color:
                                          mainThemeColor,
                                    ),
                                    SizedBox(
                                      width: screenWidth / 50,
                                    ),
                                    Text(refNo ?? "No refno",
                                        style: mainTextStyleBlack.copyWith(
                                            fontSize: 14))
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ]),
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
                                    buttontext: 'Raise a Ticket',
                                    buttonaction: () {
                                         Provider.of<LocationProvider>(context, listen: false)
        .updateIsTicketSubmitted(false);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => RaisedTicket(),
                                      ));
                                    }),
                              ],
                            ),
                          ]),
                      SizedBox(
                        height: screenHeight / 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
//           }
//           return Container(
//             color: Colors.amber,
//           );
//         });
  }
}
