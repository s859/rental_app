import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.title, this.color, @required this.onPressed});
  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 80.0,
          height: 32.0,
          child: Text(
            title,
//            style: TextStyle(
//              color: Colors.white,
//            ),
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
