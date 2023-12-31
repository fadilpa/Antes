import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/logout_function.dart.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/view/tickets/search_tickets.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: mainThemeColor,
            ),
            child: Center(
              child: Text('Menu',
                  style: mainTextStyleBlack.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: mainTextStyleBlack.copyWith(fontSize: 12),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LogoutConfirmationDialog(
                    onConfirm: () {
                      logout(context);
                    },
                  );
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.post_add_sharp),
            title: Text('Tickets',
                style: mainTextStyleBlack.copyWith(fontSize: 12)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TicketsPage()));
            },
          ),
        ],
      ),
    );
  }
}
