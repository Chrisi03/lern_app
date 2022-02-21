import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lern_app/learnTime.dart';
import 'package:lern_app/learned.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  void getSortedList() {
    var sortedList = {};
    sortedList = SplayTreeMap.from(
        subjectLearnTime,
        (key1, key2) =>
            subjectLearnTime[key2].compareTo(subjectLearnTime[key1]));
    subjectLearnTime = Map<String, double>.from(sortedList);
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
      print(subjectLearnTime);
    });
    getSortedList();
  }

  double getTotalLearnTime() {
    double totalLearnTime = 0;

    var keys = subjectLearnTime.keys.toList();
    for (var i = 0; i < subjectLearnTime.length; i++) {
      totalLearnTime += subjectLearnTime[keys[i]];
    }
    return totalLearnTime;
  }

  double setValueOfProgressBars(int index) {
    getSortedList();
    var keys = subjectLearnTime.keys.toList();

    return subjectLearnTime[keys[index]] / getTotalLearnTime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
          accentColor: Colors.orange,
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("LernApp"),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Learned(addLearnTime);
                      });
                },
                icon: Icon(Icons.add)),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 200,
              decoration: BoxDecoration(border: Border.all()),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subjectLearnTime.length,
                  itemBuilder: (_, index) {
                    var keys = subjectLearnTime.keys.toList();
                    print(keys);
                    return Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(keys[index]),
                            Text(subjectLearnTime[keys[index]].toString()),
                            SizedBox(
                              height: 125,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(width: 3)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    child: LinearProgressIndicator(
                                      minHeight: 10,
                                      value: setValueOfProgressBars(index),
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ));
                  }),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: learnTimeList.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                border: Border.all( width: 3 , color: Colors.orange)),
                            child: Text(
                              learnTimeList[index].time,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                            )),
                        title: Text(learnTimeList[index].subject),
                        subtitle: Text(DateFormat.yMd().format(learnTimeList[index].dateTime)),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                // sortedList[learnTimeList[index].subject] -= double.parse(learnTimeList[index].time);
                                subjectLearnTime[learnTimeList[index].subject] -=
                                    double.parse(learnTimeList[index].time);

                                if (subjectLearnTime[
                                        learnTimeList[index].subject] ==
                                    0) {
                                  //  sortedList.remove(learnTimeList[index].subject);
                                  subjectLearnTime
                                      .remove(learnTimeList[index].subject);
                                }
                                print(subjectLearnTime);
                                learnTimeList.removeAt(index);
                                print(learnTimeList.length);
                              });
                            },
                            icon: Icon(Icons.delete_forever)),
                      ),
                    );
                  }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
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
