import 'package:flutter/material.dart';
import 'package:hand_app/main.dart';
import 'package:hand_app/screens/Schedule_Screen/edit_current_exercise.dart';
import 'package:hand_app/screens/Schedule_Screen/exercise_cat.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(EditScheduleScreen());

class EditScheduleScreen extends StatefulWidget {
  //retrieves all information from schedule screen
  final List<String> repExList;
  final List<String> holdForList;
  final List<String> freqList;
  final List<String> noteList;
  final List<String> imageURLList;
  final List<String> videoURLList;

  int count;
  final String therapistName;
  final String name;

  EditScheduleScreen(
      {Key key,
      this.repExList,
      this.freqList,
      this.noteList,
      this.holdForList,
      this.count,
      this.therapistName,
      this.name,
      this.imageURLList,
      this.videoURLList})
      : super(key: key);

  @override
  _EditScheduleScreenState createState() => _EditScheduleScreenState();
}

class _EditScheduleScreenState extends State<EditScheduleScreen> {
  createCloseAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              //validation
              title: Text('Cancel'),
              content:
                  Text('Are you sure you want to go back and discard changes?'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MyApp();
                      }));
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  var _nameController = new TextEditingController();
  var _nameControllerT = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createSaveAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                //validation
                title: Text('Save'),
                content: Text('Are you sure you want to save changes?'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      saveEdit();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MyApp();
                      }));
                    },
                  ),
                ],
              ),
            );
          });
    }

    List<Widget> children;

    Function(int) onDeleteExercise = (int val) {
      setState(
        () {
          //removes all values from val (index) and decreases count by 1
          widget.repExList.removeAt(val);

          widget.freqList.removeAt(val);

          widget.noteList.removeAt(val);

          widget.holdForList.removeAt(val);
          widget.imageURLList.removeAt(val);
          widget.videoURLList.removeAt(val);
          children.removeAt(val);
          widget.count--;
        },
      );
    };

    children = List.generate(
        widget.count ?? 0,
        (int i) => new Exercise(
              i,
              repeatEx: widget.repExList[i],
              holdF: widget.holdForList[i],
              freq: widget.freqList[i],
              notes: widget.noteList[i],
              imageURL: widget.imageURLList[i],
              videoURL: widget.videoURLList[i],
              repExList: widget.repExList,
              holdForList: widget.holdForList,
              freqList: widget.freqList,
              noteList: widget.noteList,
              imageURLList: widget.imageURLList,
              videoURLList: widget.videoURLList,
              count: widget.count,
              therapistName: widget.therapistName,
              name: widget.name,
              onDelete: onDeleteExercise,
            ));

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[200],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              createCloseAlertDialog(context);
            },
            color: Colors.black,
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                createSaveAlertDialog(context);
              },
              color: Colors.black,
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.check,
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
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(20),
                  width: 300,
                  height: 45,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          'Name: ',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: '                               ',
                                hintStyle: TextStyle(fontSize: 23)),
                            controller:
                                _nameController ?? TextEditingController()
                                  ..text = widget.name,
                            onChanged: (text) => {},
                            style: TextStyle(fontSize: 23),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: 300,
                  height: 45,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          'Therapist: ',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                              hintText: '', hintStyle: TextStyle(fontSize: 23)),
                          controller:
                              _nameControllerT ?? TextEditingController()
                                ..text = widget.therapistName,
                          onChanged: (text) => {},
                          style: TextStyle(fontSize: 23),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ExerciseCat(
                              therapistName:
                                  _nameControllerT.text ?? widget.therapistName,
                              name: _nameController.text ?? widget.name,
                              count: widget.count ?? 0,
                              repExList: widget.repExList ?? [],
                              holdForList: widget.holdForList ?? [],
                              freqList: widget.freqList ?? [],
                              noteList: widget.noteList ?? [],
                              imageURLList: widget.imageURLList ?? [],
                              videoURLList: widget.videoURLList ?? []);
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.add_circle_outline,
                          size: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: new ListView(
                          children: children,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.all(20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveEdit() {
    //saves all values to be retrieved in schedule screen upon saved
    String name = _nameController.text;
    saveNamePreference(name).then((bool committed) {});

    String nameT = _nameControllerT.text;
    saveNamePreferenceT(nameT).then((bool committed) {});

    int count = widget.count;
    saveCount(count).then((bool committed) {});

    List repExList = widget.repExList;
    saveRep(repExList).then((bool committed) {});

    List holdForList = widget.holdForList;
    saveHF(holdForList).then((bool committed) {});

    List freqList = widget.freqList;
    saveFL(freqList).then((bool committed) {});

    List noteList = widget.noteList;
    saveN(noteList).then((bool committed) {});

    List imageURLList = widget.imageURLList;
    saveImage(imageURLList).then((bool committed) {});

    List videoURLList = widget.videoURLList;
    saveVideo(videoURLList).then((bool committed) {});
  }
}

Future<bool> saveNamePreference(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", name);
  return null;
}

Future<bool> saveNamePreferenceT(String nameT) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("nameT", nameT);
  return null;
}

Future<bool> saveCount(int count) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("count", count);
  return null;
}

Future<bool> saveRep(List repExList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("repExList", repExList);
  return null;
}

Future<bool> saveHF(List holfForList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("holfForList", holfForList);
  return null;
}

Future<bool> saveFL(List freqList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("freqList", freqList);
  return null;
}

Future<bool> saveN(List noteList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("noteList", noteList);
  return null;
}

Future<bool> saveImage(List imageURLList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("imageURLList", imageURLList);
  return null;
}

Future<bool> saveVideo(List videoURLList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("videoURLList", videoURLList);
  return null;
}

//exercise widget which takes parameters of the different details

class Exercise extends StatefulWidget {
  final String repeatEx;
  final String holdF;
  final String freq;
  final String notes;
  final Function(int) onDelete;
  final String imageURL;
  final String videoURL;
  final List<String> repExList;
  final List<String> holdForList;
  final List<String> freqList;
  final List<String> noteList;
  final List<String> imageURLList;
  final List<String> videoURLList;

  int count;
  final String therapistName;
  final String name;

  Exercise(this.index,
      {Key key,
      this.repeatEx,
      this.freq,
      this.notes,
      this.holdF,
      this.onDelete,
      this.imageURL,
      this.videoURL,
      this.repExList,
      this.freqList,
      this.noteList,
      this.holdForList,
      this.count,
      this.therapistName,
      this.name,
      this.imageURLList,
      this.videoURLList})
      : super(key: key);
  final int index;

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  createDeleteAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //validation to delete exercise
            title: Text('Delete'),
            content: Text('Are you sure you want to delete this exercise?'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();

                    widget.onDelete(widget.index);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return EditCurrent(
            //goes to edit current exercise screen
            index: widget.index,
            freq: widget.freq,
            holdF: widget.holdF,
            repeatEx: widget.repeatEx,
            notes: widget.notes,
            repExList: widget.repExList,
            holdForList: widget.holdForList,
            freqList: widget.freqList,
            noteList: widget.noteList,
            imageURLList: widget.imageURLList,
            videoURLList: widget.videoURLList,
            count: widget.count,
            therapistName: widget.therapistName,
            name: widget.name,
          );
        }));
      },
      onLongPress: () {
        //delete exercise
        setState(() {
          createDeleteAlertDialog(context);
        });
      },
      child: new Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
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
