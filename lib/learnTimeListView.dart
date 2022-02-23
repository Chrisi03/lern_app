// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LearnTimeListView extends StatefulWidget {
  final void Function(int index) delete;
  final learnTimeList;

  const LearnTimeListView(this.delete, this.learnTimeList, {Key? key})
      : super(key: key);

  @override
  State<LearnTimeListView> createState() => _LearnTimeListViewState();
}

class _LearnTimeListViewState extends State<LearnTimeListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.learnTimeList.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3, color: Colors.orange)),
                  child: Text(
                    widget.learnTimeList[index].time,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              title: Text(widget.learnTimeList[index].subject),
              subtitle: Text(DateFormat.yMd()
                  .format(widget.learnTimeList[index].dateTime)),
              trailing: IconButton(
                  onPressed: () {
                    widget.delete(index);
                  },
                  icon: const Icon(Icons.delete_forever)),
            ),
          );
        });
  }
}
