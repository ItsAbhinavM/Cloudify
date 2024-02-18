import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/forecast_bloc/bloc/forecast_bloc.dart';

class nextDay extends StatefulWidget {
  const nextDay({super.key});

  @override
  State<nextDay> createState() => _nextDayState();
}

class _nextDayState extends State<nextDay> {
  int _weatherConditionImage(int status) {
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

  int todayContainerSized(String timeString) {
    int timeH = int.parse(timeString);
    int timeRemaining = 23 - timeH;
    int timeRemainingIndex = timeRemaining.floor() ~/ 3;
    if (timeRemaining == 0) {
      return 1;
    } else {
      return timeRemainingIndex;
    }
  }

  int _dayContainerIndexLength(
      String one, String two, String three, String four) {
    int One;
    int Two;
    int Three;
    if (one != 'null' && two == 'null' && three == 'null' && four == 'null') {
      return int.parse(one) + 9;
    } else if (one != 'null' &&
        two != 'null' &&
        three == 'null' &&
        four == 'null') {
      return int.parse(one) + 17;
    } else if (one != 'null' &&
        two == 'null' &&
        three != 'null' &&
        four == 'null') {
      return int.parse(one) + 25;
    } else if (one != 'null' &&
        two == 'null' &&
        three == 'null' &&
        four != 'null') {
      return int.parse(one) + 25;
    } else {
      return int.parse(one);
    }
  }

  int dayDecider(String one, String two, String three) {
    if (one != 'null' && two == 'null' && three == 'null') {
      return int.parse(one) + 7;
    } else if (one == 'null' && two != 'null' && three == 'null') {
      return int.parse(two) + 15;
    } else if (one == 'null' && two == 'null' && three != 'null') {
      return int.parse(three) + 22;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.pop(context), // back button
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Back",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<ForecastBloc, ForecastState>(
                builder: (context, state) {
                  print(state);
                  if (state is ForecastSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "This Week",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/7.png',
                                height: 100,
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "Next 24Hrs :  ",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                  /*Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Image.asset(
                                      'assets/5.png',
                                      height: 50,
                                    ),
                                  )*/
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            height: 170,
                            width: 500,
                            child: ListView.builder(
                                itemCount: 9,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            color:
                                                Colors.blue.withOpacity(0.19),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                '${state.forecast[index].date.hour}:${state.forecast[index].date.minute}', // Hour of today
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "${state.forecast[index].temperature!.celsius!.round()}℃", // status text
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 50,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              Text(
                                                "${state.forecast[index].weatherMain}", // status text
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Later this week :",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                              '${DateFormat('EEEE').format(state.forecast[dayDecider((todayContainerSized('${state.forecast[0].date.hour}').toString()), 'null', 'null')].date!)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 35,
                                  color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              /*height: (80 *
                                      todayContainerSized(
                                          '${state.forecast[0].date.hour}'))
                                  .toDouble(),*/
                              height: 83 * 9,
                              width: 600,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 8,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, Index) {
                                    final index = Index +
                                        _dayContainerIndexLength(
                                            (todayContainerSized(
                                                    '${state.forecast[0].date.hour}'))
                                                .toString(),
                                            'null',
                                            'null',
                                            'null');
                                    return Column(
                                      children: [
                                        Container(
                                          height: 82,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "${state.forecast[index].date.hour}:${state.forecast[index].date.minute}",
                                                style: const TextStyle(
                                                    fontSize: 27,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${state.forecast[index].temperature!.celsius!.round()}℃", // WindSpeed
                                                    style: const TextStyle(
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${state.forecast[index].weatherMain}",
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ),
                          Text(
                              '${DateFormat('EEEE').format(state.forecast[dayDecider('null', (todayContainerSized('${state.forecast[0].date.hour}').toString()), 'null')].date!)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 35,
                                  color: Colors.white)),
                          //Third day
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              /*height: (80 *
                                      todayContainerSized(
                                          '${state.forecast[0].date.hour}'))
                                  .toDouble(),*/
                              height: 82 * 9,
                              width: 600,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 9,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, Index) {
                                    final index = Index +
                                        _dayContainerIndexLength(
                                            (todayContainerSized(
                                                    '${state.forecast[0].date.hour}'))
                                                .toString(),
                                            'nill',
                                            'null',
                                            'null');
                                    return Column(
                                      children: [
                                        Container(
                                          height: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "${state.forecast[index].date.hour}:${state.forecast[index].date.minute}",
                                                style: const TextStyle(
                                                    fontSize: 27,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${state.forecast[index].temperature!.celsius!.round()}℃", // WindSpeed
                                                    style: const TextStyle(
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${state.forecast[index].weatherMain}",
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ),
                          Text(
                              '${DateFormat('EEEE').format(state.forecast[dayDecider('null', 'null', (todayContainerSized('${state.forecast[0].date.hour}').toString()))].date!)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 35,
                                  color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              /*height: (80 *
                                      todayContainerSized(
                                          '${state.forecast[0].date.hour}'))
                                  .toDouble(),*/
                              height: 82 * 9,
                              width: 600,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 9,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, Index) {
                                    final index = Index +
                                        _dayContainerIndexLength(
                                            (todayContainerSized(
                                                    '${state.forecast[0].date.hour}'))
                                                .toString(),
                                            'null',
                                            'nill',
                                            'null');
                                    //if (index==7){}
                                    return Column(
                                      children: [
                                        Container(
                                          height: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "${state.forecast[index].date.hour}:${state.forecast[index].date.minute}",
                                                style: const TextStyle(
                                                    fontSize: 27,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${state.forecast[index].temperature!.celsius!.round()}℃", // WindSpeed
                                                    style: const TextStyle(
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${state.forecast[index].weatherMain}",
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ),
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
