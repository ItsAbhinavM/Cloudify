part of 'forecast_bloc.dart';

sealed class ForecastEvent extends Equatable {
  const ForecastEvent();

  @override
  List<Object> get props => [];
}

class FetchForecast extends ForecastEvent {
  final Position forecastPosition;
  const FetchForecast({required this.forecastPosition});

  @override
  List<Object> get props => [forecastPosition];
}
