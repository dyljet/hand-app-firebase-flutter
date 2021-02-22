import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hand_app/onboard_Screen.dart';
import 'package:hand_app/screens/Education_Screen/education_screen.dart';
import 'package:hand_app/screens/Info_Screen/info_screen.dart';
import 'package:hand_app/screens/Schedule_Screen/schedule_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/collection_notifier.dart';

void main() => runApp(MultiProvider(
      providers: [
        //providers for different firebase collections
        ChangeNotifierProvider(
          builder: (context) => ArticleNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (context) => ExerciseNotifier(),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        //initially launches splash screen
        onWillPop: () async => false,
        child: MaterialApp(home: SplashScreen()));
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var isShowed = prefs.getBool("isIntroShowed");
      //decides if intro has been shown before
      if (isShowed != null && isShowed) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return NavBar(
            page: 1,
          );
        }));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return OnboardScreen(
            page: 1,
          );
        }));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  //navbar takes parameter of page number so that when it is launches from different screens, the page number can be defined
  int page;
  NavBar({Key key, this.page}) : super(key: key);
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  GlobalKey _bottomNavigationKey = GlobalKey();
  final _pageOption = [
    EducationScreen(),
    ScheduleScreen(),
    InfoScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: Colors.lightBlueAccent,
          key: _bottomNavigationKey,
          index: widget.page ?? 1,
          animationDuration: Duration(milliseconds: 400),
          animationCurve: Curves.easeInOut,
          height: 70.0,
          items: <Widget>[
            Icon(Icons.school, size: 40),
            Icon(Icons.home, size: 40),
            Icon(Icons.info_outline, size: 40),
          ],
          onTap: (index) {
            setState(() {
              widget.page = index;
            });
          },
        ),
        body: _pageOption[widget.page],
      ),
    );
  }

  Future onSelectNotification(String payload) async {}

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NavBar(
                    page: 1,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
