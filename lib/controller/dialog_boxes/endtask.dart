import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/image_picker_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> endDialogTask({isRadius=true, context})  async {
   final _formKey = GlobalKey<FormState>();
  // final Function onConfirm;

  // EndDialogTask({this.isRadius = true});
  

  // bool isRadius;

 

     final curretService =
      Provider.of<LocationProvider>(context, listen: false).currentService;
      
    String? currentTime = DateTime.now().toString();
    final addressresult =Provider.of<LocationProvider>(context, listen: false).address;
    final prefs = await SharedPreferences.getInstance();
    String? startedService = prefs.getString( 'startedService');
     bool? journeyStatus = prefs.getBool('isStarted');
    if(journeyStatus!){
       await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ongoing Journey"),
          content:
              Text("A Journey is ongoing on $startedService. Please End Before You End the Task"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  
    }
    else
    {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm End Task'),
          content:  SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
               
             Text("Are You Sure ?")
              ]
            ),
          ),
               
          actions: <Widget>[
            // No button
            ElevatedButton(
              child: Text('No'),
              style: ElevatedButton.styleFrom(
                backgroundColor: (mainThemeColor),
                shape: isRadius
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0))
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // Yes button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: (mainThemeColor),
                shape: isRadius
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0))
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0)),
              ),
              child: Text('Yes'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                // ignore: unused_local_variable
                String? Firebase_Id = prefs.getString('Firebase_Id');
                await PostData().PostEndTask(
                    context,
                    Firebase_Id,
                    Provider.of<LocationProvider>(context, listen: false)
                        .currentService!
                        .id,
                    addressresult,
                    currentTime);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
    }
  
}
