import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.cloud_sunny,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.chart5,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.setting,
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
