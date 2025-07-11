import 'dart:ui';

import 'package:flutter/material.dart';

class GlossyCard extends StatelessWidget {
  const GlossyCard(
      {super.key,
      required this.child,
      this.blueStrength,
      this.border,
      this.borderRadius,
      this.padding,
      this.strokeAlign});

  final Widget child;
  final double? blueStrength;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsets? padding;
  final double? strokeAlign;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: blueStrength ?? 10, sigmaY: blueStrength ?? 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: border ??
                  Border.all(
                      width: 1,
                      color: Colors.white24,
                      strokeAlign:
                          strokeAlign ?? BorderSide.strokeAlignOutside),
              borderRadius: borderRadius ?? BorderRadius.circular(20)),
          child: padding != null
              ? Padding(
                  padding: padding!,
                  child: child,
                )
              : child,
        ),
      ),
    );
  }
}
