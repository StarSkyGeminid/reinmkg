import 'package:flutter/material.dart';

import '../../../core/enumerate/earthquakes_type.dart';
import 'widget/widget.dart';

class EarthquakePage extends StatefulWidget {
  const EarthquakePage({super.key, this.heroKey});

  final String? heroKey;

  @override
  State<EarthquakePage> createState() => _EarthquakePageState();
}

class _EarthquakePageState extends State<EarthquakePage>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();

  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  final ValueNotifier<bool> isHideMenuNotifier = ValueNotifier<bool>(true);

  List<Widget> pages = [];

  bool isSwaping = false;

  @override
  void initState() {
    super.initState();

    listenControllerChanges();

    pages.addAll([
      EarthquakeMapView(
        key: const PageStorageKey<String>('earthquake_interactive_map'),
        heroKey: widget.heroKey,
        onRequestHide: (value) {
          isHideMenuNotifier.value = !value;
        },
      ),
      EarthquakeDataView(
        earthquakesType: EarthquakesType.felt,
        onTap: _handleDataViewTap,
      ),
      EarthquakeDataView(
        earthquakesType: EarthquakesType.realtime,
        onTap: _handleDataViewTap,
      ),
      EarthquakeDataView(
        earthquakesType: EarthquakesType.overFive,
        onTap: _handleDataViewTap,
      ),
      EarthquakeDataView(
        earthquakesType: EarthquakesType.tsunami,
        onTap: _handleDataViewTap,
      ),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDataViewTap() {
    onTap(0);
  }

  void onTap(int index) {
    if (!_controller.hasClients) return;

    selectedIndexNotifier.value = index;

    isSwaping = true;

    _controller
        .animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    )
        .then((_) {
      isSwaping = false;
    });
  }

  void listenControllerChanges() {
    _controller.addListener(() {
      final currentPage = (_controller.page?.toInt() ?? 0);

      if (!_controller.hasClients || isSwaping) {
        return;
      }

      selectedIndexNotifier.value = currentPage;
    });
  }

  @override
  void didUpdateWidget(EarthquakePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    onTap(0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isHideMenuNotifier,
          builder: (BuildContext context, bool isVisible, _) {
            return EarthquakeMenu(
              isVisible: isVisible,
              onChanged: onTap,
              selectedIndexNotifier: selectedIndexNotifier,
            );
          },
        ),
      ],
    );
  }
}

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
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

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
