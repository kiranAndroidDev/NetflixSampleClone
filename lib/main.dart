import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_sample_app/AppTheme.dart';
import 'package:netflix_sample_app/routes.dart';
import 'package:netflix_sample_app/simple_bloc_delegate.dart';
import 'package:netflix_sample_app/home/ui/HomePage.dart';
import 'package:netflix_sample_app/splash/SplashPage.dart';
import 'package:provider/provider.dart';

Future main() async {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp() {
    BlocSupervisor.delegate = SimpleBlocDelegate();
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool splashFinish = false;

  @override
  void initState() {
    super.initState();
    splashDelay();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: splashFinish ? HomePage() : SplashPage(),

         theme: AppTheme.getThemeData(context),
    );
  }

  void splashDelay() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        splashFinish = true;
      });
    });
  }
}
