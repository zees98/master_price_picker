import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:master_price_picker/theme/colors.dart';
import 'package:stacked_services/stacked_services.dart';
import './theme/colors.dart';

import 'core/locator.dart';
import 'core/router_constants.dart';
import 'core/router.dart' as router;
import 'scraper.dart';

void main() async {
  // WebScraperAPI().runAliBabaScraper();
   WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  await LocatorInjector.setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        backgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: splashScreenViewRoute,
    );
  }
}
