import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
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
      backgroundColor: Colors.white70,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "Raise a Ticket",
           style: mainTextStyleBlack.copyWith(
                fontWeight: FontWeight.bold, fontSize: 12)
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
                    name!.split(' ').first??
                        "User Name",
                    style: mainTextStyleBlack.copyWith(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                Text(number ?? "Emp_no",
                    style: mainTextStyleBlack.copyWith(
                        fontSize: 12)),
              ],
            ),
            SizedBox(width: screenWidth / screenWidth / 30),
            Padding(
              padding: EdgeInsets.only(right: screenWidth / 30),
              child:  CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 60, 180, 200),
                        ),
            ),
          ],
        )
      ],
    );
  }
}
