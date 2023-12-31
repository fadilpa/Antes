// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/shared_pref_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_and_complete_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/model/pending_model.dart';
import 'package:mentegoz_technologies/view/pending/pending_service_page.dart';
import 'package:mentegoz_technologies/view/request/request_handling.dart';
import 'package:provider/provider.dart';

class Requestpage extends StatelessWidget {
  Requestpage({super.key});

  late Future<List<Autogenerated>> futureDataList;

  // @override
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final firebaseIdProvider =
        Provider.of<FirebaseIdProvider>(context, listen: false);
   Provider.of<ServiceProvider>(context,listen: false).setdata();
    Provider.of<LocationProvider>(context,listen: false).getLocationAndAddress();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
  
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<Autogenerated>>(
            future: Provider.of<ServiceProvider>(context,listen: false).getRequestService(),
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
                  // width: screenWidth,
                  child: GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate :  SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: screenHeight/3.5,
                  maxCrossAxisExtent: screenWidth/2,
                   crossAxisSpacing: 2,
                   mainAxisSpacing: 1

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
                        int serviceNumber =index+1;
                        return Column(
                          //  crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text( 'Service : $serviceNumber',style: mainTextStyleBlack,),
                                SizedBox(height: screenHeight / 80),
                                GestureDetector(
                                  onTap:(){
                                      Provider.of<LocationProvider>(context,
                                      listen: false)
                                  .setCurrentService(dataList[index]);
                              // Navigate to the other page when an item is tapped.
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RequestHandlingPage(
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
                                    height: screenHeight/4.5,
                                    width: screenWidth / 2.5,
                                    decoration: BoxDecoration(
                                      color: mainThemeColor,
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
                                          // SizedBox(height: screenHeight/40,),
                                          Text(clientName,
                                              style: mainTextStyleBlack.copyWith(
                                                  color: Colors.white,
                                                  )),
                                                  //  SizedBox(height: screenHeight/40,),
                                          Text(startDate,
                                              style: mainTextStyleBlack.copyWith(
                                                  color: Colors.white,
                                                )),
                                                //  SizedBox(height: screenHeight/40,),
                                          Text(priority,
                                              style: mainTextStyleBlack.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                 )),
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
                return Text('No Internet');
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
