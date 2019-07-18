import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// Define a Custom Form Widget
class CalcScreen extends StatefulWidget {
  static const String id = "calc_screen";

  @override
  _CalcScreenState createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  Widget rowspacer = Container(
    height: 8.0,
  );

  // Set initial value for monthly income in dollars

  int income = 2000;
  double incomeDouble = 2000.0;
  double income33Percent = 2000.0 * 0.33;
  double income25Percent = 2000.0 * 0.25;

  String formatDollars(double incomeDouble) {
    final NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 0);
    return currencyFormatter.format(incomeDouble);
  }

  @override
  Widget build(BuildContext context) {
//    sleep(const Duration(seconds: 1));
//    setState(() {});

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[50],
        body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Rent Affordability Calculator',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                rowspacer,
                rowspacer,
                Container(
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.brown[100],
                      border: Border.all(
                        width: 1.0,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Monthly gross income: ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                formatDollars(incomeDouble),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
//                          income.toString(),
//                  style: kNumberTextStyle,
                            ]),
                        rowspacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 6,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.black,
                                    inactiveTrackColor: Colors.grey,
                                    thumbColor: Colors.amberAccent,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 15.0),
                                    overlayColor: Colors.amberAccent[100],
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 28.0)),
                                child: Slider(
                                  value: income.toDouble(),
                                  min: 1500.0,
                                  max: 8000.0,
                                  onChanged: (double newValue) {
                                    incomeDouble = newValue;
                                    income25Percent = incomeDouble * 0.25;
                                    income33Percent = incomeDouble * 0.33;
                                    setState(() {
                                      income = newValue.round();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        rowspacer,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Maximum (33%) monthly rent: ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                formatDollars(income33Percent),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
                        rowspacer,
                        rowspacer,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Optimal (25%) monthly rent: ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                formatDollars(income25Percent),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
                      ]),
                ),
              ]),
        ),
      ),
    );
  }
}
