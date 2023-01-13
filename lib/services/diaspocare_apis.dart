import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DiaspoCareAPis {
  static Future login(email, password) async {
    print('These are the emails and password');
    print(email);
    print(password);
    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://healthcare-financing.diaspocare.com/api/method/hcfa_core.remote_procedures.users.login'),
          body: jsonEncode(
            {
              "usr": email,
              "pwd": password,
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
          });

      debugPrint(response.body);
      debugPrint(response.statusCode.toString());

      if (response.body.isNotEmpty) {
        json.decode(response.body);
        var data = jsonDecode(response.body);

        if (data.toString().contains('Invalid login credentials')) {
          return 'Invalid login Credentails';
        } else if (data.toString().contains('Logged In')) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userToken', data['token']);
          return 'Successfull login';
        } else {
          return 'An error has occurred';
        }
      } else {
        debugPrint('empty results');
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Server busy try again later';
    }
  }

  static Future loginForToken(email, password) async {
    print('Trying to login for token with these details');
    print(email.trim());
    print(password.trim());
    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://healthcare-financing.diaspocare.com/api/method/hcfa_core.remote_procedures.users.login'),
          body: jsonEncode(
            {
              "usr": email.trim(),
              "pwd": password.trim(),
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
          });

      debugPrint(response.body);
      debugPrint(response.statusCode.toString());

      if (response.body.isNotEmpty) {
        json.decode(response.body);
        var data = jsonDecode(response.body);
        print('Loggin in For token returned this result');
        print(data);
        if (data.toString().contains('Invalid login credentials')) {
          return 'Invalid login Credentails';
        } else if (data.toString().contains('Logged In')) {
          return data['token'];
        } else {
          return 'An error has occurred';
        }
      } else {
        debugPrint('empty results');
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Server busy try again later';
    }
  }

  static Future signUp(email, regionCode, phone, password) async {
    try {
      // print('Credentails sent to server');
      // print(email);
      // print(regionCode);
      // print(phone);
      // print(password);
      http.Response response = await http.post(
          Uri.parse(
              'https://healthcare-financing.diaspocare.com/api/method/hcfa_core.remote_procedures.users.create_diaspocare_account_v2'),
          body: jsonEncode(
            {
              "email": email,
              "region_code": 'ke',
              "mobile_no": phone,
              "new_password": password,
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
          });

      debugPrint('Response bodyyyyyyyyyyyyyyyy');
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());

      if (response.body.isNotEmpty) {
        json.decode(response.body);
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');
        if (data.toString().contains('Phone number has already been used')) {
          return 'Phone number is already in use';
        } else if (data
            .toString()
            .contains('User with that email already exists')) {
          return 'Email is already in use';
        } else if (data.toString().contains('send_welcome_email')) {
          return 'Your Account has been created';
        }
      } else {
        debugPrint('empty results');
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Server busy try again later';
    }
  }

  static Future createVendorProfile(email, facilityName, practitionerName,
      licenceNumber, country, currency, token) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://healthcare-financing.diaspocare.com/api/resource/Vendor'),
          body: jsonEncode(
            {
              "user": email,
              "pharmacy_name": facilityName,
              "practitioner_name": practitionerName,
              "licence_number": licenceNumber,
              "country": country,
              "currency": currency,
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            'Authorization': "Basic $token",
          });

      debugPrint('Response bodyyyyyyyyyyyyyyyy');
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());

      if (response.body.isNotEmpty) {
        json.decode(response.body);
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');
        if (data.toString().contains('Could not find user')) {
          return 'Could not find user';
        } else if (data.toString().contains('pharmacy_name')) {
          return 'Profile has been updated';
        } else if (data.toString().contains('already exists')) {
          return 'Profile already exists';
        } else if (data.toString().contains('Duplicate Name')) {
          return 'Practioner name already in use';
        } else {
          return 'Unidentified exception';
        }
      } else {
        debugPrint('empty results');
        return 'An unkown error occurred';
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Server busy try again later';
    }
  }

  static Future sendOtp(token) async {
    print('Trying to send otp with this token');
    print(token);
    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://healthcare-financing.diaspocare.com/api/method/hcfa_core.remote_procedures.users.generate_phonenumber_verification_OTP'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            'Authorization': "Basic $token",
          });

      if (response.body.isNotEmpty) {
        json.decode(response.body);
        var data = jsonDecode(response.body);
        print('OTP API returned this result');
        print(data);
        debugPrint('hResponseBody Decoded');
        if (data.toString().contains('true')) {
          return 'Otp sent';
        } else {
          return 'Error sending otp';
        }
      } else {
        debugPrint('empty results');
        return 'An unkown error occurred';
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Server busy try again later';
    }
  }

  static Future verifyOtp(otpCode, token) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://healthcare-financing.diaspocare.com/api/method/hcfa_core.remote_procedures.users.verify_phonenumber'),
          body: jsonEncode(
            {
              "otp": otpCode,
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            'Authorization': "Basic $token",
          });

      if (response.body.isNotEmpty) {
        json.decode(response.body);
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');
        if (data.toString().contains('true')) {
          return 'Otp verified';
        } else {
          return 'OTP code does not match';
        }
      } else {
        debugPrint('empty results');
        return 'An unkown error occurred';
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Server busy try again later';
    }
  }

  static Future getBankNames() async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://healthcare-financing.diaspocare.com/api/method/hcfa_core.remote_procedures.vendors.get_banks'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
          });

      if (response.body.isNotEmpty) {
        print(response.body);
        // json.decode(response.body);
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');
        print(response.statusCode);
        print(data);
        if (response.statusCode == 200) {
          print('Yess.....');
          print(data['message']);
          return data['message'];
        } else {
          return 'Error getting bank names';
        }
      } else {
        debugPrint('empty results');
        return 'An unkown error occurred';
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Server busy try again later';
    }
  }

  static Future addBankAccount(
    bankName,
    accountName,
    accountNumber,
    phoneNumber,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('userEmail');
    String? password = prefs.getString('password');

    var token = await loginForToken('kevinmwangi7881@gmail.com', '@Kevin7881');
    print('Logged In For TOken before sending bank details');

    print(token);
    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://healthcare-financing.diaspocare.com/api/method/hcfa_core.remote_procedures.vendors.create_bank_account'),
          body: jsonEncode(
            {
              "bank": bankName,
              "account_holder_name": accountName,
              "account_number": accountNumber,
              "pesalink_phonenumber": phoneNumber,
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            'Authorization': "Basic $token",
          });

      debugPrint(
          'Response bodyyyyyyyyyyyyyyyy from Sending Bank Details to APIs');
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());

      if (response.body.isNotEmpty) {
        json.decode(response.body);
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');
        if (data.toString().contains('already exists')) {
          return 'Bank details already in use';
        }
        if (data.toString().contains('Account number is invalid')) {
          return 'Account number is invalid';
        }

        if (!data.toString().contains('server_messages') &&
            response.statusCode == 200) {
          return 'Bank details succesfully updated';
        }
      } else {
        debugPrint('empty results');
        return 'An unkown error occurred';
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Server busy try again later';
    }
  }
}
