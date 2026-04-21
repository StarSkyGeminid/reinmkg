import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reinmkg/core/resources/images.dart';
import 'package:reinmkg/features/general/location/presentation/cubit/location_cubit.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          context.go('/dashboard');
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
