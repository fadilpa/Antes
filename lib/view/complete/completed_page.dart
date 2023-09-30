// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/shared_pref_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_and_complete_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/model/completed_model.dart';
import 'package:mentegoz_technologies/model/pending_model.dart';
import 'package:mentegoz_technologies/view/complete/completed_service_page.dart';
import 'package:mentegoz_technologies/view/pending/pending_service_page.dart';
import 'package:provider/provider.dart';

class CompletedPage extends StatelessWidget {
  CompletedPage({super.key});

  late Future<List<Autogenerated>> futureDataList;

  // @override
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final firebaseIdProvider =
        Provider.of<FirebaseIdProvider>(context, listen: false);
    Provider.of<ServiceProvider>(context, listen: false).fetchCompletedAlbum();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<CompletedServicesModel>>(
            future: Provider.of<ServiceProvider>(context, listen: false)
                .fetchCompletedAlbum(),
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
                return SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: screenHeight,
                          maxCrossAxisExtent: screenHeight / 2,
                          crossAxisSpacing: 2),
                      itemCount: dataList.length,
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
                          children: [
                            Text('Service : $id'.toUpperCase()),
                            SizedBox(height: screenHeight / 80),
                            GestureDetector(
                              onTap: () {
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .setCompleteCurrentService(dataList[index]);
                                // Navigate to the other page when an item is tapped.
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CompletedServicePage(
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
                                      address: address,
                                      email: email,
                                      phone: phone,
                                      landmark: landmark,
                                    ),
                                    // Replace with the actual page you want to navigate to.
                                  ),
                                );
                              },
                              child: Container(
                                height: screenHeight / 3.5,
                                width: screenWidth / 2.5,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 60, 180, 200),
                                  borderRadius: BorderRadius.circular(5),
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
                                              color: Colors.white,
                                              fontSize: 12)),
                                      Text(email,
                                          style: mainTextStyleBlack.copyWith(
                                              color: Colors.white,
                                              fontSize: 12)),
                                      Text(phone,
                                          style: mainTextStyleBlack.copyWith(
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                );
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
