import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/view/complete/completed_page.dart';
import 'package:mentegoz_technologies/view/drawer.dart';
import 'package:mentegoz_technologies/view/pending/pending_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
   final bool initialButtonStatus;
  const HomePage({
    
    Key? key, required this.initialButtonStatus,
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
    WidgetsFlutterBinding.ensureInitialized();
    context.read<LocationProvider>().address;
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    getusername_and_number();
    _selectedIndex = _tabController.index;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    // var userProvider = Provider.of<UserNameAndNumber>(context);
    // userProvider.get_user_name_and_number();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MenuDrawer(),
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
                backgroundColor: Colors.white70,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Services",
                      style: mainTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 14)),
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
                          Text(name!.split(' ').first ?? "User Name",
                              style: mainTextStyleBlack.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Text(number ?? "",
                              style: mainTextStyleBlack.copyWith(fontSize: 12)),
                        ],
                      ),
                      SizedBox(width: screenWidth / 30),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth / 30),
                        child: CircleAvatar(
                          backgroundColor:mainThemeColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: screenHeight / 45),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: 63,
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
                                color: mainThemeColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelColor: Colors.white,
                              labelStyle:
                                  mainTextStyleBlack.copyWith(fontWeight: FontWeight.bold),
                              unselectedLabelColor:
                                  mainThemeColor,
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
