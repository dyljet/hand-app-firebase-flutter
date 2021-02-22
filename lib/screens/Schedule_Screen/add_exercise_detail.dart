import 'package:flutter/material.dart';
import 'package:hand_app/screens/Schedule_Screen/edit_schedule_screen.dart';

class AddExerciseDetail extends StatefulWidget {
  final int count;
  final List<String> repExList;
  final List<String> holdForList;
  final List<String> freqList;
  final List<String> noteList;
  final List<String> imageURLList;
  final List<String> videoURLList;
  final String therapistName;
  final String name;

  AddExerciseDetail(
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
  _AddExerciseDetailState createState() => _AddExerciseDetailState();
}

class _AddExerciseDetailState extends State<AddExerciseDetail> {
  //validation keys
  final _formKey = GlobalKey<FormState>();
  final _holdFKey = GlobalKey<FormState>();
  final _freqKey = GlobalKey<FormState>();

  bool _autovalidate = false;
  TextEditingController notes = TextEditingController();
  //defining different user options
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[200],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                //removes the URL of image and video because user has cancelled
                widget.imageURLList.removeAt(widget.imageURLList.length);
                widget.videoURLList.removeAt(widget.videoURLList.length);
//navigates back to edit screen with unedited lists
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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate() &&
                      _holdFKey.currentState.validate() &&
                      _freqKey.currentState.validate()) {
                    //if validation returns true then adds details to lists

                    widget.repExList.insert(
                        widget.repExList.length, _currentRepExSelected ?? '');
                    widget.holdForList.insert(widget.holdForList.length,
                        _currentHoldForSelected ?? '');
                    widget.freqList.insert(
                        widget.freqList.length, _currentFreqSelected ?? '');
                    widget.noteList
                        .insert(widget.noteList.length, notes.text ?? '');
                    //navigates back to screen with updated lists and count incremented
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return EditScheduleScreen(
                        therapistName: widget.therapistName,
                        name: widget.name,
                        count: widget.count + 1,
                        repExList: widget.repExList,
                        holdForList: widget.holdForList,
                        freqList: widget.freqList,
                        noteList: widget.noteList,
                        imageURLList: widget.imageURLList,
                        videoURLList: widget.videoURLList,
                      );
                    }));
                  } else {
                    setState(() {
                      _autovalidate = true;
                    });
                  }
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
            'Add Exercise Detail',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
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
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 48, right: 5, top: 0),
                          child: Form(
                            key: _formKey,
                            autovalidate: _autovalidate,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration.collapsed(
                                hintText: 'Select repitition',
                              ),
                              validator: (value) =>
                                  value == null ? 'field required' : null,
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
                              value: _currentRepExSelected,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 4,
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
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 50, right: 5),
                          child: Form(
                            key: _holdFKey,
                            autovalidate: _autovalidate,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Select duration'),
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              items: _holdFor.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this._currentHoldForSelected =
                                      newValueSelected;
                                });
                              },
                              value: _currentHoldForSelected,
                            ),
                          ),
                          width: 155,
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 4,
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
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 52,
                            right: 5,
                          ),
                          child: Form(
                            key: _freqKey,
                            autovalidate: _autovalidate,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Select frequency'),
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              items: _freq.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this._currentFreqSelected = newValueSelected;
                                });
                              },
                              value: _currentFreqSelected,
                            ),
                          ),
                          width: 155,
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 7,
              child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
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
                            controller: notes,
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
