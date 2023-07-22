import 'dart:math';

import 'package:compass_paint/constants.dart';
import 'package:compass_paint/neumorphism.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

import 'compass_view_painter.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  double? direction;

  double headingToDegree(double heading) {
    return heading < 0 ? 360 - heading.abs() : heading;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<CompassEvent>(
          stream: FlutterCompass.events,
          builder: (context, snapshot) {
            if (snapshot.hasError) return const Text('Error');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            direction = snapshot.data!.heading;
            if (direction == null) return const Text('device does not sensors');
            return Stack(
              children: [
                Neumorphism(
                  margin: EdgeInsets.all(size.width * 0.1),
                  padding: const EdgeInsets.all(10),
                  child: Transform.rotate(
                    angle: (direction! * (pi / 180) * -1),
                    child: CustomPaint(
                      size: size,
                      painter: CompassViewPainter(color: AppColor.grey),
                    ),
                  ),
                ),
                CenterDisplayMeter(
                  direction: headingToDegree(direction!),
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: AppColor.red
                  ),
                )
              ],
            );
          }),
    );
  }
}

class CenterDisplayMeter extends StatelessWidget {
  const CenterDisplayMeter({
    super.key,
    required this.direction,
  });
  final double direction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Neumorphism(
      margin: EdgeInsets.all(size.width * 0.27),
      distance: 2.5,
      blur: 5,
      child: Neumorphism(
        margin: EdgeInsets.all(size.width * 0.01),
        distance: 0,
        blur: 0,
        isReverse: true,
        innerShadow: true,
        child: Neumorphism(
            margin: EdgeInsets.all(size.width * 0.05),
            distance: 4,
            blur: 5,
            child: TopGradientContainer(
                padding: EdgeInsets.all(size.width * 0.02),
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColor.greenColor,
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment(-5, -5),
                          end: Alignment.bottomRight,
                          colors: [
                            AppColor.greenDarkColor,
                            AppColor.greenColor
                          ])),
                  child: Text(
                    " ${direction.toInt().toString().padLeft(3, '0')}°",
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: size.width * 0.1,
                        fontWeight: FontWeight.bold),
                  ),
                ))),
      ),
    );
  }
}
