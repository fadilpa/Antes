import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/view/app_bars/tickets_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {

 getusername_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('Name');
      number = prefs.getString('Mobile');
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false)
        .getLocationAndAddress();
    getusername_and_number();
  }

String? name;
String? number;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserNameAndNumber>(context);
    userProvider.get_user_name_and_number();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
         SliverAppBar(
      pinned: true,
      expandedHeight: 100,
      forceElevated: true,
      elevation: 3,
      backgroundColor: Colors.white70,
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "Tickets",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
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
                Text(userProvider.name?.split(' ').first ?? "User Name",
                    style: mainTextStyleBlack.copyWith(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                Text(userProvider.number ?? "",
                    style: mainTextStyleBlack.copyWith(fontSize: 12)),
              ],
            ),
            SizedBox(
              width: screenWidth / 30,
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth / 30),
              child:  CircleAvatar(
                          backgroundColor: mainThemeColor,
                        ),
            ),
          ],
        ),
      ],
         ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight / 20,
                  left: screenWidth / 50,
                  right: screenWidth / 50,
                  bottom: screenHeight / 40),
              child: Container(
                height: screenHeight / 1.3,
                color: Color.fromARGB(255, 233, 233, 233),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight / 30,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                            color: Colors.grey,
                          ),
                          hintText: 'Search Ticket',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: screenHeight / 60,
                      ),
                      // Expanded(
                      //   child: ListView.separated(
                      //     shrinkWrap: true,
                      //     itemBuilder: (context, index) {
                      //       return SizedBox(
                      //         height: screenHeight / 7,
                      //         child: Card(
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //           ),
                      //           color: Colors.white70,
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Column(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceEvenly,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Text(
                      //                       'Services ${index + 1}',
                      //                       style:
                      //                           const TextStyle(fontSize: 16),
                      //                     ),
                      //                     const Text(
                      //                       '9 minutes ago',
                      //                       style: TextStyle(
                      //                           fontSize: 13,
                      //                           color: Colors.grey),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 const Text(
                      //                   'Lorem ipsum dolor sit amet consecteur',
                      //                   style: TextStyle(
                      //                       fontSize: 13, color: Colors.black),
                      //                 ),
                      //                 Row(
                      //                   children: const [
                      //                     Text(
                      //                       'Accepted ',
                      //                       style: TextStyle(
                      //                           fontSize: 12,
                      //                           color: Colors.green),
                      //                     ),
                      //                     CircleAvatar(
                      //                       radius: 6,
                      //                       backgroundColor: Colors.green,
                      //                       child: Icon(
                      //                         Icons.done,
                      //                         size: 7,
                      //                       ),
                      //                     )
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     separatorBuilder: (context, index) => SizedBox(
                      //       height: screenHeight / 50,
                      //     ),
                      //     itemCount: 10,
                      //   ),
                      // ),
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
