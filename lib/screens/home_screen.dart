import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:rental_app/screens/apply_screen.dart';
//import 'package:rental_app/screens/listings_screen.dart';
import 'package:rental_app/components/rounded_button.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _launchURL() async {
//    const url = 'https://www.realiantpm.com/central-ky-rentals';
    const url = 'http://lexingtonrentalhomes.com/forrentlist.asp';
    if (await canLaunch(url)) {
      await launch(
        url,
//        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset('images/LexingtonHouse2.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TyperAnimatedTextKit(
                  text: ['Properties'],
                  textStyle: TextStyle(
                    fontSize: 20.0,
//                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.start,
                ),
//                Text("Property Rentals",
//                    style:
//                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30.0,
                ),
                Image.asset('images/RentalApp.png',
                    width: 100, height: 100, fit: BoxFit.cover),
                SizedBox(
                  height: 60.0,
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
                  title: 'View Properties',
                  color: Colors.blueAccent,
                  onPressed: () {
                    //Go to registration screen.
//                    Navigator.pushNamed(context, ListingsScreen.id);
                    _launchURL();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
