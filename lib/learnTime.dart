import 'package:intl/intl.dart';
//test
class LearnTime{
  String subject;
  String time;
  DateTime dateTime;

  LearnTime(this.subject,this.time,this.dateTime);


  @override
  String toString() {
    return 'LearnTime{subject: $subject, time: $time, dateTime: $dateTime}';
  }
}
