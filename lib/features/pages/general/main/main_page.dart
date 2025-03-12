import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../bloc/bloc.dart';
import '../../../cubit/cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Color unselectedColor = const Color(0xFF2C4E66);
  final Color selectedColor = const Color(0xFFFF73B9);

  @override
  void initState() {
    super.initState();

    final locationId = BlocProvider.of<LocationCubit>(context)
        .state
        .location
        ?.administration
        ?.adm4;

    BlocProvider.of<LastEarthquakeFeltBloc>(context)
        .add(const LastEarthquakeFeltEvent.started());
    BlocProvider.of<RecentEarthquakeBloc>(context)
        .add(const RecentEarthquakeEvent.started());
    if (locationId == null) return;

    BlocProvider.of<CurrentWeatherCubit>(context).getCurrentWeather(locationId);
    BlocProvider.of<WeeklyWeatherCubit>(context).getWeeklyWeathers(locationId);
    BlocProvider.of<DailyWeatherCubit>(context).getDailyWeathers(locationId);
  }

  void _goBranch(int index) {
    setState(() {});

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Scaffold _buildAppView(BuildContext context) {
    final index = widget.navigationShell.currentIndex;

    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CupertinoTabBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home_2,
                color: index == 0 ? selectedColor : unselectedColor,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.cloud_sunny,
                color: index == 1 ? selectedColor : unselectedColor,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.chart5,
                color: index == 2 ? selectedColor : unselectedColor,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.setting,
                color: index == 3 ? selectedColor : unselectedColor,
              ),
              label: "",
            ),
          ],
          onTap: _goBranch,
        ),
      ),
      body: widget.navigationShell,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildAppView(context);
  }
}
