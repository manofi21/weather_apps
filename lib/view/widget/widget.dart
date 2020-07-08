import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_weathe_sapp/model/model.dart';
import 'package:new_weathe_sapp/service/addMethod.dart';
import 'package:new_weathe_sapp/service/bloc/bloc.dart';

List<Widget> listCores(
    {Widget city,
    Center temperature,
    Widget listPerHours,
    Widget listPerDaily,
    Widget timeMachine}) {
  return [
    city,
    SizedBox(
      height: 12,
    ),
    temperature,
    listPerHours,
    listPerDaily,
    timeMachine
  ];
}

Widget temperature(WeatherData weathers, double size) {
  Currently currenTime = weathers.currently;
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 8, right: 8),
            child: Image.asset(
              'assets/icon/${currenTime.icon}.png',
              scale: 10,
            )),
        Text("${currenTime.apparentTemperature.round()} °C",
            style: TextStyle(fontSize: size, fontWeight: FontWeight.bold))
      ],
    ),
  );
}

ListTile listTileCurrently(Currently current) {
  return ListTile(
    title: Text(changesToTime(current.time)),
    trailing: Text(current.apparentTemperature.toString() + " °C"),
  );
}

Container headres() {
  return Container(
      margin: EdgeInsets.only(top: 9),
      color: Colors.blue,
      child: ListTile(
        title: Text("Hours"),
        trailing: Text("Temperature"),
      ));
}

Column fullListCurrently(Hourly hours) {
  return Column(children: [
    headres(),
    for (int i = 0; i < 6; i++) listTileCurrently(hours.data[i])
  ]);
}

class ColumnWeatherWidgets extends StatelessWidget {
  final String geolocations;
  final WeatherData weatherData;
  final bool timeMechineWidget;

  const ColumnWeatherWidgets(
      {Key key, this.geolocations, this.weatherData, this.timeMechineWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<BloctestDartBloc>(context);
    return Column(
        children: listCores(
            city: Text(geolocations),
            temperature: temperature(weatherData, 20),
            listPerHours: fullListCurrently(weatherData.hourly),
            listPerDaily: jumpToDailyPages(context, weatherData),
            timeMachine: (timeMechineWidget)
                ? RaisedButton(
                    onPressed: () => pickDates(context),
                    child: Text("Time Machine"))
                : RaisedButton(
                    onPressed: () => weatherBloc.add(RestartData()),
                    child: Text("Back to Home"))));
  }
}

class InFBuilder extends StatelessWidget {
  final List<Currently> weathers;
  InFBuilder(this.weathers);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 9,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(changesToTime(weathers[index].time)),
            trailing:
                Text(weathers[index].apparentTemperature.toString() + " °C"),
          );
        });
  }
}

ListTile listTileDatum(Datum current) {
  return ListTile(
    title: Text(changesToDate(current.time)),
    trailing: Text(current.apparentTemperatureHigh.toString() + " °C"),
  );
}

class DailyWeather extends StatelessWidget {
  final WeatherData weatherData;
  const DailyWeather({Key key, this.weatherData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather of This Week"),
      ),
      body: Container(
          child: Column(
        children: weatherData.daily.data.map((e) {
          return listTileDatum(e);
        }).toList(),
      )),
    );
  }
}

Widget jumpToDailyPages(BuildContext context, WeatherData weather) {
  return RaisedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/weekDetails', arguments: weather);
      },
      child: Text("See for This Week"));
}