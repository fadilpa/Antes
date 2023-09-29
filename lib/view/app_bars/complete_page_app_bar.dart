import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/controller/styles.dart';

class CompleteAppBar extends StatelessWidget {
  const CompleteAppBar({
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
      backgroundColor: Colors.white70,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("Completed Services",
            style: mainTextStyleBlack.copyWith(
                fontWeight: FontWeight.bold, fontSize: 12)),
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
                Text(userProvider.name!.split(' ').first ?? "User Name",
                    style: mainTextStyleBlack.copyWith(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                Text(userProvider.number ?? "Emp_no",
                    style: mainTextStyleBlack.copyWith(fontSize: 12)),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 30,
            ),
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
