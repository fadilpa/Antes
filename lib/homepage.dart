import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/pendingpage.dart';
import 'package:mentegoz_technologies/recordpage.dart';
import 'completedpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  // ignore: unused_field
  var _selectedIndex = 0;

  // Future<void> _logout(BuildContext context) async {
  //   final String apiUrl =
  //       'https://antes.meduco.in/api/applogin'; // Replace with your API logout URL

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       // Add any necessary headers or parameters for your API call
  //     );

  //     if (response.statusCode == 200) {
  //       // Successfully logged out, navigate to the login page
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => WelcomePage(), // Replace with your login page
  //         ),
  //       );
  //     } else {
  //       // Handle API error cases
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Logout Failed'),
  //             content: Text('Unable to logout. Please try again.'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // Close the alert
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   } catch (error) {
  //     // Handle any exceptions that occur during the API call
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('An error occurred. Please try again later.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the alert
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onMenuItemSelected(int index) {
    // Handle menu item selection
    switch (index) {
      case 0:
        // Handle "Tickets" menu item
        break;
      case 1:
        // Handle "Logout" menu item
        break;
      case 2:
        // Handle "Settings" menu item
        break;
      case 3:
        // Handle "Bills Uploaded" menu item
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                 color: Color.fromARGB(255, 60,180,229),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Tickets'),
              onTap: () {
                _onMenuItemSelected(0);
                // Close the drawer after handling the selection
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TicketsPage(),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // _logout(context);
                // Close the drawer after handling the selection
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                _onMenuItemSelected(2);
                // Close the drawer after handling the selection
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_file),
              title: Text('Bills Uploaded'),
              onTap: () {
                _onMenuItemSelected(3);
                // Close the drawer after handling the selection
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: screenHeight * 0.13,
                forceElevated: true,
                elevation: 3,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Services",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  tooltip: 'Menu',
                  onPressed: () {
                    // Open the drawer
                    Scaffold.of(context).openDrawer();
                  },
                ),
                actions: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: screenHeight * 0.065,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255,233,233,233),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: Color.fromARGB(255, 60,180,229),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Color.fromARGB(255, 60,180,229),
                          tabs: const [
                            Tab(text: "Pending"),
                            Tab(text: "Completed"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children:  [
              PendingPage(),
              CompletedPage(),
            ],
          ),
        ),
      ),
    );
  }
}
