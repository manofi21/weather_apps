import 'package:flutter/material.dart';
import 'package:new_weathe_sapp/model/model.dart';
import 'package:new_weathe_sapp/view/homeWithBLoC.dart';
import 'package:new_weathe_sapp/view/widget/widget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WeatherHome());
      case '/weekDetails':
        if (args is WeatherData) {
          return MaterialPageRoute(
              builder: (_) => DailyWeather(weatherData: args));
        }
        return _errorRoute();
      // case '/timeMechine' :
      //   if (args is TimeMechineModel) {
      //     return MaterialPageRoute(
      //         builder: (_) => ColumnWidgetTimeMechine(timeMechine: args));
      //   }
      //   return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

// WeatherHome
