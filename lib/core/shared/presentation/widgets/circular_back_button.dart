import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CircularBackButton extends StatelessWidget {
  const CircularBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return _backButton(context);
  }

  Widget _backButton(BuildContext context) {
    return InkWell(
      onTap: () => context.pop(),
      child: Container(
        margin: const EdgeInsets.only(top: 8, left: 8),
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
