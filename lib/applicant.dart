import 'dart:io' as io;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

class Applicant {
  String applicantJson;
  String pathName;
  io.Directory directory;
  io.File applicantFile;
  String name = '';
  String cellPhoneNumber = '';
  String workPhoneNumber = '';
  String email = '';
  String birthday = '';
  String ssn = '';
  String street = '';
  String city = '';
  String state = '';
  String zip = '';
  String licenseImageFilePath = '';
  io.File licenseImageFile;

  Future<bool> loadApplicant() async {
    bool status = false;
    // load method
    // This is like a constructor, but has to be separate because
    // a constructor can't be async

    directory = await getApplicationDocumentsDirectory();
    pathName = directory.path + "/save.json";
    applicantFile = io.File(pathName);

    try {
      applicantJson = applicantFile.readAsStringSync();
      Map<String, dynamic> applicantMap = jsonDecode(applicantJson);

      name = applicantMap['name'];
      cellPhoneNumber = applicantMap['cellPhoneNumber'];
      workPhoneNumber = applicantMap['workPhoneNumber'];
      email = applicantMap['email'];
      birthday = applicantMap['birthday'];
      ssn = applicantMap['ssn'];
      street = applicantMap['street'];
      city = applicantMap['city'];
      state = applicantMap['state'];
      zip = applicantMap['zip'];
      licenseImageFilePath = applicantMap['licenseImageFilePath'];

      if (licenseImageFilePath != '') {
        licenseImageFile = io.File(licenseImageFilePath);
      }
      status = true;
    } catch (e) {
      print(e);
    }

    return status;
  }

  void processApplication() async {
    var mailBody = """
      <html>
      <h1>Rental Application</h1>
      <br>
      <p><b>Name:<b> $name</p>
      <p><b>Cell phone:<b> $cellPhoneNumber</p>
      <p><b>Work phone:<b> $workPhoneNumber</p>
      <p><b>Birthday:<b> $birthday</p>
      <p><b>email:<b> $email</p>
      <p><b>Social Security Number<b> shouldn't be emailed.</p>
      <p><b>Address</p>
      <p>$street</p>
      <p>$city, $state $zip</p>
      </html>""";

    final MailOptions mailOptions = MailOptions(
      body: mailBody,
      subject: 'Rental Application for $name',
      recipients: ['nobody@gmail.com'],
      isHTML: true,
      bccRecipients: [''],
      ccRecipients: [''],
      attachments: [
        licenseImageFilePath,
      ],
    );

    await FlutterMailer.send(mailOptions);
  }

  saveApplicant() {
    // The applicantFile is initialized in loadApplicant
    if (licenseImageFile != null) {
      licenseImageFilePath = licenseImageFile.path;
    }

    Map<String, String> applicantMap = {
      'name': name,
      'cellPhoneNumber': cellPhoneNumber,
      'workPhoneNumber': workPhoneNumber,
      'email': email,
      'birthday': birthday,
      'ssn': ssn,
      'street': street,
      'city': city,
      'state': state,
      'zip': zip,
      'licenseImageFilePath': licenseImageFilePath,
    };

    applicantJson = jsonEncode(applicantMap);

    try {
      applicantFile.writeAsStringSync(applicantJson);
    } catch (e) {
      print(e);
    }
  }
}
