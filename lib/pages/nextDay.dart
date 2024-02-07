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
                      shape: BoxShape.rectangle, color: Colors.blue),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(3, -0.001),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.purpleAccent),
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
                  if (state is ForecastSuccess) {
                    return SingleChildScrollView(
                      child: Column(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  color: Colors.grey.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "15/224/",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Image.asset('assets/9.png'),
                                  Text(
                                    "22/35",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '${state}',
                            style: TextStyle(color: Colors.white),
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
