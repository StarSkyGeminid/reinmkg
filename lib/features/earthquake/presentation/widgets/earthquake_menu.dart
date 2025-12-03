import 'package:flutter/material.dart';

import 'earthquake_type_selector.dart';

class EarthquakeMenu extends StatefulWidget {
  const EarthquakeMenu({
    super.key,
    required this.isVisible,
    required this.onChanged,
    required this.selectedIndexNotifier,
  });

  final bool isVisible;
  final void Function(int) onChanged;
  final ValueNotifier<int> selectedIndexNotifier;

  @override
  State<EarthquakeMenu> createState() => _EarthquakeMenuState();
}

class _EarthquakeMenuState extends State<EarthquakeMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      end: Offset.zero,
      begin: const Offset(0, -1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void didUpdateWidget(EarthquakeMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 0,
      right: 0,
      child: SafeArea(
        child: SizedBox(
          child: SlideTransition(
            position: _offsetAnimation,
            child: AnimatedOpacity(
              opacity: widget.isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: ValueListenableBuilder<int>(
                valueListenable: widget.selectedIndexNotifier,
                builder: (BuildContext context, int index, child) {
                  return EarthquakeTypeSelector(
                    onChanged: widget.onChanged,
                    selectedIndex: index,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
