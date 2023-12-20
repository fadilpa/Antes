
  import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_and_complete_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> requestConfirmation(BuildContext context,int serviceId) async {

    final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
    String? Firebase_Id = prefs.getString('Firebase_Id');
    int serbiceCount = 1;
    // filepath;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Accept Service"),
          content: Text("Are you sure you want to accept the service?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
          var status= await Provider.of<ServiceProvider>(context,listen: false).acceptOrRejectRequstedService(serviceId);
          if(status==200){
            Navigator.pop(context);
            showDialog(context: context, builder:  (BuildContext context) {
              return AlertDialog(
                title: Text("The service accepted successfully"),
                actions: [
                   TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("ok"),
            ),
                ],
              );
            });
          }

        
          
              
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

Future<void> requestRejection(BuildContext context,int serviceId) async {
    TextEditingController controller=TextEditingController();
    final prefs = await SharedPreferences.getInstance();
      // bool _validate = false;
        final _formKey = GlobalKey<FormState>();
// ignore: unused_local_variable
    String? Firebase_Id = prefs.getString('Firebase_Id');
    int serbiceCount = 1;
    // filepath;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reject Reuqest"),
          content:  Form(
            key: _formKey,
            
            child: TextFormField(
               validator: (value) =>
                        value!.isEmpty ? '*Required' : null,
              controller: controller,
                    decoration: InputDecoration(
                      //  errorText:   _validate ? "Value Can't Be Empty" : null,
                        labelText: "Reason For  Rejection",
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        
                        suffixIcon: SizedBox(
                          width: 100,
                          
                          ),
                        )),
          ),
                
              
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                   if (_formKey.currentState!.validate()) {
                      var status= await Provider.of<ServiceProvider>(context,listen: false).acceptOrRejectRequstedService(serviceId,status: "rejected",reason: controller.text);
          if(status==200){
            Navigator.pop(context);
            showDialog(context: context, builder:  (BuildContext context) {
              return AlertDialog(
                title: Text("The request was rejected"),
                actions: [
                   TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("ok"),
            ),
                ],
              );
            });
         
          }
                   }
        

        
          
              
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }