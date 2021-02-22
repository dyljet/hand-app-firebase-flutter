import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hand_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  //defining switch parameters which are saved locally so user knows which notification types are set.
  NotificationScreen(
      {Key key,
      this.onceSwitch,
      this.twiceSwitch,
      this.threeSwitch,
      this.fourSwitch,
      this.fiveSwitch,
      this.sixSwitch,
      this.hourSwitch,
      this.tHourSwitch})
      : super(key: key);

  bool onceSwitch = false;
  bool twiceSwitch;
  bool threeSwitch;
  bool fourSwitch;
  bool fiveSwitch;
  bool sixSwitch;
  bool hourSwitch;
  bool tHourSwitch;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
//daily notification which takes a custom id, hour, minute and message
Future _showDailyAtTime(int id, int hour, int minute, String body) async {
  var time = Time(hour, minute, 0);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      id,
      'Time to do your exercises!',
      //body is customised depending on which notification type
      '$body',
      time,
      platformChannelSpecifics);
}

Future _cancelNotification(val) async {
  await flutterLocalNotificationsPlugin.cancel(val);
}

class _NotificationScreenState extends State<NotificationScreen> {
  void initState() {
    //when screen launches it obtains the values of the switch
    getOnceSwitch().then(updateOnceSwitch);
    getTwiceSwitch().then(updateTwiceSwitch);
    getThreeSwitch().then(updateThreeSwitch);
    getFourSwitch().then(updateFourSwitch);
    getFiveSwitch().then(updateFiveSwitch);
    getSixSwitch().then(updateSixSwitch);
    getHourSwitch().then(updateHourSwitch);
    getTHourSwitch().then(updateTHourSwitch);

    super.initState();
  }

  int hour;
  int minute;
  TimeOfDay selectedTime = TimeOfDay.now();
  //short message at bottom of screen which notifies user which notification is set and at what times
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<bool> _onBackPressed() {
    //saves switch values
    saveEdit();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return NavBar(
        page: 2,
      );
    }));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              saveEdit();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return NavBar(
                  page: 2,
                );
              }));
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          title: Text(
            'Set Notifications',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            //each notification type has customised widget
            NotifTypeCard(
              widget: widget,
              text: 'Once a day',
              top: 10,
              bottom: 5,
              onChanged: (bool value) {
                if (widget.onceSwitch == false || widget.onceSwitch == null) {
                  setState(() {
                    //different amount of alarms are set depending on notification type
                    _showDailyAtTime(0, 10, 00,
                        'Please do all exercises marked "Once a day"');
                    widget.onceSwitch = true;
                    showToast('Notification set for 10:00 everday');
                  });
                  print('Switch is ON');
                } else {
                  setState(() {
                    //when switch is off, the notification at the ID set is cancelled
                    widget.onceSwitch = false;
                    _cancelNotification(0);
                  });
                  print('Switch is OFF');
                }
              },
              isSwitched: widget.onceSwitch ?? false,
            ),
            NotifTypeCard(
              widget: widget,
              text: 'Twice a day',
              top: 5,
              bottom: 5,
              onChanged: (bool value) {
                if (widget.twiceSwitch == false || widget.twiceSwitch == null) {
                  setState(() {
                    widget.twiceSwitch = true;
                    _showDailyAtTime(1, 10, 00,
                        'Please do all exercises marked "Twice a day"');
                    _showDailyAtTime(2, 18, 00,
                        'Please do all exercises marked "Twice a day"');

                    showToast('Notification set for 10:00 and 18:00 everyday');
                  });
                  print('Switch is ON');
                } else {
                  setState(() {
                    widget.twiceSwitch = false;
                    _cancelNotification(1);
                    _cancelNotification(2);
                  });
                  print('Switch is OFF');
                }
              },
              isSwitched: widget.twiceSwitch ?? false,
            ),
            NotifTypeCard(
              widget: widget,
              text: '3 times a day',
              top: 5,
              bottom: 5,
              onChanged: (bool value) {
                if (widget.threeSwitch == false || widget.threeSwitch == null) {
                  setState(() {
                    widget.threeSwitch = true;
                    _showDailyAtTime(3, 10, 00,
                        'Please do all exercises marked "3 times a day"');
                    _showDailyAtTime(4, 14, 00,
                        'Please do all exercises marked "3 times a day"');
                    _showDailyAtTime(5, 18, 00,
                        'Please do all exercises marked "3 times a day"');

                    showToast(
                        'Notification set for 10:00, 14:00 and 18:00 everyday');
                  });
                  print('Switch is ON');
                } else {
                  setState(() {
                    widget.threeSwitch = false;
                    _cancelNotification(3);
                    _cancelNotification(4);
                    _cancelNotification(5);
                  });
                  print('Switch is OFF');
                }
              },
              isSwitched: widget.threeSwitch ?? false,
            ),
            NotifTypeCard(
              widget: widget,
              text: '4 times a day',
              top: 5,
              bottom: 5,
              onChanged: (bool value) {
                if (widget.fourSwitch == false || widget.fourSwitch == null) {
                  setState(() {
                    widget.fourSwitch = true;
                    _showDailyAtTime(6, 10, 00,
                        'Please do all exercises marked "4 times a day"');
                    _showDailyAtTime(7, 13, 00,
                        'Please do all exercises marked "4 times a day"');
                    _showDailyAtTime(8, 16, 00,
                        'Please do all exercises marked "4 times a day"');
                    _showDailyAtTime(9, 19, 00,
                        'Please do all exercises marked "4 times a day"');

                    showToast(
                        'Notification set for 10:00, 13:00, 16:00, 19:00 everday');
                  });
                  print('Switch is ON');
                } else {
                  setState(() {
                    widget.fourSwitch = false;
                    _cancelNotification(6);
                    _cancelNotification(7);
                    _cancelNotification(8);
                    _cancelNotification(9);
                  });
                  print('Switch is OFF');
                }
              },
              isSwitched: widget.fourSwitch ?? false,
            ),
            NotifTypeCard(
              widget: widget,
              text: '5 times a day',
              top: 5,
              bottom: 5,
              onChanged: (bool value) {
                if (widget.fiveSwitch == false || widget.fiveSwitch == null) {
                  setState(() {
                    widget.fiveSwitch = true;
                    _showDailyAtTime(10, 10, 00,
                        'Please do all exercises marked "5 times a day"');
                    _showDailyAtTime(11, 12, 00,
                        'Please do all exercises marked "5 times a day"');
                    _showDailyAtTime(12, 14, 00,
                        'Please do all exercises marked "5 times a day"');
                    _showDailyAtTime(13, 16, 00,
                        'Please do all exercises marked "5 times a day"');
                    _showDailyAtTime(14, 18, 00,
                        'Please do all exercises marked "5 times a day"');

                    showToast(
                        'Notification set for 10:00, 12:00, 14:00, 16:00 and 18:00 everyday');
                  });
                  print('Switch is ON');
                } else {
                  setState(() {
                    widget.fiveSwitch = false;
                    _cancelNotification(10);
                    _cancelNotification(11);
                    _cancelNotification(12);
                    _cancelNotification(13);
                    _cancelNotification(14);
                  });
                  print('Switch is OFF');
                }
              },
              isSwitched: widget.fiveSwitch ?? false,
            ),
            NotifTypeCard(
              widget: widget,
              text: '6 times a day',
              top: 5,
              bottom: 5,
              onChanged: (bool value) {
                if (widget.sixSwitch == false || widget.sixSwitch == null) {
                  setState(() {
                    widget.sixSwitch = true;
                    _showDailyAtTime(15, 10, 00,
                        'Please do all exercises marked "6 times a day"');
                    _showDailyAtTime(16, 12, 00,
                        'Please do all exercises marked "6 times a day"');
                    _showDailyAtTime(17, 14, 00,
                        'Please do all exercises marked "6 times a day"');
                    _showDailyAtTime(18, 16, 00,
                        'Please do all exercises marked "6 times a day"');
                    _showDailyAtTime(19, 18, 00,
                        'Please do all exercises marked "6 times a day"');
                    _showDailyAtTime(20, 20, 00,
                        'Please do all exercises marked "6 times a day"');

                    showToast(
                        'Notification set for 10:00, 12:00, 14:00, 16:00, 18:00 and 20:00 everyday');
                  });
                  print('Switch is ON');
                } else {
                  setState(() {
                    widget.sixSwitch = false;
                    _cancelNotification(15);
                    _cancelNotification(16);
                    _cancelNotification(17);
                    _cancelNotification(18);
                    _cancelNotification(19);
                    _cancelNotification(20);
                  });
                  print('Switch is OFF');
                }
              },
              isSwitched: widget.sixSwitch ?? false,
            ),
            NotifTypeCard(
              widget: widget,
              text: 'Once an hour',
              top: 5,
              bottom: 5,
              onChanged: (bool value) {
                if (widget.hourSwitch == false || widget.hourSwitch == null) {
                  setState(() {
                    widget.hourSwitch = true;
                    _showDailyAtTime(
                        21, 10, 00, 'Please do all exercises marked "Hourly"');
                    _showDailyAtTime(
                        22, 11, 00, 'Please do all exercises marked "Hourly"');
                    _showDailyAtTime(
                        23, 12, 00, 'Please do all exercises marked "Hourly"');
                    _showDailyAtTime(
                        24, 13, 00, 'Please do all exercises marked "Hourly"');
                    _showDailyAtTime(
                        25, 14, 00, 'Please do all exercises marked "Hourly"');
                    _showDailyAtTime(
                        26, 15, 00, 'Please do all exercises marked "Hourly"');
                    _showDailyAtTime(
                        27, 16, 00, 'Please do all exercises marked "Hourly"');
                    _showDailyAtTime(
                        28, 17, 00, 'Please do all exercises marked "Hourly"');
                    _showDailyAtTime(
                        29, 18, 00, 'Please do all exercises marked "Hourly"');

                    showToast(
                        'Notification set for every hour from 10:00 to 18:00');
                  });
                  print('Switch is ON');
                } else {
                  setState(() {
                    widget.hourSwitch = false;
                    _cancelNotification(21);
                    _cancelNotification(22);
                    _cancelNotification(23);
                    _cancelNotification(24);
                    _cancelNotification(25);
                    _cancelNotification(26);
                    _cancelNotification(27);
                    _cancelNotification(28);
                    _cancelNotification(29);
                  });
                  print('Switch is OFF');
                }
              },
              isSwitched: widget.hourSwitch ?? false,
            ),
            NotifTypeCard(
              widget: widget,
              text: 'Twice an hour',
              top: 5,
              bottom: 10,
              onChanged: (bool value) {
                if (widget.tHourSwitch == false || widget.tHourSwitch == null) {
                  setState(() {
                    widget.tHourSwitch = true;
                    _showDailyAtTime(30, 10, 00,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(31, 10, 30,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(32, 11, 00,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(33, 11, 30,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(34, 12, 00,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(35, 12, 30,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(36, 13, 00,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(37, 13, 30,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(38, 14, 00,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(39, 14, 30,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(40, 15, 00,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(41, 15, 30,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(42, 16, 00,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(43, 16, 30,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(44, 17, 00,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(45, 17, 30,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(46, 18, 00,
                        'Please do all exercises marked "Twice an hour"');
                    _showDailyAtTime(47, 18, 30,
                        'Please do all exercises marked "Twice an hour"');

                    showToast(
                        'Notification set twice every hour from 10:00 to 18:30');
                  });
                  print('Switch is ON');
                } else {
                  setState(() {
                    widget.tHourSwitch = false;
                    _cancelNotification(30);
                    _cancelNotification(31);
                    _cancelNotification(32);
                    _cancelNotification(33);
                    _cancelNotification(34);
                    _cancelNotification(35);
                    _cancelNotification(36);
                    _cancelNotification(37);
                    _cancelNotification(38);
                    _cancelNotification(39);
                    _cancelNotification(40);
                    _cancelNotification(41);
                    _cancelNotification(42);
                    _cancelNotification(43);
                    _cancelNotification(44);
                    _cancelNotification(45);
                    _cancelNotification(46);
                    _cancelNotification(47);
                  });
                  print('Switch is OFF');
                }
              },
              isSwitched: widget.tHourSwitch ?? false,
            ),
          ],
        ),
      ),
    );
  }

  void updateOnceSwitch(bool onceSwitch) {
    setState(() {
      this.widget.onceSwitch = onceSwitch;
    });
  }

  void updateTwiceSwitch(bool twiceSwitch) {
    setState(() {
      this.widget.twiceSwitch = twiceSwitch;
    });
  }

  void updateThreeSwitch(bool threeSwitch) {
    setState(() {
      this.widget.threeSwitch = threeSwitch;
    });
  }

  void updateFourSwitch(bool fourSwitch) {
    setState(() {
      this.widget.fourSwitch = fourSwitch;
    });
  }

  void updateFiveSwitch(bool fiveSwitch) {
    setState(() {
      this.widget.fiveSwitch = fiveSwitch;
    });
  }

  void updateSixSwitch(bool sixSwitch) {
    setState(() {
      this.widget.sixSwitch = sixSwitch;
    });
  }

  void updateHourSwitch(bool hourSwitch) {
    setState(() {
      this.widget.hourSwitch = hourSwitch;
    });
  }

  void updateTHourSwitch(bool tHourSwitch) {
    setState(() {
      this.widget.tHourSwitch = tHourSwitch;
    });
  }

  void saveEdit() {
    bool onceSwitch = widget.onceSwitch;
    saveOnceSwitch(onceSwitch).then((bool committed) {});

    bool twiceSwitch = widget.twiceSwitch;
    saveTwiceSwitch(twiceSwitch).then((bool committed) {});

    bool threeSwitch = widget.threeSwitch;
    saveThreeSwitch(threeSwitch).then((bool committed) {});

    bool fourSwitch = widget.fourSwitch;
    saveFourSwitch(fourSwitch).then((bool committed) {});

    bool fiveSwitch = widget.fiveSwitch;
    saveFiveSwitch(fiveSwitch).then((bool committed) {});

    bool sixSwitch = widget.sixSwitch;
    saveSixSwitch(sixSwitch).then((bool committed) {});

    bool hourSwitch = widget.hourSwitch;
    saveHourSwitch(hourSwitch).then((bool committed) {});

    bool tHourSwitch = widget.tHourSwitch;
    saveTHourSwitch(tHourSwitch).then((bool committed) {});
  }
}

Future<bool> getOnceSwitch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onceSwitch = prefs.getBool("onceSwitch");

  return onceSwitch;
}

Future<bool> getTwiceSwitch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool twiceSwitch = prefs.getBool("twiceSwitch");

  return twiceSwitch;
}

Future<bool> getThreeSwitch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool threeSwitch = prefs.getBool("threeSwitch");

  return threeSwitch;
}

Future<bool> getFourSwitch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool fourSwitch = prefs.getBool("fourSwitch");

  return fourSwitch;
}

Future<bool> getFiveSwitch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool fiveSwitch = prefs.getBool("fiveSwitch");

  return fiveSwitch;
}

Future<bool> getSixSwitch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool sixSwitch = prefs.getBool("sixSwitch");

  return sixSwitch;
}

Future<bool> getHourSwitch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hourSwitch = prefs.getBool("hourSwitch");

  return hourSwitch;
}

Future<bool> getTHourSwitch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool tHourSwitch = prefs.getBool("tHourSwitch");

  return tHourSwitch;
}

Future<bool> saveOnceSwitch(bool onceSwitch) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("onceSwitch", onceSwitch);
  return null;
}

Future<bool> saveTwiceSwitch(bool twiceSwitch) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("twiceSwitch", twiceSwitch);
  return null;
}

Future<bool> saveThreeSwitch(bool threeSwitch) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("threeSwitch", threeSwitch);
  return null;
}

