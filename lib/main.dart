import 'package:flutter/material.dart';
import 'package:new_weathe_sapp/service/router.dart';
import 'package:new_weathe_sapp/view/homeWithBLoC.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: WeatherHome(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: WeatherHome(),
    );
  }
}
