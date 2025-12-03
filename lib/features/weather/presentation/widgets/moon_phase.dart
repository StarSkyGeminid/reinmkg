import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

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

  Map<double, String> names = {};

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
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    names = {
      0: Strings.of(context).moonPhaseNew,
      0.125: Strings.of(context).moonPhaseWaxingCrescent,
      0.25: Strings.of(context).moonPhaseFirstQuarter,
      0.375: Strings.of(context).moonPhaseWaxingGibbous,
      0.5: Strings.of(context).moonPhaseFullMoon,
      0.625: Strings.of(context).moonPhaseWaningGibbous,
      0.75: Strings.of(context).moonPhaseLastQuarter,
      0.875: Strings.of(context).moonPhaseWaningCrescent,
      1: Strings.of(context).moonPhaseNew,
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = names.entries.reduce((a, b) {
      return (widget.phase >= a.key && widget.phase < b.key) ? a : b;
    }).value;

    final phaseName = name;

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
            children: [_moonPhase(), _moonDetail(phaseName, context)],
          );
        },
      ),
    );
  }

  Column _moonDetail(String phaseName, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(phaseName, style: Theme.of(context).textTheme.titleSmall),
        Text(
          Strings.of(
            context,
          ).moonPhaseIlluminatedPercent((widget.fraction * 100).toInt()),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Stack _moonPhase() {
    return Stack(
      children: [
        Image.asset('lib/assets/icon/moon.png', width: 70, height: 70),
        CustomPaint(
          size: const Size(70, 70),
          painter: MoonPhasePainter(
            fraction: _animation.value,
            phase: widget.phase,
          ),
        ),
      ],
    );
  }
}
