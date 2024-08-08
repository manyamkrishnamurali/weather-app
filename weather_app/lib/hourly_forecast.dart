import 'dart:ui';

import 'package:flutter/material.dart';

class hourly_forecast extends StatefulWidget {
  
  String temp;

   hourly_forecast({
    super.key,
    required this.temp,
  });

  @override
  State<hourly_forecast> createState() => _hourly_forecastState();
}

class _hourly_forecastState extends State<hourly_forecast> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        elevation: 20,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    widget.temp,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.water,
                    size: 60,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'rain',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
