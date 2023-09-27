// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

  late TabController tabController;

class TabProvider extends StatefulWidget with ChangeNotifier {
  @override
  _TabProviderState createState() => _TabProviderState();
}

class _TabProviderState extends State<TabProvider>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // This widget doesn't need to render anything, just manage the TabController
    );
  }
}
