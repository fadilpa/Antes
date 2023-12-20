import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/image_picker_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndDialogFunction extends StatelessWidget {
   final _formKey = GlobalKey<FormState>();
  // final Function onConfirm;

  EndDialogFunction({this.isRadius = true});

  bool isRadius;

  @override
  Widget build(BuildContext context) {
    String? currentTime = DateTime.now().toString();
    final addressresult = context.read<LocationProvider>().address;
    return AlertDialog(
      title: Text('Confirm End Service'),
      content:  SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.0),
             TextButton(
             
                        child: Row(
                          children: [
                          
                            Icon(Icons.camera_alt),
                              Text(" Select Images "),
                          ],
                        ),
                        onPressed: () async {
                          Provider.of<OpenCameraProvider>(context,
                                  listen: false)
                              .pickArrayyofImage();
                        },
                      ),
                      Provider.of<OpenCameraProvider>(context,
                                      )
                                  .imageArraypath.isNotEmpty?SizedBox(
                                    height: 100,
                        // height:  Provider.of<OpenCameraProvider>(context,
                        //               )
                        //           .imageArraypath.length*50,
                        width: MediaQuery.of(context).size.width-20,
                        child: GridView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                              itemCount:  Provider.of<OpenCameraProvider>(context,
                                      listen: false)
                                  .imageslist.length,
                             gridDelegate: 
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                 return Stack(
                                   children: [
                                     Image.file(Provider.of<OpenCameraProvider>(context,
                                          listen: false)
                                      .imageslist[index], 
                              height: 70,),
                              Positioned(
            top: 0,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.close,color: Colors.red,),
              onPressed: () {
                // Remove the image from the array when the close button is pressed
                Provider.of<OpenCameraProvider>(context, listen: false)
                    .removeImage(index);
              },
            ),
          ),
                                   ],
                                 );
                           }),
                      ):SizedBox(),
          //    TextField(
          //     // enabled: false,
          //   decoration: InputDecoration(
          //       labelText: "Upload Image",
          //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          //       errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          //       suffixIcon: SizedBox(
          //         width: 100,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             Provider.of<OpenCameraProvider>(
          //                       context,
          //                     ).imageArraypath.isNotEmpty
          //                 ? 
          //                 SizedBox(
          //                   height: 50,
          //                   width: 100,
          //                   child: ListView.builder(
          //                     physics: NeverScrollableScrollPhysics(),
          //                     scrollDirection: Axis.horizontal,
          //                     itemCount:  Provider.of<OpenCameraProvider>(
          //                         context,
          //                       ).imageslist.length ,
          //                     itemBuilder: (BuildContext context, index) {
          //                          Image.file(
          //                       Provider.of<OpenCameraProvider>(
          //                         context,
          //                       ).imageslist[index],
          //                       height: 45,
          //                     );
          //                     }),
          //                 )
          //                 // Image.file(
          //                 //     Provider.of<OpenCameraProvider>(
          //                 //       context,
          //                 //     ).imageslist[0],
          //                 //     height: 45,
          //                 //   )
          //                 : SizedBox(),
          //             IconButton(
          //               icon: Icon(Icons.camera_alt),
          //               onPressed: () async {
          //                 Provider.of<OpenCameraProvider>(context,
          //                         listen: false)
          //                     .pickArrayyofImage();
          //               },
          //             ),
          //           ],
          //         ),
          //       )),
          // ),
        
        
            
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
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
            await PostData().PostEndService(
                context,
                Firebase_Id,
                Provider.of<LocationProvider>(context, listen: false)
                    .currentService!
                    .id,
                addressresult,
                currentTime,  Provider.of<OpenCameraProvider>(context,
                                  listen: false).imageArraypath);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
