import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:rental_app/screens/apply_screen.dart';
import 'package:rental_app/screens/calc_screen.dart';
import 'package:rental_app/components/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;

  Future<void> _launchURL() async {
//    const url = 'https://www.realiantpm.com/central-ky-rentals';

    setState(() {
      _loading = true;
    });

    const url = 'http://lexingtonrentalhomes.com/forrentlist.asp';
//    const url = 'https://www.google.com';
    if (await canLaunch(url)) {
      await launch(
        url,
//        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
      setState(() {
        _loading = false;
      });
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        progressIndicator: CircularProgressIndicator(),
        child: Stack(
          children: <Widget>[
            Center(
              // Use a square image with boxFit.cover so the image covers
              // the screen in portrait and landscape without distorting
              // the aspect ratio
              child: Image.asset('images/LexingtonHousesSquare.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40.0, 60.0, 0.0, 0.0),
              decoration: BoxDecoration(
//                  color: Colors.brown[100],
                  border: Border.all(
                    width: 2.0,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TyperAnimatedTextKit(
                    text: ['Rental App'],
                    textStyle: TextStyle(
//                      color: Color(0xC55B11),
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.start,
                  ),
//                Text("Property Rentals",
//                    style:
//                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 25.0,
                  ),
                  Image.asset('images/RentalApp.png',
                      width: 90, height: 90, fit: BoxFit.cover),
                  SizedBox(
                    height: 40.0,
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
                      _launchURL();
                    },
                  ),
                  RoundedButton(
                    title: 'Affordability Calculator',
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, CalcScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
