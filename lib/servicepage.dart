import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentegoz_technologies/ticketpage.dart';
import 'package:mentegoz_technologies/uploadedbill.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: screenHeight * 0.13,
                forceElevated: true,
                elevation: 3,
                backgroundColor: Colors.white,
                flexibleSpace:  FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Services",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
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
                            'Thomas',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '123456',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth / 30),
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
                    'Service Name',
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
                        'Client Name',
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
                      Text(
                        'Client Address',
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
                        CupertinoIcons.phone_fill,
                        color: Color.fromARGB(255, 60, 180, 229),
                      ),
                      SizedBox(
                        width: screenWidth / 50,
                      ),
                      Text(
                        'Client phone',
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
                        Icons.access_time_filled_rounded,
                        color: Color.fromARGB(255, 60, 180, 229),
                      ),
                      SizedBox(
                        width: screenWidth / 50,
                      ),
                      Text(
                        'Start Date,Start Time',
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
                        Icons.access_time_filled_rounded,
                        color: Color.fromARGB(255, 60, 180, 229),
                      ),
                      SizedBox(
                        width: screenWidth / 50,
                      ),
                      Text(
                        'End Date,End Time',
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
                      children: [
                        Row(
                          children: [
                            CustmButton(
                                butoontext: 'Start', buttonaction: () {}),
                            SizedBox(
                              width: screenWidth / 50,
                            ),
                            CustmButton(butoontext: 'End', buttonaction: () {})
                          ],
                        ),
                        SizedBox(
                          height: screenHeight / 50,
                        ),
                        Row(
                          children: [
                            CustmButton(
                                butoontext: 'Upload Bill',
                                buttonaction: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UpLoadBill(),
                                  ));
                                }),
                            SizedBox(
                              width: screenWidth / 50,
                            ),
                            CustmButton(
                                butoontext: 'Raise a Ticket',
                                buttonaction: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RaisedTicket(),
                                  ));
                                })
                          ],
                        ),
                        //  SizedBox(
                        //   height: 0,
                        // )
                      ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustmButton extends StatelessWidget {
  const CustmButton(
      {super.key, required this.butoontext, required this.buttonaction});
  final String butoontext;

  final Function() buttonaction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
            minimumSize: const Size(143, 42),
            backgroundColor: (const Color.fromARGB(255, 60, 180, 229))),
        onPressed: buttonaction,
        child: Text(
          butoontext,
          style: GoogleFonts.montserrat(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
        ));
  }
}
