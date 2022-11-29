import 'package:country_picker/country_picker.dart';
import 'package:diasporacare/screens/auth/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:diasporacare/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final practitionerNameController = TextEditingController();
  final regulatorLicenceController = TextEditingController();
  final facilityNameController = TextEditingController();
  final passwordController = TextEditingController();
  final areaofPracticeController = TextEditingController();
  bool hideTopBanner = false;
  bool keyboardVisible = false;
  bool facilityNamehasIssue = false;
  bool practitionerNamehasIssue = false;
  bool regulatorLicenceIssue = false;
  bool showPassword = true;
  bool emailIsValid = true;
  bool phoneIsValid = true;
  bool countryHasIssue = false;
  bool checkBoxValue = false;
  String? selectedCountry;
  int maxLine = 4;

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: SvgPicture.asset('assets/images/logo.svg',
                          fit: BoxFit.contain),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Account Created',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Please complete the facility\ndetails below',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          'Facility Name',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'AvenirNext',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                        facilityNamehasIssue
                            ? const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'required',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Container(
                        color: Colors.transparent,
                        //.red
                        width: MediaQuery.of(context).size.width - 40,
                        child: Column(
                          children: [
                            TextFormField(
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'AvenirNext',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: facilityNamehasIssue
                                          ? Colors.red
                                          : secondaryColor,
                                      width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: secondaryColor, width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                filled: true,
                              ),
                              onChanged: (value) {
                                if (facilityNameController.text.isNotEmpty) {
                                  setState(() {
                                    facilityNamehasIssue = false;
                                  });
                                }
                              },
                              controller: facilityNameController,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Practitioner Name',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'AvenirNext',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    practitionerNamehasIssue
                                        ? const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'required',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: practitionerNamehasIssue
                                          ? Colors.red
                                          : secondaryColor,
                                      width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: secondaryColor, width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                filled: true,
                              ),
                              onChanged: (value) {
                                if (practitionerNameController
                                    .text.isNotEmpty) {
                                  setState(() {
                                    practitionerNamehasIssue = false;
                                  });
                                }
                              },
                              controller: practitionerNameController,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Regulator Licence No.',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'AvenirNext',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    regulatorLicenceIssue
                                        ? const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'required',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: regulatorLicenceIssue
                                          ? Colors.red
                                          : secondaryColor,
                                      width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: secondaryColor, width: 1.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                filled: true,
                              ),
                              onChanged: (value) {
                                if (practitionerNameController
                                    .text.isNotEmpty) {
                                  setState(() {
                                    practitionerNamehasIssue = false;
                                  });
                                }
                              },
                              controller: regulatorLicenceController,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Country',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'AvenirNext',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    countryHasIssue
                                        ? const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'required',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode:
                                      false, // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    setState(() {
                                      selectedCountry =
                                          country.displayNameNoCountryCode;
                                    });
                                  },
                                );
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: secondaryColor,
                                    width: 1.6,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    selectedCountry == null
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              selectedCountry!,
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'AvenirNext',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      child: SvgPicture.asset(
                                          'assets/icons/dropdown.svg',
                                          color: Colors.black,
                                          fit: BoxFit.contain),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Area of Practice',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'AvenirNext',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    regulatorLicenceIssue
                                        ? const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'required',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Text(
                                  'Select All applicable',
                                  style: TextStyle(
                                      color: Color(0xFFBC343E),
                                      fontFamily: 'AvenirNext',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 20,
                              height: maxLine * 20.0,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: TextFormField(
                                  maxLines: maxLine,
                                  style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent, width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: facilityNamehasIssue
                                              ? Colors.red
                                              : secondaryColor,
                                          width: 1.6),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: secondaryColor, width: 1.6),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.0197339,
                                      horizontal: 20,
                                    ),
                                    filled: true,
                                  ),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  controller: areaofPracticeController,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                if (facilityNameController.text.isEmpty) {
                                  setState(() {
                                    facilityNamehasIssue = true;
                                  });
                                } else {
                                  setState(() {
                                    facilityNamehasIssue = false;
                                  });
                                }

                                if (practitionerNameController.text.isEmpty) {
                                  setState(() {
                                    practitionerNamehasIssue = true;
                                  });
                                } else {
                                  setState(() {
                                    practitionerNamehasIssue = false;
                                  });
                                }

                                if (regulatorLicenceController.text.isEmpty) {
                                  setState(() {
                                    regulatorLicenceIssue = true;
                                  });
                                } else {
                                  setState(() {
                                    regulatorLicenceIssue = false;
                                  });
                                }

                                if (selectedCountry == null) {
                                  setState(() {
                                    countryHasIssue = true;
                                  });
                                }

                                if (!facilityNamehasIssue &&
                                    !practitionerNamehasIssue &&
                                    !regulatorLicenceIssue &&
                                    !countryHasIssue) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const VerifyOtp()));
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Complete Profile',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class Animal {
  final String name;
  final int id;

  Animal({required this.name, required this.id});
}
