import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:intl/date_symbol_data_file.dart';
//import 'package:intl/date_symbol_data_http_request.dart';
import 'package:intl/intl.dart';

import 'package:lern_app/learnTime.dart';

class Learned extends StatefulWidget {
  final void Function(LearnTime learnTime) addLearnTime;

  const Learned(this.addLearnTime, {Key? key}) : super(key: key);
  static const options = ['BWM', 'POS', 'DBI', 'NVS'];

  @override
  State<Learned> createState() => _LearnedState();
}

class _LearnedState extends State<Learned> {
  var learnTimeList = <LearnTime>[];
  String selectOption = Learned.options[0];
  final controller = TextEditingController();
  DateTime? dateTime;

  List<DropdownMenuItem<String>> buildDropDownItems() {
    final result = <DropdownMenuItem<String>>[];
    for (final option in Learned.options) {
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
    return SizedBox(
      //color: Theme.of(context).colorScheme.primary,
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
            child: Text(dateTime == null
                ? "Datum"
                : DateFormat.yMd().format(dateTime!)),
          ),
          FloatingActionButton(
            onPressed: () {
              if (dateTime == null) {
                return;
              }
              var learnTime =
                  LearnTime(selectOption, controller.text, dateTime!);
              widget.addLearnTime(learnTime);
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
