import 'package:flutter/material.dart';
import 'package:hand_app/screens/Schedule_Screen/edit_schedule_screen.dart';

class EditCurrent extends StatefulWidget {
  final String notes;
  final String repeatEx;
  final String holdF;
  final String freq;
  final int index;
  final List<String> repExList;
  final List<String> holdForList;
  final List<String> freqList;
  final List<String> noteList;

  final List<String> imageURLList;
  final List<String> videoURLList;

  int count;
  final String therapistName;
  final String name;

  EditCurrent(
      {Key key,
      this.notes,
      this.holdF,
      this.repeatEx,
      this.freq,
      this.index,
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
  _EditCurrentState createState() => _EditCurrentState();
}

class _EditCurrentState extends State<EditCurrent> {
  TextEditingController _notes = TextEditingController();
  var _repeatEx = [
    '1 time',
    '2 times',
    '3 times',
    '4 times',
    '5 times',
    '6 times',
    '7 times',
    '8 times',
    '9 times',
    '10 times',
    '11 times',
    '12 times',
    '13 times',
    '14 times',
    '15 times'
  ];
  var _currentRepExSelected;

  var _holdFor = [
    '5 seconds',
    '10 seconds',
    '15 seconds',
    '20 seconds',
    '25 seconds',
    '30 seconds'
  ];
  var _currentHoldForSelected;

  var _freq = [
    'Once a day',
    'Twice a day',
    '3 times a day',
    '4 times a day',
    '5 times a day',
    '6 times a day',
    'Hourly',
    'Twice an hour'
  ];
  var _currentFreqSelected;

  @override
  Widget build(BuildContext context) {
    Function(int) onEditExercise = (int val) {
      setState(
        () {
          //removes current values
          widget.repExList.removeAt(val);

          widget.freqList.removeAt(val);

          widget.holdForList.removeAt(val);

          widget.noteList.removeAt(val);
//inserts new values
          widget.repExList
              .insert(val, _currentRepExSelected ?? widget.repeatEx);
          widget.holdForList
              .insert(val, _currentHoldForSelected ?? widget.holdF);
          widget.freqList.insert(val, _currentFreqSelected ?? widget.freq);

          widget.noteList.insert(val, _notes.text ?? widget.notes);

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return EditScheduleScreen(
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
      );
    };
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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  onEditExercise(widget.index);
                });
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
            'Edit Exercise Detail',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text('Repeat Exercise')),
                      Container(
                        margin: EdgeInsets.only(left: 48),
                        child: DropdownButton<String>(
                          hint: Text('Select repitition'),
                          items: _repeatEx.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this._currentRepExSelected = newValueSelected;
                            });
                          },
                          value: _currentRepExSelected ??
                              widget.repeatEx ??
                              'Select repitition',
                        ),
                        width: 155,
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text('Hold for             ')),
                      Container(
                        margin: EdgeInsets.only(left: 50),
                        child: DropdownButton<String>(
                          hint: Text('Select duration'),
                          items: _holdFor.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this._currentHoldForSelected = newValueSelected;
                            });
                          },
                          value: _currentHoldForSelected ?? widget.holdF,
                        ),
                        width: 155,
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text('Frequency        ')),
                      Container(
                        margin: EdgeInsets.only(left: 52),
                        child: DropdownButton<String>(
                          hint: Text('Select frequency'),
                          items: _freq.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this._currentFreqSelected = newValueSelected;
                            });
                          },
                          value: _currentFreqSelected ?? widget.freq,
                        ),
                        width: 155,
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 5,
              child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 15, right: 100),
                          child: Text('Notes')),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: _notes ?? TextEditingController()
                              ..text = widget.notes,
                            maxLines: 20,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
