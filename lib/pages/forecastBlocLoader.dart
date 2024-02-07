import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/forecast_bloc/bloc/forecast_bloc.dart';
import 'package:weatherapp/pages/nextDay.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';

class forecastLoader extends StatelessWidget {
  const forecastLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _determinePosition(),
          builder: (context, snap) {
            print("forecast data");
            print(snap.data);
            print("snap data showed");
            if (snap.hasData && snap.data != null) {
              return BlocProvider<ForecastBloc>(
                create: (context) => ForecastBloc()
                  ..add(FetchForecast(forecastPosition: snap.data as Position)),
                child: const nextDay(),
              );
            } else {
              if (snap.connectionState == ConnectionState.waiting) {
                print("loading");
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, -1.2),
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color.fromARGB(255, 28, 126, 206)),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(3, -0.001),
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color.fromARGB(255, 225, 77, 251)),
                          ),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                          ),
                        ),
                        SizedBox(
                          height: 310,
                        ),
                        Center(
                            child: Lottie.asset("assets/loading_cloud.json")),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, -1.2),
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                shape: BoxShape.rectangle, color: Colors.blue),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(3, -0.001),
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.purpleAccent),
                          ),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                          ),
                        ),
                        SizedBox(
                          height: 310,
                        ),
                        Lottie.asset("assets/loading_cloud.json"),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          }),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
