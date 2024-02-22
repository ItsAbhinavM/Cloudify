import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/pages/weatherMap.dart';

class MapConsole extends StatelessWidget {
  final String temperature = "temp_new";
  final String precipitation = "precipitation_new";
  final String clouds = "clouds_new";
  final String windSpeed = "wind_new";
  final String seaLevelPressure = "pressure_new";
  const MapConsole({super.key});

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
        padding: const EdgeInsets.only(left: 12.0, right: 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(255, 225, 77, 251)),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(255, 28, 126, 206)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ), // I am not able to apply singleChildScrollView over the column below .
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Choose Map Filters  ",
                        style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Temperature :",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: GestureDetector(
                        onTap: () => (Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapSample(temperature)))),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/temperature.jpg'),
                                      fit: BoxFit.cover))),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Precipitation :",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: GestureDetector(
                          onTap: () => (Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MapSample(precipitation)))),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0),
                                image: const DecorationImage(
                                    image:
                                        AssetImage('assets/precipitation.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Clouds :",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20.0),
                      child: GestureDetector(
                        onTap: () => (Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapSample(clouds)))),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0),
                                image: const DecorationImage(
                                    image: AssetImage('assets/clouds.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Wind Speed :",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: GestureDetector(
                          onTap: () => (Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapSample(windSpeed)))),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0),
                                image: const DecorationImage(
                                    image: AssetImage('assets/windSpeed.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sea Level Pressure :",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20.0),
                      child: GestureDetector(
                        onTap: () => (Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MapSample(seaLevelPressure)))),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0),
                                image: const DecorationImage(
                                    image: AssetImage('assets/Seapressure.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
