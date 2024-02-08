import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
        padding: const EdgeInsets.only(left: 8.0),
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
                              child: Text(
                                "Today : ",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
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
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        color: Colors.blue.withOpacity(0.19),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${state.forecast[index].date.hour}:${state.forecast[index].date.minute}', // Hour of today
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 218, 210, 210),
                                                fontSize: 30,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            "${state.forecast[index].temperature!.celsius!.round()}℃", // status text
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 35,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            "${state.forecast[index].weatherMain}", // status text
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                    ),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "15/2/24/",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Image.asset('assets/9.png'),
                                  Text(
                                    "${state.forecast[0].tempMin}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '${state.forecast}',
                            style: const TextStyle(color: Colors.white),
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
