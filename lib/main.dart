import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mentegoz_technologies/homepage.dart';
import 'package:mentegoz_technologies/loginpage.dart';
import 'package:mentegoz_technologies/providerclass.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseIdProvider()),
        ChangeNotifierProvider(create: (context)=> NameProvider()),
        ChangeNotifierProvider(create: (context)=>MobileProvider()),
      ],
      child: MaterialApp(
        title: 'Antes',
        home: isLoggedIn ? HomePage() : LoginPage(),
      ),
    ),
  );
}
