import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rental_app/components/rounded_button.dart';
import 'package:rental_app/components/number_formatter.dart';
import 'package:rental_app/applicant.dart';
import 'package:rental_app/constants.dart';

// Define a Custom Form Widget
class ApplyScreen extends StatefulWidget {
  static const String id = "apply_screen";

  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  Applicant applicant = Applicant();
  Future<String> loadApplicant;

  @override
  void initState() {
    super.initState();
    getApplicant();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 250.0, maxWidth: 340.0);

    applicant.licenseImageFile = image;

    setState(() {
      applicant.licenseImageFile = image;
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    _nameTextController.dispose();
    _cellPhoneNumberTextController.dispose();
    _workPhoneNumberTextController.dispose();
    _emailTextController.dispose();
    _birthdayTextController.dispose();
    _ssnTextController.dispose();
    _streetTextController.dispose();
    _cityTextController.dispose();
    _stateTextController.dispose();
    _zipTextController.dispose();
    super.dispose();
  }

  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _cellPhoneNumberTextController =
      TextEditingController();
  TextEditingController _workPhoneNumberTextController =
      TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _birthdayTextController = TextEditingController();
  TextEditingController _ssnTextController = TextEditingController();
  TextEditingController _streetTextController = TextEditingController();
  TextEditingController _cityTextController = TextEditingController();
  TextEditingController _stateTextController = TextEditingController();
  TextEditingController _zipTextController = TextEditingController();

  getApplicant() async {
    Future<bool> loaded;
    loaded = applicant.loadApplicant();
    loaded.then(
      (value) {
        _nameTextController.text = applicant.name;
        _cellPhoneNumberTextController.text = applicant.cellPhoneNumber;
        _workPhoneNumberTextController.text = applicant.workPhoneNumber;
        _emailTextController.text = applicant.email;
        _birthdayTextController.text = applicant.birthday;
        _ssnTextController.text = applicant.ssn;
        _streetTextController.text = applicant.street;
        _cityTextController.text = applicant.city;
        _stateTextController.text = applicant.state;
        _zipTextController.text = applicant.zip;
        setState(() {});
      },
    );
  }

  void saveApplicant() {
    try {
      applicant.saveApplicant();
    } catch (e) {
      print(e);
    }
  }

  void processApplicant() async {
    try {
//      await applicant.processApplication();
      applicant.processApplication();
    } catch (e) {
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();

  final UsPhoneTextInputFormatter _phoneNumberFormatter =
      UsPhoneTextInputFormatter();

  final SocSecTextInputFormatter _socSecNumberFormatter =
      SocSecTextInputFormatter();

  final UsDateTextInputFormatter _dateTextInputFormatter =
      UsDateTextInputFormatter();

//  bool _formWasEdited = false;

  String _validateName(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Enter name';
    if (value.length < 8) return '8 or more characters';
    return null;
  }

  String _validatePhoneNumber(String value) {
//    _formWasEdited = true;
    final RegExp phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value)) return '10 digit phone #';
    return null;
  }

  String _validateSocSec(String value) {
//    _formWasEdited = true;
    final RegExp socSecExp = RegExp(r'\d\d\d\-\d\d\-\d\d\d\d$');
    if (!socSecExp.hasMatch(value)) return '9 digit SSN';
    return null;
  }

  String _validateDate(String value) {
//    _formWasEdited = true;
//    final RegExp dateExp = RegExp(r'\d\d\/\d\d\/\d\d\d\d$');
    final RegExp dateExp =
        RegExp(r'^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$');
    if (!dateExp.hasMatch(value)) return 'mmddyyyy';
    return null;
  }

  String _validateEmail(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Enter email address';
    if (value.length < 8) return '8 or more characters';
    if (!value.contains('@')) return 'Missing @';
    return null;
  }

  String _validateStreet(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Enter street address';
    if (value.length < 10) return '10 or more characters';
    return null;
  }

  String _validateCity(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Enter City';
    if (value.length < 3) return '3 or more characters';
    return null;
  }

  String _validateState(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Enter state';
    if (value.length != 2) return '2 character state';
    RegExp stateExp =
        RegExp(r"A[LKSZRAEP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|"
            r"M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|"
            r"V[AIT]|W[AIVY]");
//    final RegExp stateExp = RegExp(
//        r'AL|AK|AS|AZ|AR|CA|CO|CT|DE|DC|FM|FL|GA|GU|HI|ID|IL|IN|IA|KS|KY|LA|ME|MH|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|MP|OH|OK|OR|PW|PA|PR|RI|SC|SD|TN|TX|UT|VT|VI|VA|WA|WV|WI|WY');
    if (!stateExp.hasMatch(value)) return 'Invalid';
    return null;
  }

  String _validateZip(String value) {
//    _formWasEdited = true;
    if (value.isEmpty) return 'Enter zipcode';
    if (value.length < 5) return '5 or more chars';
    if (value.length == 5) {
      final RegExp zip1Exp = RegExp(r'\d\d\d\d\d$');
      if (zip1Exp.hasMatch(value)) {
        return null;
      } else {
        return 'Invalid';
      }
    }
    if (value.length == 10) {
      final RegExp zip2Exp = RegExp(r'\d\d\d\d\d\-\d\d\d\d$');
      if (zip2Exp.hasMatch(value)) {
        return null;
      } else {
        return 'Invalid';
      }
    }
    return 'Invalid';
  }

  Widget rowspacer = Container(
    height: 8.0,
  );

  @override
  Widget build(BuildContext context) {
//    sleep(const Duration(seconds: 1));
//    setState(() {});

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[50],
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                color: Colors.amber[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Applicant Information',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    rowspacer,
                    Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        Flexible(
                          flex: 6,
                          child: TextFormField(
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Name - First MI Last'),
                            controller: _nameTextController,
                            onSaved: (String value) {
                              applicant.name = value;
                            },
                            validator: _validateName,
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(35),
                              WhitelistingTextInputFormatter(
                                  RegExp("[a-zA-Z ]")),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Container(),
                        ),
                      ],
                    ),
                    rowspacer,
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Home or cell'),
                            controller: _cellPhoneNumberTextController,
                            onSaved: (String value) {
                              applicant.cellPhoneNumber = value;
                            },
                            validator: _validatePhoneNumber,
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(14),
                              WhitelistingTextInputFormatter.digitsOnly,
                              // Fit the validating format.
                              _phoneNumberFormatter,
                            ],
                          ),
                        ),
                        Icon(Icons.phone),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration:
                                kTextFieldDecoration.copyWith(hintText: 'Work'),
                            controller: _workPhoneNumberTextController,
                            onSaved: (String value) {
                              applicant.workPhoneNumber = value;
                            },
                            validator: _validatePhoneNumber,
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(14),
                              WhitelistingTextInputFormatter.digitsOnly,
                              // Fit the validating format.
                              _phoneNumberFormatter,
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Container(),
                        ),
                      ],
                    ),
                    rowspacer,
                    Row(
                      children: <Widget>[
                        Icon(Icons.email),
                        Flexible(
                          flex: 6,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Email address'),
                            controller: _emailTextController,
                            onSaved: (String value) {
                              applicant.email = value;
                            },
                            validator: _validateEmail,
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(35),
                              WhitelistingTextInputFormatter(
                                  RegExp("[a-zA-Z0-9.@]")),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Container(),
                        ),
                      ],
                    ),
                    rowspacer,
                    Row(
                      children: <Widget>[
                        Icon(Icons.cake),
                        Flexible(
                          flex: 3,
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Birthday mm/dd/yyyy'),
                            controller: _birthdayTextController,
                            validator: _validateDate,
                            onSaved: (String value) {
                              applicant.birthday = value;
                            },
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                              WhitelistingTextInputFormatter.digitsOnly,
                              // Fit the validating format.
                              _dateTextInputFormatter,
                            ],
                          ),
                        ),
                        Icon(Icons.contacts),
                        Flexible(
                          flex: 3,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Social Security #'),
//                            obscureText: true,
                            controller: _ssnTextController,
                            onSaved: (String value) {
                              applicant.ssn = value;
                            },
                            validator: _validateSocSec,
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(11),
                              WhitelistingTextInputFormatter.digitsOnly,
                              // Fit the validating format.
                              _socSecNumberFormatter,
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(),
                        ),
                      ],
                    ),
                    rowspacer,
                    Row(
                      children: <Widget>[
                        Text(
                          'Current Address',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    rowspacer,
                    Row(
                      children: <Widget>[
                        Icon(Icons.home),
                        Flexible(
                          flex: 6,
                          child: TextFormField(
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Street'),
                            controller: _streetTextController,
                            onSaved: (String value) {
                              applicant.street = value;
                            },
                            validator: _validateStreet,
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(35),
                              WhitelistingTextInputFormatter(
                                  RegExp("[0-9a-zA-Z ]")),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Container(),
                        ),
                      ],
                    ),
                    rowspacer,
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_city),
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                            decoration:
                                kTextFieldDecoration.copyWith(hintText: 'City'),
                            controller: _cityTextController,
                            onSaved: (String value) {
                              applicant.city = value;
                            },
                            validator: _validateCity,
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(35),
                              WhitelistingTextInputFormatter(
                                  RegExp("[a-zA-Z ]")),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Container(),
                        ),
                      ],
                    ),
                    rowspacer,
                    Row(
                      children: <Widget>[
                        Icon(Icons.home),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.characters,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'State'),
                            controller: _stateTextController,
                            onSaved: (String value) {
                              applicant.state = value;
                            },
                            validator: _validateState,
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(2),
                              WhitelistingTextInputFormatter(RegExp("[A-Z]")),
                            ],
                          ),
                        ),
                        Icon(Icons.home),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Zipcode'),
                            controller: _zipTextController,
                            onSaved: (String value) {
                              applicant.zip = value;
                            },
                            validator: _validateZip,
                            // TextInputFormatters are applied in sequence.
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                              WhitelistingTextInputFormatter(RegExp("[0-9-]")),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 6,
                          child: Container(),
                        ),
                      ],
                    ),
                    rowspacer,
                    Row(children: <Widget>[
//                      _image == null
                      applicant.licenseImageFile == null
                          ? Text('No license captured.')
                          : Image.file(applicant.licenseImageFile,
                              height: 250.0, width: 340.0),
//                          : Image.file(_image, height: 250.0, width: 340.0),
                    ]),
                    rowspacer,
                    Row(children: <Widget>[
                      RoundedButton(
                          title: 'Capture License',
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            getImage();
                            setState(() {});
                          }),
                    ]),
                    rowspacer,
                    Row(
                      children: <Widget>[
                        RoundedButton(
                            title: 'Save',
                            color: Colors.lightBlueAccent,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                // The save method saves the form so you can access the fields.
                                _formKey.currentState.save();
                                applicant.saveApplicant();
                                Alert(
                                  context: context,
                                  type: AlertType.info,
                                  title: "Property Rental App",
                                  desc: "Your data is saved locally.",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Complete",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.amberAccent[100],
                                      radius: BorderRadius.circular(0.0),
                                    ),
                                  ],
                                ).show();
                              }
                              setState(() {});
                            }),
                        SizedBox(width: 5.0),
                        RoundedButton(
                            title: 'Apply',
                            color: Colors.lightBlueAccent,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                // The save method saves the form so you can access the fields.
                                _formKey.currentState.save();
                                applicant.saveApplicant();
                                processApplicant();
                                Alert(
                                  context: context,
                                  type: AlertType.info,
                                  title: "Property Rental App",
                                  desc: "Your application has been submitted.",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Complete",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.amberAccent[100],
                                      radius: BorderRadius.circular(0.0),
                                    ),
                                  ],
                                ).show();
                              }
                              setState(() {});
                            }),
                        SizedBox(width: 5.0),
                        RoundedButton(
                            title: 'Clear',
                            color: Colors.lightBlueAccent,
                            onPressed: () {
                              _nameTextController.text = '';
                              _cellPhoneNumberTextController.text = '';
                              _workPhoneNumberTextController.text = '';
                              _emailTextController.text = '';
                              _birthdayTextController.text = '';
                              _ssnTextController.text = '';
                              _streetTextController.text = '';
                              _cityTextController.text = '';
                              _stateTextController.text = '';
                              _zipTextController.text = '';
                              applicant.licenseImageFile = null;
                              setState(() {});
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
//        ),
          ],
        ),
      ),
    );
  }
}
