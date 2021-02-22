import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:hand_app/main.dart';
import 'package:url_launcher/url_launcher.dart';

class MailScreen extends StatefulWidget {
  @override
  _MailScreenState createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  //controllers defined for different fields
  final _subjectController = TextEditingController();

  final _bodyController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    //email widget defined which sets the body and subject to field controllers and the recipient which will eventually be provided by hospital
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: ['example@example.com'],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
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
          'Report Issue ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Subject: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: null, border: InputBorder.none),
                      controller: _subjectController,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(top: 10, right: 20, left: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      'Body: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 21),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: _bodyController,
                        maxLines: 20,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: send,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Send issue via mail app',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
