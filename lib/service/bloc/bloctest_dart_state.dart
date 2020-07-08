import 'package:equatable/equatable.dart';
import 'package:new_weathe_sapp/model/model.dart';

abstract class BloctestDartState extends Equatable {
  const BloctestDartState();
}

class BloctestDartInitial extends BloctestDartState {
  @override
  List<Object> get props => [];
}

class RetrieveData extends BloctestDartState {
  final WeatherData currenlist;
  final String geolocations;
  final bool timeMechineAppre;
  RetrieveData(this.currenlist, this.geolocations, this.timeMechineAppre);
  @override
  List<Object> get props => [currenlist, geolocations, timeMechineAppre];
}

class BloctestDartLoading extends BloctestDartState {
  @override
  List<Object> get props => [];
}
