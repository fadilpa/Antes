// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/shared_pref_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_and_complete_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/model/pending_model.dart';
import 'package:mentegoz_technologies/view/pending/pending_service_page.dart';
import 'package:provider/provider.dart';

class PendingPage extends StatelessWidget {
  PendingPage({super.key});

  late Future<List<Autogenerated>> futureDataList;

  // @override
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final firebaseIdProvider =
        Provider.of<FirebaseIdProvider>(context, listen: false);
   Provider.of<ServiceProvider>(context,listen: false).setdata();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<Autogenerated>>(
            future: Provider.of<ServiceProvider>(context,listen: false).pendingData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                // print(snapshot.data!);
                final dataList = snapshot.data![0].data;
                // print(dataList!.length);
                if (dataList!.isEmpty) {
                  return Text('No Data');
                }
                // ignore: unnecessary_null_comparison
                if (dataList == null) {
                  return Text('No Data');
                }
               // SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: GestureDetector(
                    child: GridView.builder(
                      shrinkWrap: true,
                        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: screenHeight,
                    maxCrossAxisExtent: 200,            
                     crossAxisSpacing: 2
                    ),
                itemCount:dataList.length ,
                 itemBuilder: (context, index) {
                    var id = dataList[index].id;
                      var servicename = dataList[index].serviceName;
                      var clientName = dataList[index].clientName!;
                      var refNo = dataList[index].refNo!;
                      var category = dataList[index].category!;
                      var startDate = dataList[index].startDate!;
                      var endDate = dataList[index].endDate!;
                      var priority = dataList[index].priority!;
                      var endtime = dataList[index].endTime!;
                      var startTime = dataList[index].startTime!;
                      var address = dataList[index].address!;
                      var email = dataList[index].email!;
                      var phone = dataList[index].phone!;
                      var landmark = dataList[index].landmark!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Service : $id',style: mainTextStyleBlack,)),
                        ),
                              SizedBox(height: screenHeight / 80),
                              GestureDetector(
                                onTap:(){
                                    Provider.of<LocationProvider>(context,
                                    listen: false)
                                .setCurrentService(dataList[index]);
                            // Navigate to the other page when an item is tapped.
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PendingServicePage(
                                  index: index,
                                  id: id,
                                  clientName: clientName,
                                  servicename: servicename,
                                  refNo: refNo,
                                  category: category,
                                  enddate: endDate,
                                  startdate: startDate,
                                  endtime: endtime,
                                  starttime: startTime,
                                  Address: address,
                                  Email: email,
                                  Phone: phone,
                                  Landmark: landmark,
                                ),
                                // Replace with the actual page you want to navigate to.
                              ),
                            );
                                } ,
                                child: Container(
                                  height: 200,
                                  width: screenWidth / 2.5,
                                  decoration: BoxDecoration(
                                    color: mainThemeColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(),
                                        Text(clientName,
                                            style: mainTextStyleBlack.copyWith(
                                                color: Colors.white)),
                                        Text(startDate,
                                            style: mainTextStyleBlack.copyWith(
                                                color: Colors.white,
                                                )),
                                        Text(priority,
                                            style: mainTextStyleBlack.copyWith(
                                                fontWeight: FontWeight.w500,
                                                )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      );
                 })));
              
                // return Padding(
                //   padding: const EdgeInsets.only(left: 10, right: 10),
                //   child: GestureDetector(
                //     child: GridView.builder(
                //       shrinkWrap: true,
                //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 2,
                //           mainAxisSpacing: 5,
                //           crossAxisSpacing: 5),
                //       itemCount: dataList.length,
                //       itemBuilder: (context, index) {
                //         var id = dataList[index].id;
                //         var servicename = dataList[index].serviceName;
                //         var clientName = dataList[index].clientName!;
                //         var refNo = dataList[index].refNo!;
                //         var category = dataList[index].category!;
                //         var startDate = dataList[index].startDate!;
                //         var endDate = dataList[index].endDate!;
                //         var priority = dataList[index].priority!;
                //         var endtime = dataList[index].endTime!;
                //         var startTime = dataList[index].startTime!;
                //         var address = dataList[index].address!;
                //         var email = dataList[index].email!;
                //         var phone = dataList[index].phone!;
                //         var landmark = dataList[index].landmark!;
                              
                //         return GestureDetector(
                //             onTap: () {
                //               Provider.of<LocationProvider>(context,
                //                       listen: false)
                //                   .setCurrentService(dataList[index]);
                //               // Navigate to the other page when an item is tapped.
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                   builder: (context) => PendingServicePage(
                //                     index: index,
                //                     id: id,
                //                     clientName: clientName,
                //                     servicename: servicename,
                //                     refNo: refNo,
                //                     category: category,
                //                     enddate: endDate,
                //                     startdate: startDate,
                //                     endtime: endtime,
                //                     starttime: startTime,
                //                     Address: address,
                //                     Email: email,
                //                     Phone: phone,
                //                     Landmark: landmark,
                //                   ),
                //                   // Replace with the actual page you want to navigate to.
                //                 ),
                //               );
                //             },
                //             child: SizedBox(
                //               child: Column(
                //                 children: [
                //                   Text('Service : $id'.toUpperCase()),
                //                   Container(
                //                     height: 200,
                //                     width:300,
                //                     color: Colors.amber,
                //                   )
                //                 ],
                //               ),
                //             ),
                //             // child: Column(
                //             //   crossAxisAlignment: CrossAxisAlignment.center,
                //             //   children: [
                //             //     Text('Service : $id'.toUpperCase()),
                //             //     SizedBox(height: screenHeight / 80),
                //             //     Container(
                //             //       height: 200,
                //             //       width: screenWidth / 2.5,
                //             //       decoration: BoxDecoration(
                //             //         color: Color.fromARGB(255, 60, 180, 200),
                //             //         borderRadius: BorderRadius.circular(5),
                //             //       ),
                //             //       child: Padding(
                //             //         padding: const EdgeInsets.only(left: 10),
                //             //         child: Column(
                //             //           mainAxisAlignment:
                //             //               MainAxisAlignment.spaceEvenly,
                //             //           crossAxisAlignment:
                //             //               CrossAxisAlignment.start,
                //             //           children: [
                //             //             // SizedBox(),
                //             //             Text(clientName,
                //             //                 style: mainTextStyleBlack.copyWith(
                //             //                     color: Colors.white70,
                //             //                     fontSize: 12)),
                //             //             Text(startDate,
                //             //                 style: mainTextStyleBlack.copyWith(
                //             //                     color: Colors.white70,
                //             //                     fontSize: 12)),
                //             //             Text(priority,
                //             //                 style: mainTextStyleBlack.copyWith(
                //             //                     fontWeight: FontWeight.bold,
                //             //                     fontSize: 12)),
                //             //           ],
                //             //         ),
                //             //       ),
                //             //     ),
                //             //   ],
                //             // )
                //             );
                //       },
                //     ),
                //   ),
                // );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('No Data');
              }
            },
          ),
        ),
      ),
    );
  }
}
