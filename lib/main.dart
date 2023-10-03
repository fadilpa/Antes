import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/image_picker_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/shared_pref_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/pending_and_complete_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/tab_provider.dart';
import 'package:mentegoz_technologies/controller/image_picker.dart';
import 'package:mentegoz_technologies/controller/media_permission.dart';
import 'package:mentegoz_technologies/controller/request_location_permissions.dart';
import 'package:mentegoz_technologies/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mentegoz_technologies/view/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
   await ReqMedia().requestMediaPermissions();
  ReqLocation().requestLocationPermission();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final journeyStarted = prefs.getBool('journeyStarted') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseIdProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => NameProvider()),
        ChangeNotifierProvider(create: (context) => MobileProvider()),
        ChangeNotifierProvider(create: (context) => UserNameAndNumber()),
        ChangeNotifierProvider(create: (context) => ServiceProvider()),
        ChangeNotifierProvider(create: (context) => TabProvider()),
        ChangeNotifierProvider(create: (context) => OpenCameraProvider()),
        ChangeNotifierProvider(create: (context)=>OpenCameraProviders()),
      ],
      child: MaterialApp(
        title: 'Antes',
        home: isLoggedIn
            ? HomePage(
                initialButtonStatus: journeyStarted,
              )
            : LoginPage(),
      ),
    ),
  );
}
