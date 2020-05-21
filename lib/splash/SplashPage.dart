import 'dart:async';
import 'package:flutter/material.dart';
import 'package:netflix_sample_app/AppTheme.dart';

import '../home/ui/HomePage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return _buildSplashPage();
  }

  _buildSplashPage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Image.asset("assets/logo.jpg",width: 300)
     ],
    );
  }
}
