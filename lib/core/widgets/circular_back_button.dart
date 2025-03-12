import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reinmkg/utils/ext/context.dart';

class CircularBackButton extends StatelessWidget {
  const CircularBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return _backButton(context);
  }

  Widget _backButton(BuildContext context) {
    return InkWell(
      onTap: context.back,
      child: Container(
        margin: EdgeInsets.only(top: 8.h, left: 8.w),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
        ),
        child: const Icon(Icons.close_rounded),
      ),
    );
  }
}
