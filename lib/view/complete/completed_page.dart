// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/shared_pref_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_and_complete_provider.dart';
import 'package:mentegoz_technologies/model/completed_model.dart';
import 'package:mentegoz_technologies/view/complete/completed_service_page.dart';
import 'package:provider/provider.dart';

class CompletedPage extends StatelessWidget {
  CompletedPage({super.key});

  late Future<List<CompletedServicesModel>> futureDataList;

  // @override
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final firebaseIdProvider =
        Provider.of<FirebaseIdProvider>(context, listen: false);
    futureDataList =
        Provider.of<ServiceProvider>(context).fetchCompletedAlbum();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<List<CompletedServicesModel>>(
        future: Provider.of<ServiceProvider>(context).fetchCompletedAlbum(),
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

            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5),
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    var servicename = dataList[index].serviceName!;
                    var clientName = dataList[index].clientName!;
                    var refNo = dataList[index].refNo!;
                    var category = dataList[index].category!;
                    var startDate = dataList[index].startDate!;
                    var endDate = dataList[index].endDate!;
                    var priority = dataList[index].priority!;
                    var endtime = dataList[index].endTime!;
                    var startTime = dataList[index].startTime!;
                    var phone = dataList[index].phone!;
                    var email = dataList[index].email!;
                    var address = dataList[index].address!;
                    var landmark = dataList[index].landmark!;

                    return GestureDetector(
                        onTap: () {
                          // Navigate to the other page when an item is tapped.
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CompletedServicePage(
                                index: index,
                                clientName: clientName,
                                servicename: servicename,
                                refNo: refNo,
                                category: category,
                                enddate: endDate,
                                startdate: startDate,
                                endtime: endtime,
                                starttime: startTime,
                                priority: priority,
                                landmark: landmark,
                                address: address,
                                email: email,
                                phone: phone,
                              ),
                              // Replace with the actual page you want to navigate to.
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: screenHeight / 70,
                            ),
                            Text('Service ${index + 1}'.toUpperCase()),
                            SizedBox(
                              height: screenHeight / 70,
                            ),
                            Container(
                              height: screenHeight / 6.1,
                              width: screenWidth / 2.5,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 60, 180, 229),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      clientName.toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      email.toLowerCase(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      phone.toUpperCase(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('No Data');
          }
        },
      ),
    );
  }
}
