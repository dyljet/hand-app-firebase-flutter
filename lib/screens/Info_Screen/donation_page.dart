import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class DonationPage extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Thank you',
            style: TextStyle(color: Colors.black),
          ),
        ),
        //package widget which defines URL of donation page
        body: EasyWebView(
          src:
              "https://www.pulvertafthandcentre.org.uk/about-us/derby-helping-hands-charity/",
          isHtml: false, // Use Html syntax
          isMarkdown: false, // Use markdown syntax
          convertToWidets: false, // Try to convert to flutter widgets
          // width: 100,
          // height: 100,),
        ));
  }
}
