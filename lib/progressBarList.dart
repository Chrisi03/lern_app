// ignore: file_names

import 'package:flutter/material.dart';

class ProgressBarList extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final subjectLearnTime;

  const ProgressBarList(this.subjectLearnTime, {Key? key}) : super(key: key);

  double setValueOfProgressBars(int index) {
    var keys = subjectLearnTime.keys.toList();
    if(getTotalLearnTime() != 0){
      return subjectLearnTime[keys[index]] / getTotalLearnTime();
    }
    return 0.0;
  }

  double getTotalLearnTime() {
    double totalLearnTime = 0;

    var keys = subjectLearnTime.keys.toList();
    for (var i = 0; i < subjectLearnTime.length; i++) {
      totalLearnTime += subjectLearnTime[keys[i]];
    }
    return totalLearnTime;
  }

  @override
  Widget build(BuildContext context) {
    if(subjectLearnTime.length==0){
      return const Text('Study some');
    }
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: subjectLearnTime.length,
        itemBuilder: (_, index) {
          var keys = subjectLearnTime.keys.toList();
          return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(keys[index]),
                  Text(subjectLearnTime[keys[index]].toString()),
                  SizedBox(
                    height: 128,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 3)),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
        });
  }
}
