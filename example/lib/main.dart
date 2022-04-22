import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => new _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Gender> _genders = [
    const Gender(
      value: 'male',
      label: 'Male',
    ),
    const Gender(
      value: 'female',
      label: 'Female',
    ),
    const Gender(
      value: 'other',
      label: 'Other',
    ),
  ];

  late Gender _selectedGender;

  @override
  void initState() {
    super.initState();

    _selectedGender = _genders.first;
  }

  @override
  Widget build(BuildContext context) {
    final genderSelectionTile = Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Select Gender',
              style: TextStyle(
                color: CupertinoColors.systemBlue,
                fontSize: 15.0,
              )),
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
          ),
          CupertinoRadioChoice<Gender>(
            choices: _genders,
            onChange: onGenderSelected,
            initialValue: _selectedGender,
            valueToString: (Gender value) => value.label,
          )
        ],
      ),
    );

    return new Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
          child: Column(children: <Widget>[genderSelectionTile])),
    );
  }

  void onGenderSelected(Gender gender) {
    setState(() {
      _selectedGender = gender;
    });
  }
}

class Gender {
  final String value;
  final String label;

  const Gender({
    required this.value,
    required this.label,
  });
}