Future<bool> saveFourSwitch(bool fourSwitch) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("fourSwitch", fourSwitch);
  return null;
}

Future<bool> saveFiveSwitch(bool fiveSwitch) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("fiveSwitch", fiveSwitch);
  return null;
}

Future<bool> saveSixSwitch(bool sixSwitch) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("sixSwitch", sixSwitch);
  return null;
}

Future<bool> saveHourSwitch(bool hourSwitch) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("hourSwitch", hourSwitch);
  return null;
}

Future<bool> saveTHourSwitch(bool tHourSwitch) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("tHourSwitch", tHourSwitch);
  return null;
}

//widget extracted with custom paramaters. one being the function which sets different times for each type
class NotifTypeCard extends StatefulWidget {
  final NotificationScreen widget;
  final String text;
  final Function onChanged;
  final double top;
  final double bottom;
  bool isSwitched;

  NotifTypeCard(
      {Key key,
      @required this.widget,
      @required this.text,
      @required this.top,
      @required this.bottom,
      @required this.onChanged,
      this.isSwitched

//    this.isSwitched
      })
      : super(key: key);

  @override
  _NotifTypeCardState createState() => _NotifTypeCardState();
}

class _NotifTypeCardState extends State<NotifTypeCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "${widget.text}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Switch(
              value: widget.isSwitched,
              onChanged: widget.onChanged,
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ],
        ),
        margin: EdgeInsets.only(
            right: 20, left: 20, bottom: widget.bottom, top: widget.top),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),
    );
  }
}
