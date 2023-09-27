import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_provider.dart';
import 'package:mentegoz_technologies/model/completed_model.dart';
import 'package:mentegoz_technologies/controller/custom_button.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/view/app_bars/sevice_app_bar.dart';
import 'package:mentegoz_technologies/view/tickets/ticket_page.dart';
import 'package:provider/provider.dart';

class CompletedServicePage extends StatelessWidget {
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

  // GetUserNameAndNumber nameandnumber = GetUserNameAndNumber();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserNameAndNumber>(context);
    userProvider.get_user_name_and_number();
    // ignore: unused_local_variable
    List<CompletedServicesModel> serviceData = [];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<CompletedServicesModel>>(
        future: Provider.of<ServiceProvider>(context)
            .fetchCompletedAlbum(), // Provide the correct firebaseId
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
                      ServiceAppBar(
                          screenHeight: screenHeight,
                          userProvider: userProvider,
                          screenWidth: screenWidth),
                       ];
                         },
                       body: SingleChildScrollView(
                      child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight / 25,
                        ),
                        Text(
                          servicename.toUpperCase() ??
                              "No Service Name".toUpperCase(),
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight / 25,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth / 8.5),
                          child: Column(children: [
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
                                    clientName.toUpperCase() ??
                                        "No Client Name".toUpperCase(),
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
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
                                    address.toUpperCase() ??
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
                                  landmark.toUpperCase() ??
                                      "No Categorised".toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
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
                                const Icon(
                                  Icons.date_range,
                                  color: Color.fromARGB(255, 60, 180, 229),
                                ),
                                SizedBox(
                                  width: screenWidth / 50,
                                ),
                                Text(
                                  (startdate == null
                                          ? "Date Not Defined".toUpperCase()
                                          : startdate) +
                                      (starttime != null
                                          ? " ($starttime)"
                                          : "Time Not Defined".toUpperCase()),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
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
                                const Icon(
                                  Icons.date_range,
                                  color: Color.fromARGB(255, 60, 180, 229),
                                ),
                                SizedBox(
                                  width: screenWidth / 50,
                                ),
                                Text(
                                  (enddate == null
                                          ? "Date Not Defined".toUpperCase()
                                          : enddate) +
                                      (endtime != null
                                          ? " ($endtime)"
                                          : "Time Not Defined".toUpperCase()),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
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
                                          CupertinoIcons.plus_rectangle,
                                          color:
                                              Color.fromARGB(255, 60, 180, 229),
                                        ),
                                        SizedBox(
                                          width: screenWidth / 50,
                                        ),
                                        Text(
                                          priority ??
                                              "No Priority".toUpperCase(),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16,
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
                                        const Icon(
                                          Icons.phone,
                                          color:
                                              Color.fromARGB(255, 60, 180, 229),
                                        ),
                                        SizedBox(
                                          width: screenWidth / 50,
                                        ),
                                        Text(
                                          phone.toUpperCase() ??
                                              "No Landmark".toUpperCase(),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16,
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
                                            email.toUpperCase() ??
                                                "No Email".toUpperCase(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
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
                                          CupertinoIcons
                                              .rectangle_fill_on_rectangle_angled_fill,
                                          color:
                                              Color.fromARGB(255, 60, 180, 229),
                                        ),
                                        SizedBox(
                                          width: screenWidth / 50,
                                        ),
                                        Text(
                                          refNo.toUpperCase() ??
                                              "No refno".toUpperCase(),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
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
              ),
            );
          }
          return Container(
            color: Colors.amber,
          );
        });
  }
}
