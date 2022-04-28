library cupertino_radio_choice;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoRadioChoice<T> extends StatefulWidget {
  /// CupertinoRadioChoice displays a radio choice widget with cupertino format
  CupertinoRadioChoice(
      {required this.choices,
      required this.valueToString,
      required this.onChange,
      required this.initialValue,
      this.selectedColor = CupertinoColors.systemBlue,
      this.notSelectedColor = CupertinoColors.inactiveGray,
      this.padding = const EdgeInsets.all(10.0),
      this.enabled = true});

  /// Function is called if the user selects another choice
  final void Function(T) onChange;

  /// Defines which choice shall be selected initally by key
  final T initialValue;

  /// Contains a map which defines which choices shall be displayed (key => value).
  /// Values are the values displyed in the choices
  final List<T> choices;

  /// The color of the selected radio choice
  final Color selectedColor;

  /// The color of the not selected radio choice(s)
  final Color notSelectedColor;

  /// Defines if the widget shall be enabled (clickable) or not
  final bool enabled;

  /// Value formatter
  final String Function(T) valueToString;

  // Button padding
  final EdgeInsets padding;

  @override
  _CupertinoRadioChoiceState createState() => _CupertinoRadioChoiceState<T>();
}

/// State of the widget
class _CupertinoRadioChoiceState<T> extends State<CupertinoRadioChoice<T>> {
  late T _selectedValue;

  @override
  void initState() {
    super.initState();

    if (widget.choices.contains(widget.initialValue))
      _selectedValue = widget.initialValue;
    else
      _selectedValue = widget.choices.first;
  }

  Widget buildSelectionButton(T value,
      {bool selected = false}) {
    return Container(
      child: CupertinoButton(
        disabledColor:
            selected ? widget.selectedColor : widget.notSelectedColor,
        color: selected ? widget.selectedColor : widget.notSelectedColor,
        padding: widget.padding,
        child: Text(widget.valueToString(value)),
        onPressed: !widget.enabled || selected
            ? null
            : () {
                setState(() {
                  _selectedValue = value;
                });

                widget.onChange(_selectedValue);
              },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.choices.map((e) => buildSelectionButton(
          e,
          selected: _selectedValue == e
      )).toList(growable: false),
      spacing: 10.0,
      runSpacing: 5.0,
    );
  }
}
