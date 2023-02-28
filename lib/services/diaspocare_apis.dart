import 'dart:convert';
import 'dart:io';
import 'package:diasporacare/services/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaspoCareAPis {
  static String baseUrl = 'https://healthcare-financing.diaspocare.com';
  static String stagingUrl = 'https://staging.diaspocare.com';

  static Future login(email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('facilityName', '');
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.users.login'),
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
          prefs.setString('userToken', data['token']);
          prefs.setString('userEmail', email.trim());
          prefs.setString('vendorName', data['full_name']);

          if (data['vendor'].isEmpty) {
            prefs.setString('facilityName', '');
          } else {
            prefs.setString('facilityName', data['vendor'][0]['name']);
          }

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
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.users.login'),
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
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.users.create_diaspocare_account_v2'),
          body: jsonEncode(
            {
              "email": email,
              "region_code": regionCode,
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
        } else if (data.toString().contains('Invalid phone number')) {
          return 'Invalid phone number';
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
      http.Response response =
          await http.post(Uri.parse('$baseUrl/api/resource/Vendor'),
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
        if (response.statusCode == 200) {
          return 'Profile has been updated';
        } else {
          if (data.toString().contains('Could not find user')) {
            return 'Could not find user';
          } else if (data.toString().contains('already exists')) {
            return 'Profile for $facilityName already exists';
          } else if (data.toString().contains('Duplicate Name')) {
            return 'Practioner name already in use';
          } else {
            return 'Unidentified exception';
          }
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

  static Future assignTagToVendor(
      String facilityName, List<String> tags, token) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.assign_tags_to_vendor'),
          body: jsonEncode(
            {
              "vendor": facilityName,
              "tags": tags,
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
        debugPrint('hResponseBody Decoded');
        if (response.statusCode == 200) {
          return 'Area of practice saved';
        } else {
          return 'Error saving practice';
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
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.users.generate_phonenumber_verification_OTP'),
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
              '$baseUrl/api/method/hcfa_core.remote_procedures.users.verify_phonenumber'),
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
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.get_banks'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
          });

      if (response.body.isNotEmpty) {
        // json.decode(response.body);
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');
        if (response.statusCode == 200) {
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
    token,
    bankName,
    accountName,
    accountNumber,
    phoneNumber,
  ) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.create_bank_account'),
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

  static Future getRegions(countryName) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.beneficiaries.get_provinces?country=$countryName'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');

        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error getting region names';
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

  static Future getTown(stateName) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.beneficiaries.get_districts?province=$stateName'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');

        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error getting region names';
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

  static Future getVendorTransactions(
      String statusType, int page, String token) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.get_vendor_transactions?status=$statusType&page=$page'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            'Authorization': "Basic $token",
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');

        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error getting transcations';
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

  static Future getAccountDetails(String email, String token) async {
    try {
      http.Response response = await http
          .get(Uri.parse('$baseUrl/api/resource/User/$email'), headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": "Basic $token",
      });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');

        if (response.statusCode == 200) {
          return data['data'];
        } else {
          return 'Error getting account details';
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

  static Future getBankDetails(String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.get_bank_account'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            'Authorization': "Basic $token",
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');

        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error getting bank details';
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

  static Future getFacilityDetails(String vendorName) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$baseUrl/api/resource/Vendor?Vendor%20Name=$vendorName'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');

        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error getting bank details';
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

  static Future getDiscounts(token) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.discount_offerings'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            'Authorization': "Basic $token",
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');

        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error getting discounts';
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

  static Future getBestSellingItems(token, String facilityName) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.get_best_selling_items?branch=$facilityName'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            'Authorization': "Basic $token",
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        debugPrint('hResponseBody Decoded');

        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error getting best selling items';
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

  static Future addDiscount(String discountName, int percentage, token) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.create_discount_offering'),
          body: jsonEncode(
            {
              "name": discountName,
              "percentage": percentage,
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token",
          });

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          return 'Discount added successfully';
        } else {
          return 'Error adding discount';
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

  static Future editDiscount(String discountName, int percentage,
      String discountid, String token) async {
    try {
      http.Response response = await http.put(
          Uri.parse(
              '$baseUrl/api/resource/Vendor%20Discount/${discountid.trim()}'),
          body: jsonEncode(
            {
              "name1": discountName,
              "percentage": percentage,
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          return 'Discount edited successfully';
        } else {
          return 'Error adding discount';
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

  static Future searchBeneficiary(String beneficiaryName, String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.beneficiaries.check_beneficiary_exists?beneficiary_name=$beneficiaryName'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error getting beneficiary';
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

  static Future addBasket(String beneficiaryid, String token) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendor_transactions.add_basket'),
          body: jsonEncode(
            {"beneficiary": beneficiaryid},
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error adding basket';
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

  static Future addBasketItem(
      String basketId,
      String item,
      int percentageDiscount,
      int price,
      int quantity,
      int isService,
      String token) async {
    try {
      http.Response response =
          await http.post(Uri.parse('$baseUrl/api/resource/Order Basket Item'),
              body: jsonEncode(
                {
                  "basket": basketId,
                  "item": item,
                  "percentage_discount": percentageDiscount,
                  "price": price,
                  "quantity": quantity,
                  "is_service": isService,
                },
              ),
              headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          return 'Item added successfully';
        } else {
          return 'Error adding items';
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

  static Future getBasketItems(String basketId, String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendor_transactions.get_basket_items?basket=${basketId.trim()}'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error getting basket items';
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

  static Future generateTransactionOtp(
    String basketId,
  ) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.generate_OTP'),
          body: jsonEncode(
            {
              "basket": basketId,
            },
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            // "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
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

  static Future verifyTransactionOtp(
      String basketId, String otpCode, String token) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.verify_OTP'),
          body: jsonEncode({"basket": basketId, "otp": otpCode}),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          return data['message'];
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

  static Future initialiseTransaction(
    String basketId,
    String code,
    String token,
  ) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.initialise_transaction'),
          body: jsonEncode({"basket": basketId, "secure_code": code}),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
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

  static Future checkIfVeried(String facilityName) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.vendor_is_verified?vendor=$facilityName'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            // "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          if (data['message'] == true) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
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

  static Future searchMasterList(String query, String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.search_drug_master_list?query=$query&is_service=0'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error searching drugs';
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

  static Future testMedifinder(String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              'https://staging.diaspocare.com/api/method/hcfa_core.remote_procedures.medifinder.search.search_master_list?query=calp&is_service=0&country=Kenya'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return 'Error searching drugs';
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

  static Future editBasketItems(String token, String basketItemId,
      String itemName, int price, int quantity) async {
    try {
      http.Response response = await http.put(
          Uri.parse('$baseUrl/api/resource/Order Basket Item/$basketItemId'),
          body: jsonEncode({"item": itemName, "price": price, "quantity": 1}),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          return 'Successfully Edited basket item';
        } else {
          return 'Error editing basket item';
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

  static Future updateLocation(
      String token, String district, String region, String description) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.add_location'),
          body: jsonEncode({
            "district": district,
            "region": region,
            "description": description,
            "lon": null,
            "latitude": null
          }),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          return 'Successfully updated location';
        } else {
          return 'Error updating location';
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

  static Future checkBankAccount(String facilityName) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.vendor_has_bankaccount?vendor=$facilityName'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            // "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          if (data['message'] == true) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
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

  static Future getDashboardStats(String facilityName, String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$baseUrl/api/method/hcfa_core.remote_procedures.vendors.get_stats?branch=$facilityName'),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": "Basic $token"
          });

      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          return data['message'];
        } else {
          return false;
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

  static Future<String> getCountry() async {
    Network n = Network("http://ip-api.com/json");
    var locationSTR = (await n.getData());
    var locationx = jsonDecode(locationSTR);

    List<Country> country = countryList
        .where((element) => element.name == locationx["country"])
        .toList();

    String countryName = locationx["country"];
    String currency = country.first.currency;

    return currency;
  }
}
