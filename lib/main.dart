import 'package:altitude/common/router/Router.dart';
import 'package:altitude/common/services/FireMenssaging.dart';
import 'package:altitude/core/GetIt.dart';
import 'package:altitude/feature/home/view/page/HomePage.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:altitude/feature/tutorialPage.dart';
import 'package:altitude/common/services/SharedPref.dart';
import 'package:altitude/common/services/FireAnalytics.dart';

void main() async {
  Getit.init();

  bool showTutorial = false;
  WidgetsFlutterBinding.ensureInitialized();
  if (await SharedPref().getName() == null) showTutorial = true;

  runApp(MyApp(showTutorial: showTutorial));
}

class MyApp extends StatelessWidget {
  final bool showTutorial;

  MyApp({@required this.showTutorial});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    FireMessaging().configure();

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        accentColor: Color.fromARGB(255, 34, 34, 34),
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: showTutorial ? TutorialPage() : HomePage(),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: FireAnalytics().analytics)],
      onGenerateRoute: Router.generateRoute,
    );
  }
}
