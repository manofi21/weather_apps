import 'package:equatable/equatable.dart';

abstract class BloctestDartEvent extends Equatable {
  const BloctestDartEvent();
}

class GetData extends BloctestDartEvent {
  @override
  List<Object> get props => [];
}

class RestartData extends BloctestDartEvent {
  @override
  List<Object> get props => [];
}

class GetDates extends BloctestDartEvent {
  final String dates;
  GetDates(this.dates);

  @override
  List<Object> get props => [dates];
}