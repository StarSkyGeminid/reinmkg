import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reinmkg/utils/ext/ext.dart';

import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../cubit/general/settings/settings_cubit.dart';

class RadarLegend extends StatefulWidget {
  const RadarLegend({super.key});

  @override
  RadarLegendState createState() => RadarLegendState();
}

class RadarLegendState extends State<RadarLegend>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _header(context),
          _legend(context),
        ],
      ),
    );
  }

  InkWell _header(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _isExpanded
              ? Theme.of(context).colorScheme.surface.withOpacity(0.9)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(12),
            bottom: Radius.circular(_isExpanded ? 0 : 12),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.water_drop,
              color: Colors.blue,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              Strings.of(context).rainIntensity,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            RotationTransition(
              turns: _iconTurns,
              child: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legend(BuildContext context) {
    return ClipRect(
      child: SizeTransition(
        sizeFactor: _heightFactor,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.white24, height: 1),
                SizedBox(height: 16.h),
                _intensityRange(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _intensityRange(BuildContext context) {
    final isMetric =
        BlocProvider.of<SettingsCubit>(context).state.measurementUnit.isMetric;

    final unit = isMetric ? 'mm' : 'inch';

    return Column(
      children: [
        _buildIntensityRange(
          '≤${isMetric ? '5' : 5.0.mmToInch.toStringAsFixed(2)} $unit/${Strings.of(context).hour.toLowerCase()}',
          Colors.lightBlue,
          Strings.of(context).rainLight,
        ),
        _buildIntensityRange(
          '≤${isMetric ? '10' : 10.0.mmToInch.toStringAsFixed(2)} $unit/${Strings.of(context).hour.toLowerCase()}',
          const Color(0xFF32CB32),
          Strings.of(context).rainModerate,
        ),
        _buildIntensityRange(
          '≤${isMetric ? '20' : 20.0.mmToInch.toStringAsFixed(2)} $unit/${Strings.of(context).hour.toLowerCase()}',
          Colors.orange,
          Strings.of(context).rainHeavy,
        ),
        _buildIntensityRange(
          '>${isMetric ? '20' : 20.0.mmToInch.toStringAsFixed(2)} $unit/${Strings.of(context).hour.toLowerCase()}',
          Colors.red,
          Strings.of(context).rainVeryHeavy,
        ),
      ],
    );
  }

  Widget _buildIntensityRange(String range, Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            range,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const Text(
            ' - ',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
