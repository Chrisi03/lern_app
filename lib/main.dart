import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lern_app/learnTime.dart';
import 'package:lern_app/learnTimeListView.dart';
import 'package:lern_app/learned.dart';
import 'package:lern_app/progressBarList.dart';
import 'package:sortedmap/sortedmap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'LernApp',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var learnTimeList = <LearnTime>[];
  var subjectLearnTime = {};

  void sortedList() {
    var sortedKeys = subjectLearnTime.keys.toList(growable: false)
      ..sort((k1, k2) => subjectLearnTime[k2].compareTo(subjectLearnTime[k1]));
    LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => subjectLearnTime[k]);

    subjectLearnTime = Map<String, double>.from(sortedMap);
  }

  void addLearnTime(LearnTime learnTime) {
    setState(() {
      learnTimeList.add(learnTime);
      var value = subjectLearnTime[learnTime.subject];
      value == null
          ? subjectLearnTime[learnTime.subject] = double.parse(learnTime.time)
          : {
              subjectLearnTime[learnTime.subject] +=
                  double.parse(learnTime.time),
            };
    });
    sortedList();
  }


  void delete(int index) {
    setState(() {
      subjectLearnTime[learnTimeList[index].subject] -=
          double.parse(learnTimeList[index].time);

      if (subjectLearnTime[learnTimeList[index].subject] == 0) {
        subjectLearnTime.remove(learnTimeList[index].subject);
      }
      learnTimeList.removeAt(index);
      sortedList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.green,
        accentColor: Colors.orange,
      )),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("LernApp"),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Learned(addLearnTime);
                      });
                },
                icon: const Icon(Icons.add)),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 200,
              child: ProgressBarList(subjectLearnTime),
            ),
            Expanded(
              child: LearnTimeListView(delete,learnTimeList)
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Learned(addLearnTime);
                });
          },
        ),
      ),
    );
  }
}
