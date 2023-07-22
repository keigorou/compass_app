import 'package:compass_paint/constants.dart';
import 'package:flutter/material.dart';

class Neumorphism extends StatelessWidget {
  const Neumorphism(
      {super.key,
      required this.child,
      this.distance = 30,
      this.blur = 50,
      this.margin,
      this.padding,
      this.isReverse = false,
      this.innerShadow = false});
  final Widget child;
  final double distance;
  final double blur;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool isReverse;
  final bool innerShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          shape: BoxShape.circle,
          boxShadow: isReverse
              ? [
                  BoxShadow(
                      color: AppColor.primaryDarkColor,
                      blurRadius: blur,
                      offset: Offset(-distance, -distance)),
                  BoxShadow(
                      color: AppColor.white,
                      blurRadius: blur,
                      offset: Offset(distance, distance)),
                ]
              : [
                  BoxShadow(
                      color: AppColor.white,
                      blurRadius: blur,
                      offset: Offset(-distance, -distance)),
                  BoxShadow(
                      color: AppColor.primaryDarkColor,
                      blurRadius: blur,
                      offset: Offset(distance, distance)),
                ]),
      child: innerShadow ? TopGradientContainer(child: child) : child,
    );
  }
}

class TopGradientContainer extends StatelessWidget {
  const TopGradientContainer({
    super.key,
    required this.child,
    this.margin,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColor.primaryDarkColor, AppColor.white])),
      child: child,
    );
  }
}
