import 'package:flutter/material.dart';

import '../../domain/enumerates/earthquakes_type.dart';
import '../widgets/widgets.dart';

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
        key: PageStorageKey<String>(EarthquakesType.felt.name),
        earthquakesType: EarthquakesType.felt,
        onTap: _handleDataViewTap,
      ),
      EarthquakeDataView(
        key: PageStorageKey<String>(EarthquakesType.realtime.name),
        earthquakesType: EarthquakesType.realtime,
        onTap: _handleDataViewTap,
      ),
      EarthquakeDataView(
        key: PageStorageKey<String>(EarthquakesType.overFive.name),
        earthquakesType: EarthquakesType.overFive,
        onTap: _handleDataViewTap,
      ),
      EarthquakeDataView(
        key: PageStorageKey<String>(EarthquakesType.tsunami.name),
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
