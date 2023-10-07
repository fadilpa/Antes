import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndDialogFunction extends StatelessWidget {
  // final Function onConfirm;

  EndDialogFunction({this.isRadius = true});

  bool isRadius;

  @override
  Widget build(BuildContext context) {
    String? currentTime = DateTime.now().toString();
    final addressresult = context.read<LocationProvider>().address;
    return AlertDialog(
      title: Text('Confirm End Service'),
      content: Text('Are you sure you want to end the service?'),
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
            await PostData().PostEndService(
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
}
