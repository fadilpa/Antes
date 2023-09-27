import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.screenHeight,
    required this.name,
    required this.number,
    required this.screenWidth,
  });

  final double screenHeight;
  final String? name;
  final String? number;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: screenHeight * 0.13,
      forceElevated: true,
      elevation: 3,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "Services".toUpperCase(),
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
                  name!.split(' ').first.toUpperCase() ?? "User Name",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  number ?? "Mobile Number",
                  style: TextStyle(
                    color: Colors.black54,
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
    );
  }
}
