import 'package:flutter/material.dart';
import 'package:reinmkg/core/resources/images.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Theme.of(context).canvasColor,
        child: Center(
          child: CircleAvatar(
            backgroundColor: Theme.of(context).hintColor,
            radius: 96,
            child: CircleAvatar(
              backgroundImage: AssetImage(Images.icLogo),
              radius: 96,
            ),
          ),
        ),
      ),
    );
  }
}
