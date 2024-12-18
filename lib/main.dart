import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/common/manager/networking/app_http_override.dart';
import 'package:wheelmap/presentation/home/home_view.dart';
import 'package:wheelmap/presentation/plan/plan_view.dart';

import 'themes.dart' as themes;

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HttpOverrides.global = AppHttpOverrides();
  await dotenv.load(fileName: ".env");
  runApp(MainApp());
}

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => HomeView(), name: 'home'),
    GoRoute(
        path: '/plan',
        builder: (context, __) {
          //TODO: add coordinates here
          return PlansView(
            isDefault: false,
            coordinates: [],
          );
        }),
  ],
);

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: AppStrings.appName,
    //   theme: themes.amberTheme,
    //   home: HomeView()
    //   );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: themes.amberTheme,
      routerConfig: router,
    );
  }
}
