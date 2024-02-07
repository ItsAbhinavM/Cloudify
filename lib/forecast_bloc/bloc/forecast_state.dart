part of 'forecast_bloc.dart';

sealed class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

final class ForecastInitial extends ForecastState {}

final class ForecastLoading extends ForecastState {}

final class ForecastFailure extends ForecastState {}

final class ForecastSuccess extends ForecastState {
  final forecast;
  const ForecastSuccess({required this.forecast});

  @override
  List<Object> get props => [forecast]; // state for the forecast
}
