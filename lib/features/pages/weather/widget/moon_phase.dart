import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/enumerate/moon_phase.dart';
import '../../../../core/localization/l10n/generated/strings.dart';
import 'moon_phase_painter.dart';

class MoonPhaseWidget extends StatefulWidget {
  final double fraction;
  final double phase;

  const MoonPhaseWidget({
    super.key,
    required this.fraction,
    required this.phase,
  });

  @override
  State<MoonPhaseWidget> createState() => _MoonPhaseWidgetState();
}

class _MoonPhaseWidgetState extends State<MoonPhaseWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );


    _animation = Tween<double>(
      begin: 0,
      end: widget.fraction,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = MoonPhase.fromPhaseAngle(widget.phase).name;
    final phaseName = Strings.of(context).moonphaseText(name);

    return VisibilityDetector(
      key: const Key('Moon-phase-Widget'),
      onVisibilityChanged: (VisibilityInfo info) {
        _controller.forward();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _moonPhase(),
              _moonDetail(phaseName, context),
            ],
          );
        },
      ),
    );
  }

  Column _moonDetail(String phaseName, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          phaseName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          Strings.of(context).illumination((widget.fraction * 100)),
          // '${(widget.fraction * 100).toStringAsFixed(0)}% Illuminated',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Stack _moonPhase() {
    return Stack(
      children: [
        Image.asset(
          'assets/icon/full-moon-hdr_2.png',
          width: 70.w,
          height: 70.w,
        ),
        CustomPaint(
          size: Size(70.w, 70.w),
          painter: MoonPhasePainter(
            fraction: _animation.value,
            phase: widget.phase,
          ),
        ),
      ],
    );
  }
}
