import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PulsePoint extends StatefulWidget {
  const PulsePoint({
    super.key,
    this.mainColor,
    this.pulseColor,
    this.size,
    this.outlineColor,
    this.outlined = false,
  });

  final Color? mainColor;
  final Color? pulseColor;
  final double? size;
  final Color? outlineColor;
  final bool outlined;

  @override
  State<PulsePoint> createState() => _PulsePointState();
}

class _PulsePointState extends State<PulsePoint> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _fadeCircle(),
        _dot(),
      ],
    );
  }

  Widget _fadeCircle() {
    final size = (widget.size ?? 30) < 20 ? 20 : (widget.size ?? 30);

    return Animate(
      onPlay: (controller) => controller.repeat(),
      effects: const [
        FadeEffect(
          duration: Duration(milliseconds: 1500),
          begin: 1.0,
          end: 0.0,
        ),
        ScaleEffect(
          duration: Duration(milliseconds: 1500),
          curve: Curves.fastOutSlowIn,
          begin: Offset(0.0, 0.0),
          end: Offset(1.0, 1.0),
        )
      ],
      autoPlay: true,
      child: Container(
        width: size * 2,
        height: size * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.pulseColor ?? Colors.red.shade300,
        ),
      ),
    );
  }

  Container _dot() {
    return Container(
      width: (widget.size ?? 10),
      height: (widget.size ?? 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.mainColor ?? Colors.red,
        border: Border.all(color: widget.outlineColor ?? Colors.white),
      ),
    );
  }
}
