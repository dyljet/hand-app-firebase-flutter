import 'package:flutter/material.dart';
import 'package:hand_app/main.dart';
import 'package:video_player/video_player.dart';
import 'package:hand_app/screens/Schedule_Screen/video_player.dart';

class ShowExercise extends StatefulWidget {
  final String videoURL;
  final String notes;
  final String repeatEx;
  final String holdF;
  final String freq;

  ShowExercise({
    Key key,
    this.videoURL,
    this.notes,
    this.holdF,
    this.repeatEx,
    this.freq,
  }) : super(key: key);
  @override
  _ShowExerciseState createState() => _ShowExerciseState();
}

class _ShowExerciseState extends State<ShowExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return NavBar(
                page: 1,
              );
            }));
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.info,
            color: Colors.white,
          ),
        ],
        title: Text('Show Exercise', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: ChewieListItem(
              //video player widget that is defined in video_player
              videoPlayerController: VideoPlayerController.network(
                '${widget.videoURL}',
              ),
              aspectRatio: 16 / 9,
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ExerciseDetail(
                    title: 'Repeat Exercise',
                    body: '${widget.repeatEx}',
                    left: 26,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ExerciseDetail(
                    title: 'Hold For',
                    body: '${widget.holdF}',
                    left: 83,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ExerciseDetail(
                    title: 'Frequency',
                    body: '${widget.freq}',
                    left: 68,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "Notes:",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 0, top: 10, right: 67),
                                    child: SingleChildScrollView(
                                      child: Text(
                                        '${widget.notes}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//extracted widget that takes parameters for different detail box
class ExerciseDetail extends StatelessWidget {
  final String title;

  final String body;
  final double left;

  ExerciseDetail({Key key, this.body, this.title, this.left}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "$title:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.only(left: left),
              child: Text(
                '$body',
                style: TextStyle(
                  fontSize: 15,
                ),
              ))
        ],
      ),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
    );
  }
}
