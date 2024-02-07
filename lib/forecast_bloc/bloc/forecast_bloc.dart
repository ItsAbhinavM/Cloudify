import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/data/myData.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc() : super(ForecastInitial()) {
    on<FetchForecast>((event, emit) async {
      ForecastLoading();
      try {
        WeatherFactory wf = WeatherFactory(ApiKey, language: Language.ENGLISH);
        //Position forecastPosition = await Geolocator.getCurrentPosition();
        List<Weather> forecast = await wf.fiveDayForecastByLocation(
            event.forecastPosition.latitude, event.forecastPosition.longitude);
        emit(ForecastSuccess(forecast: forecast));
      } catch (e) {
        emit(ForecastFailure());
      }
    });
  }
}
