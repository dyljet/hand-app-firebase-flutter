import 'package:flutter/material.dart';

import '../../main.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'About Us ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.lightBlueAccent[200],
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      'About the Application',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(top: 5, right: 20, left: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      'About the Hospital',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(top: 5, right: 20, left: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      'About the Developer',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }
}
