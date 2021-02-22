import 'package:flutter/material.dart';
import 'package:hand_app/components/collection_api.dart';
import 'package:hand_app/components/collection_notifier.dart';
import 'package:hand_app/screens/Schedule_Screen/add_exercise_detail.dart';
import 'package:provider/provider.dart';

import 'edit_schedule_screen.dart';

class AddExercise extends StatefulWidget {
  //parameters to retrieve all lists and values
  final int count;
  final List<String> repExList;
  final List<String> holdForList;
  final List<String> freqList;
  final List<String> noteList;
  final String therapistName;
  final String name;
  final List<String> imageURLList;
  final List<String> videoURLList;

  AddExercise(
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
  _AddExerciseState createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  void initState() {
    ExerciseNotifier exerciseNotifier =
        Provider.of<ExerciseNotifier>(context, listen: false);
    getExercises(exerciseNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[200],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return EditScheduleScreen(
                    //sends unedited lists back to edit schedule screen upon cancelling
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
            'Add Exercise',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    //adds the URL of video image and video to the lists
                                    exerciseNotifier.currentExercise =
                                        exerciseNotifier.exerciseList[index];
                                    widget.imageURLList.insert(
                                        widget.imageURLList.length,
                                        exerciseNotifier.currentExercise.image);
                                    widget.videoURLList.insert(
                                        widget.videoURLList.length,
                                        exerciseNotifier.currentExercise.video);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return AddExerciseDetail(
                                          //navigates to detail screen with updated lists
                                          therapistName: widget.therapistName,
                                          name: widget.name,
                                          // if null used to avoid errors
                                          count: widget.count ?? 0,
                                          repExList: widget.repExList ?? [],
                                          holdForList: widget.holdForList ?? [],
                                          freqList: widget.freqList ?? [],
                                          noteList: widget.noteList ?? [],
                                          imageURLList:
                                              widget.imageURLList ?? [],
                                          videoURLList:
                                              widget.videoURLList ?? []);
                                    }));
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.all(5),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          child: Image.network(
                                            exerciseNotifier
                                                .exerciseList[index].image,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                exerciseNotifier
                                                    .exerciseList[index].name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: exerciseNotifier.exerciseList.length),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
