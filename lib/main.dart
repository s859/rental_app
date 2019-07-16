import 'package:flutter/material.dart';
import 'package:rental_app/screens/home_screen.dart';
import 'package:rental_app/screens/apply_screen.dart';
import 'package:rental_app/screens/capture_screen.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(RentalApp());
}

class RentalApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //title: 'Property rental app',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.amber[100],
          backgroundColor: Colors.amber[100],
          accentColor: Colors.amberAccent,
          fontFamily: 'NotoSerif',
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          ApplyScreen.id: (context) => ApplyScreen(),
          CaptureScreen.id: (context) => CaptureScreen(),
        });
  }
}
