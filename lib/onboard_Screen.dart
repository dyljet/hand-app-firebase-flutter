import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class OnboardScreen extends StatefulWidget {
  int page;
  OnboardScreen({Key key, this.page}) : super(key: key);
  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  List<PageViewModel> getPages() {
    return [
      //defines the different pages of onboarding screen
      PageViewModel(
          image: Image.asset("images/onboard_schedule.png"),
          title: "Schedule screen",
          bodyWidget: Container(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Click on "),
                    Icon(Icons.edit),
                    Text(" to add exercises to your schedule."),
                  ],
                ),
                Container(
                  height: 3,
                ),
                Text("Here, hold exercises to delete them or click"),
                Container(
                  height: 7,
                ),
                Text(" existing ones to edit. When it's time to do"),
                Container(
                  height: 7,
                ),
                Text("your exercises, click on the relvevant ones."),
              ],
            ),
          ),
          decoration: const PageDecoration()),
      PageViewModel(
          image: Image.asset("images/onboard_education.png"),
          title: "Education screen",
          bodyWidget: Container(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Explore articles to learn more about your injury",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          decoration: PageDecoration()),
      PageViewModel(
        image: Image.asset("images/onboard_settings.png"),
        title: "Information screen",
        bodyWidget: Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Here, you can:"),
              Container(
                height: 7,
              ),
              Text("      - Set notifications to stay consistent with your"),
              Container(
                height: 7,
              ),
              Text(" schedule"),
              Container(
                height: 7,
              ),
              Text("- Report any issues with the app"),
              Container(
                height: 7,
              ),
              Text("- Donate to Derby Helping Hands Charity "),
              Container(
                height: 7,
              ),
              Text("- Find out more about us"),
              Container(
                height: 7,
              ),
              Text("- View this screen again!"),
            ],
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: getPages(),
          done: Text(
            'Done',
            style: TextStyle(color: Colors.black),
          ),
          onDone: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isIntroShowed', true);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return NavBar(
                page: widget.page,
              );
            }));
          },
          showSkipButton: true,
          skip: const Text("Skip"),
          next: const Icon(Icons.navigate_next),
          dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: Colors.black,
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          onSkip: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isIntroShowed', true);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return NavBar(
                page: widget.page,
              );
            }));
          },
        ),
      ),
    );
  }
}
