import 'package:flutter/material.dart';
import 'package:hand_app/components/collection_api.dart';
import 'package:hand_app/components/collection_notifier.dart';
import 'package:hand_app/screens/Schedule_Screen/add_exercise.dart';
import 'package:provider/provider.dart';

import 'edit_schedule_screen.dart';

class ExerciseCat extends StatefulWidget {
  final int count;
  final List<String> repExList;
  final List<String> holdForList;
  final List<String> freqList;
  final List<String> noteList;
  final String therapistName;
  final String name;
  final List<String> imageURLList;
  final List<String> videoURLList;

  ExerciseCat(
      {Key key,
      this.count,
      this.repExList,
      this.holdForList,
      this.freqList,
      this.noteList,
      this.therapistName,
      this.name,
      this.imageURLList,
      this.videoURLList})
      : super(key: key);
  @override
  _ExerciseCatState createState() => _ExerciseCatState();
}

class _ExerciseCatState extends State<ExerciseCat> {
  void initState() {
    ExerciseNotifier exerciseNotifier =
        Provider.of<ExerciseNotifier>(context, listen: false);
    getExercises(exerciseNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[200],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return EditScheduleScreen(
                  therapistName: widget.therapistName,
                  name: widget.name,
                  count: widget.count,
                  repExList: widget.repExList,
                  holdForList: widget.holdForList,
                  freqList: widget.freqList,
                  noteList: widget.noteList,
                  imageURLList: widget.imageURLList,
                  videoURLList: widget.videoURLList,
                );
              }));
            });
          },
          color: Colors.black,
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Select Category',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: GridView.count(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                children: <Widget>[
                  ExerciseCatCard(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AddExercise(
                            therapistName: widget.therapistName,
                            name: widget.name,
                            count: widget.count ?? 0,
                            repExList: widget.repExList ?? [],
                            holdForList: widget.holdForList ?? [],
                            freqList: widget.freqList ?? [],
                            noteList: widget.noteList ?? [],
                            imageURLList: widget.imageURLList ?? [],
                            videoURLList: widget.videoURLList ?? []);
                      }));
                    },
                  ),
                  ExerciseCatCard(),
                  ExerciseCatCard(),
                  ExerciseCatCard(),
                  ExerciseCatCard(),
                  ExerciseCatCard(),
                  ExerciseCatCard(),
                  ExerciseCatCard(),
                  ExerciseCatCard(),
                  ExerciseCatCard(),
                ],
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
              ),
              margin: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }
}

//widget will take more parameters when app is populated with exercises
class ExerciseCatCard extends StatelessWidget {
  const ExerciseCatCard({Key key, this.onTap}) : super(key: key);
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: Image.asset(
                  "images/extensor.png",
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 5, left: 10),
                    child: Text(
                      'Extensor',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 50, top: 5),
                      child: Icon(Icons.navigate_next)),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}
