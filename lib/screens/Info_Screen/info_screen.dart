import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_app/onboard_Screen.dart';
import 'package:hand_app/screens/Info_Screen/about_us_screen.dart';
import 'package:hand_app/screens/Info_Screen/donation_page.dart';
import 'package:hand_app/screens/Info_Screen/mail_screen.dart';
import 'package:hand_app/screens/Info_Screen/notification_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  runApp(InfoScreen());
}

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[200],
        appBar: AppBar(
          leading: SizedBox(),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            Icon(Icons.info, color: Colors.black),
            Icon(
              Icons.info,
              color: Colors.white,
            ),
          ],
          title: Text('Information', style: TextStyle(color: Colors.black)),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  InfoOption(
                    right: 10,
                    left: 10,
                    top: 0,
                    title: 'About us',
                    icon: Icon(
                      Icons.info,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AboutUs();
                      }));
                    },
                  ),
                  InfoOption(
                    right: 10,
                    left: 0,
                    top: 0,
                    title: 'How to use',
                    icon: Icon(
                      Icons.help,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return OnboardScreen(
                          page: 2,
                        );
                      }));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  InfoOption(
                      right: 10,
                      left: 10,
                      top: 10,
                      title: 'Donate',
                      icon: FaIcon(
                        FontAwesomeIcons.poundSign,
                        size: 30,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return DonationPage();
                        }));
                      }),
                  InfoOption(
                    right: 10,
                    left: 0,
                    top: 10,
                    title: 'Report issue',
                    icon: Icon(
                      Icons.mail,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MailScreen();
                      }));
                    },
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  InfoOption(
                    right: 10,
                    left: 10,
                    top: 10,
                    title: 'Notifications',
                    icon: Icon(
                      Icons.notifications_active,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return NotificationScreen();
                      }));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

//reusable widget for the different information screen options
class InfoOption extends StatelessWidget {
  //paramaters which are defined when widget is used
  const InfoOption(
      {Key key,
      this.title,
      this.onTap,
      this.icon,
      this.right,
      this.left,
      this.top})
      : super(key: key);

  final Function onTap;

  final String title;
  final Widget icon;
  final double right;
  final double top;
  final double left;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 25),
              ),
              icon
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5.0,
                spreadRadius: 1,
                offset: Offset(
                  3.0,
                  3.0,
                ),
              ),
            ],
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(right: right, left: left, top: top),
        ),
      ),
    );
  }
}
