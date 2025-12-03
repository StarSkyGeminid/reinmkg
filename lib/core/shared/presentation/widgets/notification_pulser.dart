import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationPulser extends StatefulWidget {
  const NotificationPulser({
    super.key,
    this.duration = const Duration(milliseconds: 1500),
    required this.background,
    this.foreground,
    this.begin = 1.0,
    this.end = 0.0,
  });

  final Widget background;
  final Widget? foreground;
  final Duration? duration;
  final double? begin;
  final double? end;

  @override
  State<NotificationPulser> createState() => _NotificationPulserState();
}

class _NotificationPulserState extends State<NotificationPulser> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _fadeCircle(),
        widget.foreground ?? const SizedBox.shrink(),
      ],
    );
  }

  Widget _fadeCircle() {
    return Animate(
      onPlay: (controller) => controller.repeat(reverse: true),
      effects: [
        FadeEffect(
          duration: widget.duration,
          begin: widget.begin,
          end: widget.end,
        ),
      ],
      autoPlay: true,
      child: widget.background,
    );
  }
}
