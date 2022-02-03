import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/locale.dart';
import 'package:lern_app/learnTime.dart';
import 'package:lern_app/main.dart';

class Lerned extends StatefulWidget {
  final void Function(LearnTime learnTime) addLearnTime;

  Lerned(this.addLearnTime, {Key? key}) : super(key: key);
  static const options = ['A', 'B', 'C'];

  @override
  State<Lerned> createState() => _LernedState();
}

class _LernedState extends State<Lerned> {

  var learnTimeList = <LearnTime>[];
  String selectOption = Lerned.options[0];
  final controller = TextEditingController();
  DateTime? dateTime;

  List<DropdownMenuItem<String>> buildDropDownItems() {
    final result = <DropdownMenuItem<String>>[];
    for (final option in Lerned.options) {
      final item = DropdownMenuItem(
        child: Text(option),
        value: option,
      );
      result.add(item);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          DropdownButton(
              items: buildDropDownItems(),
              value: selectOption,
              onChanged: (selected) {
                setState(() {
                  selectOption = selected as String;
                });
              }),
          TextField(
            keyboardType: TextInputType.number,
            controller: controller,
          ),
          TextButton(
            onPressed: () {
              var dateTimeFuture = showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().month >= 9
                      ? DateTime(DateTime.now().year, DateTime.september)
                      : DateTime(DateTime.now().year - 1, DateTime.september),
                  lastDate: DateTime.now());
              dateTimeFuture.then((value) {
                setState(() {
                  dateTime = value;
                });
              });
            },
            child: Text(dateTime == null ? "Datum" : DateFormat.yMd().format(dateTime!)),
          ),
          FloatingActionButton(onPressed: () {
            var learnTime = new LearnTime(selectOption,controller.text,dateTime);
            widget.addLearnTime(learnTime);
            Navigator.of(context).pop();
            },child:
            Icon(Icons.add),)
        ],
      ),
    );
  }
}
