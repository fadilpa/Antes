import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RaisedTicket extends StatefulWidget {
  const RaisedTicket({super.key});

  @override
  State<RaisedTicket> createState() => _RaisedTicketState();
}

class _RaisedTicketState extends State<RaisedTicket> {
     String? name;
 String? number;
  bool isTicketSubmitted = false; // Add a flag to track ticket submission
  Future<void> _showImageSourceDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                // Handle the selected image from the camera
                if (pickedImage != null) {
                  // Process the image here

                  // Once processing is successful, set the flag to true
                  // setState(() {
                  //   isTicketSubmitted = true;
                  // });
                }
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                // Handle the selected image from the gallery
                if (pickedImage != null) {
                  // Process the image here
                }
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

    getusername_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name');
    number = prefs.getString('Mobile');
  }
@override
  void initState() {
    super.initState();
    getusername_and_number();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    if (isTicketSubmitted) {
      // Display the success card/container if the ticket is submitted
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 100,
              forceElevated: true,
              elevation: 3,
              backgroundColor: Colors.white,
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Raise a Ticket",
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
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                           name??"User Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          number??"NO Number",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth / 30),
                      child: CircleAvatar(),
                    ),
                  ],
                )
              ],
            ),
            SliverToBoxAdapter(
              
              child: Center(

                child: Padding(
                  padding:  EdgeInsets.only(top: screenHeight/10),
                  child: Container(
                    height: screenHeight/2,
                    width: screenWidth/1.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        Container(
                          height: screenHeight/6.7,
                          width: screenWidth/1.2,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 60,180,229),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: screenHeight/6.7,
                                width: screenWidth/1.2,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 60,180,229),
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
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    const Text(
                                      'Ticket Raised',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: screenHeight/20),
                            SizedBox(
                              width: screenWidth/1.6,
                              height: screenHeight/6.7,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: const Color.fromARGB(255, 210,254,166),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Text(
                                        'Hello, Your Ticket accepted!',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        'Lorem ipsum dolor sit\n amet cosecteur',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight/40),
                            CircleAvatar(
                              radius: screenWidth/13.5,
                              backgroundColor: Color.fromARGB(255,210,254,166),
                              child: Icon(
                                Icons.done,
                                size: 28,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 100,
              forceElevated: true,
              elevation: 3,
              backgroundColor: Colors.white,
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Raise a Ticket",
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
                    SizedBox(width: screenWidth * 0.02),
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth / 30),
                      child: CircleAvatar(),
                    ),
                  ],
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight/10),
                  child: Container(
                    height: screenHeight /1.9, // Adjusted height
                    width: screenWidth /1.2, // Adjusted width
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                          height: screenHeight /8, // Adjusted height
                          width: screenWidth/1.2,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 60,180,229),
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
                                  color: Colors.white,
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
                              const TextField(
                                decoration:
                                    InputDecoration(hintText: '  Subject'),
                              ),
                              const TextField(
                                decoration:
                                    InputDecoration(hintText: '  Description'),
                              ),
                              InkWell(
                                onTap: () {
                                  _showImageSourceDialog(context);
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: screenHeight/12.5, // Adjusted height
                                  width: screenWidth/1.3,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
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
                                      Icon(
                                        Icons.camera_alt,
                                        size: 30,
                                        color: Colors.grey.shade600,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight/20, // Adjusted height
                              ),
                              SizedBox(
                                height: screenHeight /18, // Adjusted height
                                width: screenWidth /3.5, // Adjusted width
                                child: ElevatedButton(
                                  onPressed: () {
                                     setState(() {
                    isTicketSubmitted = true;
                  });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(255, 60,180,229),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Submit',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
