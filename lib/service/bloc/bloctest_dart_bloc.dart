import 'dart:async';
// import 'bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:new_weathe_sapp/model/model.dart';
import 'package:new_weathe_sapp/service/api.dart';

import 'bloc.dart';

class BloctestDartBloc extends Bloc<BloctestDartEvent, BloctestDartState> {
  @override
  BloctestDartState get initialState => BloctestDartInitial();

  @override
  Stream<BloctestDartState> mapEventToState(
    BloctestDartEvent event,
  ) async* {
    String getlocations = await getLocations();
    if (event is GetData) {
      WeatherData currentLIst = await getWeatherDataAPI();
      yield RetrieveData(currentLIst, getlocations, true);
    } else if (event is RestartData) {
      yield BloctestDartInitial();
    } else if (event is GetDates) {
      yield BloctestDartLoading();
      WeatherData futureOrPastWeather = await getWeatherTimeDataAPI(event.dates);
      yield RetrieveData(futureOrPastWeather, getlocations, false);
    }
  }
}
