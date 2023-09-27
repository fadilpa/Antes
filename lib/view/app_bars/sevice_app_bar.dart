import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';

class ServiceAppBar extends StatelessWidget {
  const ServiceAppBar({
    super.key,
    required this.screenHeight,
    required this.userProvider,
    required this.screenWidth,
  });

  final double screenHeight;
  final UserNameAndNumber userProvider;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userProvider.name!
                          .split(' ')
                          .first
                          .toUpperCase() ??
                      "User Name",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  userProvider.number ?? "Emp_no",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 30,
            ),
            Padding(
              padding:
                  EdgeInsets.only(right: screenWidth / 30),
              child: CircleAvatar(),
            ),
          ],
        )
      ],
    );
  }
}