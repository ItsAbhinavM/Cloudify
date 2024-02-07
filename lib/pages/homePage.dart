import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/bloc/weather_bloc_bloc.dart';
import 'package:weatherapp/pages/forecastBlocLoader.dart';
import 'package:weatherapp/pages/nextDay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _weatherImage(int status) {
    if (status >= 200 && status < 300) {
      return 1; //thunderstorm
    } else if (status >= 300 && status < 400) {
      return 2; //rain
    } else if (status >= 500 && status < 600) {
      return 3; //heavy rain
    } else if (status >= 600 && status < 700) {
      return 4; //snow
    } else if (status >= 700 && status < 800) {
      return 7; //atmosphere
    } else if (status == 800) {
      return 6; //clear status
    } else if (status > 800 && status < 900) {
      return 8; //clouds
    } else {
      return 13;
    }
  }

  String _timeWish(String timeString) {
    DateTime time = DateTime.parse(timeString);
    int timeH = int.parse(DateFormat.H().format(time));
    //String period = DateFormat('a').format(time);
    if (timeH > 5 && timeH < 12) {
      return "Good Morning";
    } else if (timeH > 0 && timeH < 6) {
      return "Early Morning";
    } else if (timeH >= 12 && timeH < 16) {
      return "Good Afternoon";
    } else if (timeH > 15 && timeH < 19) {
      return "Good evening";
    } else if (timeH > 18 && timeH < 24) {
      return "Good Night";
    } else {
      return "Good Day";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: 20, right: 1.2 * kToolbarHeight, top: 40, bottom: 20),
        child: Expanded(
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.orange),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "📍 ${state.weather.areaName}", //location
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _timeWish("${state.weather.date}"), //time wish
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 34),
                              ),
                              Icon(
                                // Search button
                                Icons.search,
                                color: Colors.orange,
                                size: 49,
                              )
                            ],
                          ),
                          Image.asset(
                            "assets/${_weatherImage(state.weather.weatherConditionCode)}.png",
                            scale: 1,
                          ),
                          Center(
                            child: Text(
                              " ${state.weather.temperature!.celsius!.round()}℃ ", //temperature
                              style: TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "${state.weather.weatherMain}", //weather
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd |')
                                  .add_jm()
                                  .format(state.weather.date!), // date and time
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Center(
                                  child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const forecastLoader()));
                                },
                                child: Text(
                                  "Next Days ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      foreground: Paint()
                                        ..shader = const LinearGradient(
                                            colors: <Color>[
                                              Color.fromARGB(255, 199, 154, 86),
                                              Color.fromARGB(255, 83, 35, 92),
                                              //Colors.orange
                                            ]).createShader(const Rect.fromLTRB(
                                            125.0, 100.0, 35.0, 50.0))),
                                ),
                              )),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => nextDay()));
                                },
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/11.png",
                                    scale: 8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Sunrise",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        DateFormat().add_jm().format(
                                            state.weather.sunrise!), //sunrise
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/12.png",
                                    scale: 8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Sunset",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        DateFormat().add_jm().format(
                                            state.weather.sunset!), //sunset
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/13.png",
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Max temp", // max temp
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "${state.weather.tempMax!.celsius.round()} ℃ ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/14.png",
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Min temp", // min temp
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "${state.weather.tempMin!.celsius.round()} ℃ ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
