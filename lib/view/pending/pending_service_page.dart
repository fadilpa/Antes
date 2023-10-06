import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/image_picker_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_and_complete_provider.dart';
import 'package:mentegoz_technologies/controller/capitalize.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/view/app_bars/pending_page_app_bar.dart';
import 'package:mentegoz_technologies/view/app_bars/sevice_app_bar.dart';
import 'package:mentegoz_technologies/controller/custom_button.dart';
import 'package:mentegoz_technologies/controller/dialog_boxes/end_dialog_box.dart';
import 'package:mentegoz_technologies/controller/dialog_boxes/start_dialog_box.dart';
import 'package:mentegoz_technologies/model/pending_model.dart';
import 'package:mentegoz_technologies/view/tickets/ticket_raised_box.dart';
import 'package:mentegoz_technologies/view/upload_bill/uploadedbill.dart';
import 'package:mentegoz_technologies/controller/varibles.dart';
import 'package:mentegoz_technologies/view/tickets/ticket_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingServicePage extends StatelessWidget {
  PendingServicePage(
      {super.key,
      required this.index,
      this.id,
      required this.clientName,
      this.refNo,
      this.category,
      this.startdate,
      this.enddate,
      this.servicename,
      this.endtime,
      this.starttime,
      this.Catgory,
      this.Landmark,
      this.Email,
      this.Address,
      this.Phone});

  final int index;
  final clientName;
  final id;
  final refNo;
  final category;
  final startdate;
  final enddate;
  final servicename;
  final endtime;
  final starttime;
  final Catgory;
  final Landmark;
  final Email;
  final Address;
  final Phone;

  @override
  Widget build(BuildContext context) {
    // Provider.of<OpenCameraProvider>(context,listen:false).emptyImage();
    // int count = 1;
    // final addresSResult = context.read<LocationProvider>().address;
      
   Provider.of<LocationProvider>(context, listen: false).getLocationAndAddress;
    Provider.of<LocationProvider>(context, listen: false).address;
    String? currentTime = DateTime.now().toString();
    final addressresult = context.read<LocationProvider>().address;
    var userProvider = Provider.of<UserNameAndNumber>(context);
    userProvider.get_user_name_and_number();
    // ignore: unused_local_variable
    List<Autogenerated> serviceData = [];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // return FutureBuilder<List<Autogenerated>>(
    //     future: Provider.of<ServiceProvider>(context)
    //         .fetchAlbum(), // Provide the correct firebaseId
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //             child:
    //                 CircularProgressIndicator()); // Show a loading indicator while fetching data
    //       } else {
    //         // Data is available, update the serviceData variable
    //         serviceData = snapshot.data!;

            // Continue building your UI with the fetched data
            return Scaffold(
              body: Consumer<LocationProvider>(
                builder: (context, value, child) {
                  return NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        PendingAppBar(
                            screenHeight: screenHeight,
                            userProvider: userProvider,
                            screenWidth: screenWidth
                            ),
                      ];
                    },
                    body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                      captilaize(servicename) ??
                                          "No Service Name",
                                      style: mainTextStyleBlack.copyWith(
                                          fontWeight: FontWeight.w600,
                                          decoration:
                                              TextDecoration.underline)),
                                ),
                                SizedBox(
                                  height: screenHeight / 25,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.person_solid,
                                          color: Color.fromARGB(
                                              255, 60, 180, 229),
                                        ),
                                        SizedBox(
                                          width: screenWidth / 50,
                                        ),
                                        Flexible(
                                          child: Text(
                                              captilaize(clientName) ??
                                                  "No Service Name",
                                              style: mainTextStyleBlack
                                                  .copyWith(fontSize: 14)),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight / 25,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Color.fromARGB(
                                              255, 60, 180, 229),
                                        ),
                                        SizedBox(
                                          width: screenWidth / 50,
                                        ),
                                        Flexible(
                                          child: Text(
                                              Address ?? "No Address added",
                                              style: mainTextStyleBlack
                                                  .copyWith(fontSize: 14)),
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
                                          color: Color.fromARGB(
                                              255, 60, 180, 229),
                                        ),
                                        SizedBox(
                                          width: screenWidth / 50,
                                        ),
                                        Flexible(
                                          child: Text(
                                              Phone ?? "No Mobile Number",
                                              style: mainTextStyleBlack
                                                  .copyWith(fontSize: 14)),
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
                                          color: Color.fromARGB(
                                              255, 60, 180, 229),
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
                                            style: mainTextStyleBlack
                                                .copyWith(fontSize: 14))
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight / 25,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.clock_fill,
                                          color: Color.fromARGB(
                                              255, 60, 180, 229),
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
                                            style: mainTextStyleBlack
                                                .copyWith(fontSize: 14)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight / 25,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: screenWidth / 11),
                                      child: ExpandChild(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.category,
                                                  color: Color.fromARGB(
                                                      255, 60, 180, 229),
                                                ),
                                                SizedBox(
                                                  width: screenWidth / 50,
                                                ),
                                                Text(Catgory ?? "No Category",
                                                    style: mainTextStyleBlack
                                                        .copyWith(
                                                           fontSize: 14))
                                              ],
                                            ),
                                            SizedBox(
                                              height: screenHeight / 25,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_city_rounded,
                                                  color: Color.fromARGB(
                                                      255, 60, 180, 229),
                                                ),
                                                SizedBox(
                                                  width: screenWidth / 50,
                                                ),
                                                Text(
                                                    Landmark ?? "No Landmark",
                                                    style: mainTextStyleBlack
                                                        .copyWith(
                                                           fontSize: 14))
                                              ],
                                            ),
                                            SizedBox(
                                              height: screenHeight / 25,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.mail,
                                                  color: Color.fromARGB(
                                                      255, 60, 180, 229),
                                                ),
                                                SizedBox(
                                                  width: screenWidth / 50,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                      Email ?? "No Email",
                                                      style:
                                                          mainTextStyleBlack
                                                              .copyWith(
                                                                  fontSize:
                                                                      14)),
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
                                                  color: Color.fromARGB(
                                                      255, 60, 180, 229),
                                                ),
                                                SizedBox(
                                                  width: screenWidth / 50,
                                                ),
                                                Text(refNo ?? "No refno",
                                                    style: mainTextStyleBlack
                                                        .copyWith(
                                                           fontSize: 14))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ]),
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustmButton(
                                    buttontext: 'Start Journey',
                                    buttonaction: () async {
                                      value.getLocationAndAddress();
                                      final prefs = await SharedPreferences
                                          .getInstance();
                                      bool? journeyStatus =
                                          prefs.getBool('isStarted');
                                   showStartDialog(
                                          context,
                                          journeyStatus,
                                          Provider.of<LocationProvider>(
                                                  context,
                                                  listen: false)
                                              .currentService!
                                              .id);
                                    }),
                                SizedBox(
                                  width: screenWidth / 50,
                                ),
                                CustmButton(
                                    buttontext: 'End Journey',
                                    buttonaction: () async {
                                      final prefs = await SharedPreferences
                                          .getInstance();
                                      int? Saved_ID = prefs.getInt('SavedId');
                                      value.getLocationAndAddress();

                                      endDialogBox(
                                          context,
                                          Saved_ID,
                                          Provider.of<LocationProvider>(
                                                  context,
                                                  listen: false)
                                              .currentService!
                                              .id);
                                    })
                              ],
                            ),
                            SizedBox(
                              height: screenHeight / 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustmButton(
                                    buttontext: 'Upload Bill',
                                    buttonaction: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => UpLoadBill(),
                                      ));
                                    }),
                                SizedBox(
                                  width: screenWidth / 50,
                                ),
                                CustmButton(
                                    buttontext: 'Raise a Ticket',
                                    buttonaction: () {
                                         Provider.of<LocationProvider>(context, listen: false)
        .updateIsTicketSubmitted(false);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => RaisedTicket(),
                                      ));
                                    })
                              ],
                            ),
                            SizedBox(
                              height: screenHeight / 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: screenHeight / 17,
                                  width: screenWidth / 2.7,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                        backgroundColor: mainThemeColor),
                                    child: Text(
                                      'End Service',
                                      style: mainTextStyleBlack.copyWith(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    onPressed: () async {
                                      final prefs = await SharedPreferences
                                          .getInstance();
                                      // ignore: unused_local_variable
                                      String? Firebase_Id =
                                          prefs.getString('Firebase_Id');
                                      value.getLocationAndAddress();
                                      // currentTime.toString();
                                      // endservicedata = {
                                      //   "firebase_id": Firebase_Id,
                                      //   "service_id": servicename!,
                                      //   "geolocation": addressresult ?? "",
                                      //   "date_time": currentTime,
                                      // };
                                      await PostData().PostEndService(
                                          context,
                                          Firebase_Id,
                                          Provider.of<LocationProvider>(
                                                  context,
                                                  listen: false)
                                              .currentService!
                                              .id,
                                          addressresult,
                                          currentTime);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ])
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
