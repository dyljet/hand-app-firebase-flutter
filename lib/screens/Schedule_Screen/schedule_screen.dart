import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hand_app/screens/Schedule_Screen/edit_schedule_screen.dart';
import 'package:hand_app/screens/Schedule_Screen/show_exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(ScheduleScreen());

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  void initState() {
    print(count);
    //retrieving all values from edit schedule screen
    getNamePreference().then(updateName);
    getNamePreferenceT().then(updateNameT);
    getCount().then(updateCount);
    getRepExList().then(updateRep);
    getHoldForList().then(updateHF);
    getFreqList().then(updateFreq);
    getNoteList().then(updateNotes);
    getImageURLList().then(updateImageURL);
    getVideoURLList().then(updateVideoURL);
    prefs = SharedPreferences.getInstance();

    super.initState();
  }

  //defining lists and values
  String _name = "";
  String _nameT = "";
  int count;
  Future<SharedPreferences> prefs;

  List<String> repExList = [];
  List<String> holdForList = [];
  List<String> freqList = [];
  List<String> noteList = [];
  List<String> imageURLList = [];
  List<String> videoURLList = [];

  @override
  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List.generate(
        count ?? 0,
        (int i) => new Exercise(i,
            repeatEx: repExList[i],
            holdF: holdForList[i],
            freq: freqList[i],
            notes: noteList[i],
            imageURL: imageURLList[i],
            videoURL: videoURLList[i]));

    _isCountEmpty() {
      //code to show different screens depending on if count is 0
      if (count == 0 || count == null) {
        print("poopoohead");

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          margin: EdgeInsets.only(left: 80, right: 80, top: 80, bottom: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //returns hint to say start adding exercises
              Container(
                child: Text(
                  'No exercises added',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Press  ',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  Icon(Icons.edit),
                  Text('  to start!',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
                ],
              ))
            ],
          ),
        );
      } else {
        return ListView(
          //else list of exercises is returned
          children: children,
          scrollDirection: Axis.vertical,
        );
      }
    }

//will pop scope removes functionality of built in android back button
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[200],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return EditScheduleScreen(
                  count: count,
                  repExList: repExList ?? [],
                  holdForList: holdForList ?? [],
                  freqList: freqList ?? [],
                  noteList: noteList ?? [],
                  therapistName: _nameT,
                  name: _name,
                  imageURLList: imageURLList ?? [],
                  videoURLList: videoURLList ?? [],
                );
              }));
            },
            color: Colors.black,
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            Icon(Icons.home, color: Colors.black),
            Icon(
              Icons.home,
              color: Colors.white,
            ),
          ],
          title: Text(
            'My Schedule',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 1,
                          offset: Offset(
                            3.0,
                            3.0,
                          ),
                        ),
                      ],
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(20),
                  width: 300,
                  height: 45,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Name: ',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(_name ?? '', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 1,
                          offset: Offset(
                            3.0,
                            3.0,
                          ),
                        ),
                      ],
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: 300,
                  height: 45,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Therapist: ',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _nameT ?? '',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: FutureBuilder(
                      future: prefs,
                      builder:
                          (context, AsyncSnapshot<SharedPreferences> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return _isCountEmpty();
                        }
                      },
                    ))
                  ],
                ),
                margin: EdgeInsets.all(25),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  void updateNameT(String nameT) {
    setState(() {
      this._nameT = nameT;
    });
  }

  void updateCount(int count) {
    setState(() {
      this.count = count;
    });
  }

  void updateRep(List repExList) {
    setState(() {
      this.repExList = repExList;
    });
  }

  void updateHF(List holdForList) {
    setState(() {
      this.holdForList = holdForList;
    });
  }

  void updateFreq(List freqList) {
    setState(() {
      this.freqList = freqList;
    });
  }

  void updateNotes(List noteList) {
    setState(() {
      this.noteList = noteList;
    });
  }

  void updateImageURL(List imageURLList) {
    setState(() {
      this.imageURLList = imageURLList;
    });
  }

  void updateVideoURL(List videoURLList) {
    setState(() {
      this.videoURLList = videoURLList;
    });
  }
}

Future<String> getNamePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");

  return name;
}

Future<String> getNamePreferenceT() async {
  SharedPreferences prefsT = await SharedPreferences.getInstance();
  String nameT = prefsT.getString("nameT");

  return nameT;
}

Future<int> getCount() async {
  SharedPreferences getC = await SharedPreferences.getInstance();
  int count = getC.getInt("count");

  return count;
}

Future<List> getRepExList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List repExList = prefs.getStringList("repExList");

  return repExList;
}

Future<List> getHoldForList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List holfForList = prefs.getStringList("holfForList");

  return holfForList;
}

Future<List> getFreqList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List freqList = prefs.getStringList("freqList");

  return freqList;
}

Future<List> getNoteList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List noteList = prefs.getStringList("noteList");

  return noteList;
}

Future<List> getImageURLList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List imageURLList = prefs.getStringList("imageURLList");

  return imageURLList;
}

Future<List> getVideoURLList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List videoURLList = prefs.getStringList("videoURLList");

  return videoURLList;
}

//exercise widget defined, parameters taken to show different details of each one
class Exercise extends StatefulWidget {
  final String repeatEx;
  final String holdF;
  final String freq;
  final String notes;
  final String imageURL;
  final String videoURL;

  Exercise(this.index,
      {Key key,
      this.repeatEx,
      this.freq,
      this.notes,
      this.holdF,
      this.imageURL,
      this.videoURL})
      : super(key: key);
  final int index;

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //takes user to exercise clicked on
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ShowExercise(
            freq: widget.freq,
            holdF: widget.holdF,
            repeatEx: widget.repeatEx,
            videoURL: widget.videoURL,
            notes: widget.notes,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0, // has the effect of softening the shadow
              spreadRadius: 1, // has the effect of extending the shadow
              offset: Offset(
                3.0, // horizontal, move right 10
                3.0, // vertical, move down 10
              ),
            ),
          ],
          border: Border.all(color: Colors.black),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: Image.network(
                      "${widget.imageURL}",
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Repeat Exercise',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Hold For',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Frequency',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  new Text(
                    "${widget.repeatEx}",
                    style: TextStyle(fontSize: 12),
                  ),
                  new Text(
                    "${widget.holdF}",
                    style: TextStyle(fontSize: 12),
                  ),
                  new Text(
                    "${widget.freq}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
