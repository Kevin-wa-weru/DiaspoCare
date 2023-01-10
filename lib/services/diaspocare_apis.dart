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

  static Future signUp(email, regionCode, phone, password) async {
    try {
      print('Credentails sent to server');
      print(email);
      print(regionCode);
      print(phone);
      print(password);
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
}
