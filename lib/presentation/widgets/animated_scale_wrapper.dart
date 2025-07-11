import 'package:flutter/cupertino.dart';

class AnimatedScaleWrapper extends StatefulWidget {
  const AnimatedScaleWrapper(
      {super.key,
      required this.child,
      this.onTap,
      this.duration,
      this.minScale});

  final Widget child;
  final Duration? duration;
  final double? minScale;
  final VoidCallback? onTap;

  @override
  State<AnimatedScaleWrapper> createState() => _AnimatedScaleWrapperState();
}

class _AnimatedScaleWrapperState extends State<AnimatedScaleWrapper> {
  double scale = 1;

  void scaleForward() {
    setState(() {
      scale = widget.minScale ?? 0.85;
    });
  }

  void scaleBack() {
    setState(() {
      scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        scaleForward();
      },
      onTapUp: (_) {
        if (widget.onTap != null) {
          widget.onTap!();
        }
        scaleBack();
      },
      child: AnimatedScale(
        scale: scale,
        duration: widget.duration ?? Duration(milliseconds: 120),
        // onEnd: scaleBack,
        child: widget.child,
      ),
    );
  }
}