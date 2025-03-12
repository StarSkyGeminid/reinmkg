import 'package:flutter/material.dart';
import 'package:reinmkg/core/core.dart';
import 'package:go_router/go_router.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(Routes.dashboard.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Theme.of(context).canvasColor,
        child: Center(
          child: CircleAvatar(
            backgroundColor: Theme.of(context).hintColor,
            radius: Dimens.menu + Dimens.space6,
            child: CircleAvatar(
              backgroundImage: AssetImage(Images.icLogo),
              radius: Dimens.menu,
            ),
          ),
        ),
      ),
    );
  }
}
