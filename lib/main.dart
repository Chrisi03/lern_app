import 'package:flutter/material.dart';
import 'package:lern_app/learnTime.dart';
import 'package:lern_app/lerned.dart';

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

  void addLearnTime(LearnTime learnTime) {
    setState(() {
      learnTimeList.add(learnTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LernApp"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (_,index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: LinearProgressIndicator(
                        value: 0.5,//TODO Funktion zum zusammenhängen zweider learntime
                      ),
                    ),
                  );
                })
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: learnTimeList.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Text(learnTimeList[index].time),
                  title: Text(learnTimeList[index].subject),
                  subtitle: Text(learnTimeList[index].dateTime.toString()),
                  trailing: Icon(Icons.delete),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Lerned(addLearnTime);
              });
        },
      ),
    );
  }
}
