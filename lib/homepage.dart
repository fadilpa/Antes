import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/Modal/User_Model.dart';
import 'package:mentegoz_technologies/logoutpage.dart';
import 'package:mentegoz_technologies/pending_page.dart';
import 'package:mentegoz_technologies/recordpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'completed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  // ignore: unused_field
  var _selectedIndex = 0;
  String? name;
  String? number;

  getusername_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('Name');
      number = prefs.getString('Mobile');
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    setState(() {
      getusername_and_number();
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // void _onMenuItemSelected(int index) {
  //   // Handle menu item selection
  //   switch (index) {
  //     // case 0:
  //     //   // Handle "Tickets" menu item
  //     //   break
  //   }
  // }

  User_Lgin_Data login_data = User_Lgin_Data();
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
                color: Color.fromARGB(255, 60, 180, 229),
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
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                logout(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.post_add_sharp),
              title: Text('Tickets'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TicketsPage()));
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
                      fontSize: 15.0,
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
                            name ?? "User Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            number ?? "Mobile Number",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth / 30),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth / 30),
                        child: CircleAvatar(),
                      ),
                    ],
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: screenHeight/45),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: screenHeight / 13.5,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 233, 233),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth / 60),
                          child: Container(
                            child: TabBar(
                              controller: _tabController,
                              indicator: BoxDecoration(
                                color: Color.fromARGB(255, 60, 180, 229),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor:
                                  Color.fromARGB(255, 60, 180, 229),
                              tabs: const [
                                Tab(text: "Pending"),
                                Tab(text: "Completed"),
                              ],
                            ),
                          ),
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
            children: [
              PendingPage(),
              CompletedPage(),
            ],
          ),
        ),
      ),
    );
  }
}
