import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'bloc/bloc.dart';

String changesToTime(int intToTime) {
  var date = new DateTime.fromMillisecondsSinceEpoch(intToTime * 1000);
  var formtdate = DateFormat("HH:mm:ss").format(date);
  return formtdate;
}

String changesToDate(int intToDate) {
  var date = new DateTime.fromMillisecondsSinceEpoch(intToDate * 1000);
  var formtdate = DateFormat("EEEE, d MMM, yyyy").format(date);
  return formtdate;
}

void reloadEveryOneHours(VoidCallback refreshPoint) {
  var now = new DateTime.now();
  String dateNow = DateFormat("yyyy-MM-dd").format(now);
  int hoursRightNow = now.hour;
  String nextHours = (hoursRightNow.toString().length == 2
      ? (hoursRightNow + 1).toString()
      : "0${hoursRightNow + 1}");
  DateTime futureOneHours = DateTime.parse("$dateNow $nextHours:00:00");
  var different = futureOneHours.difference(now);
  int restartIntMinutes = different.inMinutes + 1;
  Future.delayed(Duration(minutes: restartIntMinutes), refreshPoint);
}

Future pickDates(BuildContext context) async {
  final weatherBloc = BlocProvider.of<BloctestDartBloc>(context);
  DateTime datepick = await showDatePicker(
          context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime.now().add(Duration(days: -365)),
          lastDate: new DateTime.now().add(Duration(days: 365)))
      .then((value) {
    var _now = new DateTime.now();
    var timesnow = DateFormat("HH:mm:ss").format(_now);
    var selectedDate = DateFormat("yyyy-MM-dd").format(value);
    var date1 = DateTime.parse(selectedDate + " " + timesnow);
    print(date1);
    double patomon = date1.millisecondsSinceEpoch / 1000;
    int agumon = patomon.toInt();
    weatherBloc.add(GetDates(agumon.toString()));
    return value;
  });
}
