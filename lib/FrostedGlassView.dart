import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassView extends StatelessWidget {
  FrostedGlassView({
    Widget? child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.blurX = 5,
    this.blurY = 5,
    this.bgColor,
    this.borderRadius,
    this.clipBehavior = Clip.hardEdge,
  }) : this.childWidget = child;

  final double? width;
  final double? height;
  EdgeInsets? margin;
  EdgeInsets? padding;
  final Widget? childWidget;
  final double blurX;
  final double blurY;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      padding: this.padding,
      height: this.height,
      width: this.width,
      clipBehavior: this.clipBehavior,
      decoration: BoxDecoration(
        color: this.bgColor,
        borderRadius: this.borderRadius,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: this.blurX,
            sigmaY: this.blurY,
          ),
          child: childWidget ?? SizedBox(),
        ),
      ),
    );
  }
}
