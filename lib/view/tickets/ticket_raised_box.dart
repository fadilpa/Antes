import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/select_image_source.dart';
import 'package:mentegoz_technologies/controller/styles.dart';

class TicketRaiseSuccesfull extends StatelessWidget {
  const TicketRaiseSuccesfull({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight / 10),
            child: Container(
              height: screenHeight / 1.9, // Adjusted height
              width: screenWidth / 1.2, // Adjusted width
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // SizedBox(height: screenWidth*0.1,),
                  Container(
                    height: screenHeight / 8, // Adjusted height
                    width: screenWidth / 1.2,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 60, 180, 200),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        Text(
                          'Raise a Ticket',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextField(
                          // controller: SubjectController,
                          decoration: InputDecoration(hintText: '  Subject'),
                        ),
                        TextField(
                          // controller: DescriptionController,
                          decoration:
                              InputDecoration(hintText: '  Description'),
                        ),
                        InkWell(
                          onTap: () {
                            showImageSourceDialog(context);
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: screenHeight / 12.5, // Adjusted height
                            width: screenWidth / 1.3,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Upload Image',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    showImageSourceDialog(context);
                                  },
                                  icon: Icon(Icons.camera),

                                  // size: 30,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight / 20, // Adjusted height
                        ),
                        SizedBox(
                          height: screenHeight / 18, // Adjusted height
                          width: screenWidth / 3.5, // Adjusted width
                          child: ElevatedButton(
                            onPressed: () {
                              // Upload(
                              //     DescriptionController.text,
                              //     SubjectController.text,
                              //     // serviceCount,
                              //     _image!.path);
                              // setState(() {
                              //   isTicketSubmitted = true;
                              // });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 60, 180, 200),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: mainTextStyleBlack.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
