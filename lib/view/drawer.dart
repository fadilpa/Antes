import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/logout_function.dart.dart';
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
              color: Color.fromARGB(255, 60, 180, 229),
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
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
    );
  }
}
