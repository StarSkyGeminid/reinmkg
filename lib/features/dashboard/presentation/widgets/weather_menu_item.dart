import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WeatherMenuItem extends StatelessWidget {
  const WeatherMenuItem({super.key, required this.menu});

  final WeatherMenuType menu;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                context.pushNamed(menu.pathName);
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  menu.icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          menu.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class WeatherMenuType {
  final String name;
  final String pathName;
  final IconData icon;

  WeatherMenuType({
    required this.name,
    required this.pathName,
    required this.icon,
  });
}
