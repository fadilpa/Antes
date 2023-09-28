import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/varibles.dart';


class RaiseTicketAppBar extends StatelessWidget {
   RaiseTicketAppBar({
    super.key,
    required this.screenWidth,
  });
String? name;
String? number;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 100,
      forceElevated: true,
      elevation: 3,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "Raise a Ticket",
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
                Text(
                  name!.split(' ').first.toUpperCase() ?? "User Name",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  number ?? "Emp_no",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(width: screenWidth / screenWidth / 30),
            Padding(
              padding: EdgeInsets.only(right: screenWidth / 30),
              child: CircleAvatar(),
            ),
          ],
        )
      ],
    );
  }
}
