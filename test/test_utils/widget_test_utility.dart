import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget wrapWidgetForTesting(Widget child) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
      home: Material(
        child: child,
      ),
    ),
  );
}

Widget wrapWidgetForTestingWithCubitProvider<T extends Cubit>(
    Widget child, T mockedCubit) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<T>(
        create: (context) => mockedCubit,
      )
    ],
    child: MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        supportedLocales: const [Locale('en', '')],
        home: Material(
          child: child,
        ),
      ),
    ),
  );
}
