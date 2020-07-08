import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_weathe_sapp/service/addMethod.dart';
import 'package:new_weathe_sapp/service/bloc/bloc.dart';
import 'package:new_weathe_sapp/view/widget/widget.dart';
// import 'addMethod.dart';

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final blocs = BloctestDartBloc();

  @override
  void dispose() {
    super.dispose();
    blocs.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
        ),
        body: Container(
            child: BlocProvider(
                create: (context) => blocs, child: WeatherChilds())));
  }
}

class WeatherChilds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: BlocListener<BloctestDartBloc, BloctestDartState>(
        bloc: BlocProvider.of<BloctestDartBloc>(context),
        listener: (context, BloctestDartState state) {
          if (state is RetrieveData) {}
        },
        child: BlocBuilder<BloctestDartBloc, BloctestDartState>(
            bloc: BlocProvider.of<BloctestDartBloc>(context),
            builder: (BuildContext context, BloctestDartState states) {
              final weatherBloc = BlocProvider.of<BloctestDartBloc>(context);
              if (states is BloctestDartInitial) {
                weatherBloc.add(GetData());
                return CircularProgressIndicator();
              } else if (states is RetrieveData) {
                reloadEveryOneHours(() => weatherBloc.add(RestartData()));
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ColumnWeatherWidgets(
                      geolocations: states.geolocations,
                      weatherData: states.currenlist,
                      timeMechineWidget: states.timeMechineAppre,
                    ));
              } else if (states is BloctestDartLoading) {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
