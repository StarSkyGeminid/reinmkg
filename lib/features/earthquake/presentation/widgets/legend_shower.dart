import 'package:flutter/material.dart';

import 'earthquake_legend.dart';

class LegendShower extends StatefulWidget {
  const LegendShower({super.key});

  @override
  State<LegendShower> createState() => _LegendShowerState();
}

class _LegendShowerState extends State<LegendShower>
    with SingleTickerProviderStateMixin {
  bool isExpanded = true;
  bool isHideLegend = false;

  double? width;

  final GlobalKey sizeKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isExpanded = false;

        isHideLegend = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyContext = sizeKey.currentContext;

    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox;

      width = box.size.width;
    }

    return _legend();
  }

  AnimatedPositioned _legend() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      top: 100,
      right: isExpanded && (width != null) ? 10 : -(width ?? 0),
      onEnd: () {
        setState(() {
          if (!isExpanded) {
            isHideLegend = isExpanded;
          }
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: LegendButton(
              onTap: (isExpand) {
                setState(() {
                  isExpanded = isExpand;

                  if (isExpand) {
                    isHideLegend = !isExpand;
                  }
                });
              },
            ),
          ),
          !isHideLegend
              ? EarthquakeLegend(
                  key: sizeKey,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class LegendButton extends StatefulWidget {
  const LegendButton({
    super.key,
    required this.onTap,
  });

  final void Function(bool) onTap;

  @override
  State<LegendButton> createState() => _LegendButtonState();
}

class _LegendButtonState extends State<LegendButton>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  late AnimationController _controller;

  final GlobalKey sizeKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(-0.9, 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context)
                .colorScheme
                .surface
                .withValues(alpha: isExpanded ? 0.7 : 1),
          ],
        ),
      ),
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: IconButton(
          icon: Icon(
            isExpanded ? Icons.close_rounded : Icons.legend_toggle_rounded,
          ),
          onPressed: () {
            setState(() {
              if (isExpanded) {
                _controller.reverse(from: 1.0);
              } else {
                _controller.forward(from: 0.0);
              }

              isExpanded = !isExpanded;

              widget.onTap(isExpanded);
            });
          },
        ),
      ),
    );
  }
}
