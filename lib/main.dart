import 'package:flutter/material.dart';
import 'package:watertracker/home_Screen.dart';
void main(){
  runApp( const waterTrackerApp());
}
class waterTrackerApp extends StatelessWidget {
  const waterTrackerApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
