import 'package:flutter/material.dart';

class TicketAppBar extends StatelessWidget {
  const TicketAppBar({
    super.key,
    required this.name,
    required this.number,
    required this.screenWidth,
  });

  final String? name;
  final String? number;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 100,
      forceElevated: true,
      elevation: 3,
      backgroundColor: Colors.white,
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
                Text(
                  name!.split(' ').first ?? "User Name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  number ?? "Emp_no",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth / 30,
            ),
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
