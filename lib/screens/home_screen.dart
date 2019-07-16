import 'package:flutter/material.dart';
import 'package:rental_app/screens/apply_screen.dart';
import 'package:rental_app/screens/capture_screen.dart';
import 'package:rental_app/components/rounded_button.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Property Rentals"),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Rental Application',
              color: Colors.lightBlueAccent,
              onPressed: () {
                //Go to registration screen.
                Navigator.pushNamed(context, ApplyScreen.id);
              },
            ),
            RoundedButton(
              title: 'Capture License',
              color: Colors.blueAccent,
              onPressed: () {
                //Go to registration screen.
                Navigator.pushNamed(context, CaptureScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
