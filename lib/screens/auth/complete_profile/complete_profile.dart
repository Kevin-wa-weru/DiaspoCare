import 'package:diasporacare/screens/auth/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:diasporacare/screens/auth/otp/verify_otp.dart';
import 'package:diasporacare/screens/auth/sign_up/cubit/country_switcher_cubit.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:flutter/material.dart';
import 'package:diasporacare/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({
    Key? key,
  }) : super(key: key);

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
  bool areaOfPracticeHasIssue = false;
  bool checkBoxValue = false;
  String? selectedCountry;
  int maxLine = 4;
  // List<String> selectedAreaOfPractice = [];
  late String token = '';
  late String email = '';

  String selectedText = "";

  clearSelectedCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('countryCode', "");
  }

  void showSnackBarWithoutButton(BuildContext context, message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
                fontFamily: 'JosefinSans',
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13),
          ),
        ],
      ),
      // backgroundColor: const Color(0xFF070606),
      behavior: SnackBarBehavior.floating,
      elevation: 2,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 5,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  loginForToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    String? password = prefs.getString('password');
    var result = await DiaspoCareAPis.loginForToken(userEmail, password);
    setState(() {
      token = result;
      email = userEmail!;
    });
  }

  @override
  void initState() {
    super.initState();
    clearSelectedCountry();
    loginForToken();
  }

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [
            BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
              builder: (context, state) {
                return state.when(initial: () {
                  return Container(
                    height: 4,
                  );
                }, loading: () {
                  return const LinearProgressIndicator();
                }, loaded: (message) {
                  return Container(
                    height: 4,
                  );
                }, error: (message) {
                  return Container(
                    height: 4,
                  );
                });
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Transform.translate(
              offset: const Offset(0.0, 0.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      height: 50,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ],
              ),
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
                              if (practitionerNameController.text.isNotEmpty) {
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
                              if (regulatorLicenceController.text.isNotEmpty) {
                                setState(() {
                                  regulatorLicenceIssue = false;
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
                              // showCountryPicker(
                              //   context: context,
                              //   showPhoneCode:
                              //       false, // optional. Shows phone code before the country name.
                              //   onSelect: (Country country) {
                              //     setState(() {
                              //       selectedCountry =
                              //           country.displayNameNoCountryCode;

                              //       if (selectedCountry != null) {
                              //         setState(() {
                              //           countryHasIssue = false;
                              //         });
                              //       }
                              //     });
                              //   },
                              // );
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (builder) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    countryHasIssue = false;
                                                  });
                                                  context
                                                      .read<
                                                          CountrySwitcherCubit>()
                                                      .swithCountries('Kenya');
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                      child: SvgPicture.asset(
                                                          'assets/icons/kenya.svg',
                                                          fit: BoxFit.contain),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text(
                                                        'Kenya',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    countryHasIssue = false;
                                                  });
                                                  context
                                                      .read<
                                                          CountrySwitcherCubit>()
                                                      .swithCountries('Uganda');
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                      child: SvgPicture.asset(
                                                          'assets/icons/uganda.svg',
                                                          fit: BoxFit.contain),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text(
                                                        'Uganda',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Transform.translate(
                                                offset: const Offset(0.0, -3.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      countryHasIssue = false;
                                                    });
                                                    context
                                                        .read<
                                                            CountrySwitcherCubit>()
                                                        .swithCountries(
                                                            'Nigeria');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/nigeria.svg',
                                                            fit:
                                                                BoxFit.contain),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0.0),
                                                        child: Text(
                                                          'Nigeria',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    countryHasIssue = false;
                                                  });
                                                  context
                                                      .read<
                                                          CountrySwitcherCubit>()
                                                      .swithCountries('Ghana');
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                      child: SvgPicture.asset(
                                                          'assets/icons/ghana.svg',
                                                          fit: BoxFit.contain),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text(
                                                        'Ghana',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 40,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: countryHasIssue
                                      ? Colors.red
                                      : secondaryColor,
                                  width: 1.6,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<CountrySwitcherCubit,
                                      CountrySwitcherState>(
                                    builder: (context, state) {
                                      return state.when(initial: () {
                                        return Container();
                                      }, loading: () {
                                        return Container();
                                      }, loaded: (country, code) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            country,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        );
                                      }, error: (message) {
                                        return Container();
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      child: SvgPicture.asset(
                                          'assets/icons/dropdown.svg',
                                          color: Colors.black,
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          InkWell(
                            onTap: () async {
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
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                String? countryCode =
                                    prefs.getString('countryCode');

                                if (countryCode == "") {
                                  setState(() {
                                    countryHasIssue = true;
                                  });
                                } else {}
                              }

                              if (!facilityNamehasIssue &&
                                  !practitionerNamehasIssue &&
                                  !regulatorLicenceIssue &&
                                  !countryHasIssue) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                String? countryCode =
                                    prefs.getString('countryCode');

                                // ignore: use_build_context_synchronously
                                context
                                    .read<CompleteProfileCubit>()
                                    .completeProfile(
                                      // email.trim(),
                                      facilityNameController.text,
                                      practitionerNameController.text,
                                      regulatorLicenceController.text,
                                      countryCode,
                                      token,
                                    );
                              }
                            },
                            child: BlocConsumer<CompleteProfileCubit,
                                CompleteProfileState>(
                              listener: (context, state) {
                                state.when(
                                    initial: () {},
                                    loading: () {},
                                    loaded: (result) {
                                      if (result ==
                                          'Profile has been updated') {
                                        showSnackBarWithoutButton(
                                            context, result);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const VerifyOtp()));
                                      } else {
                                        showSnackBarWithoutButton(
                                            context, result);
                                      }
                                    },
                                    error: (message) {});
                              },
                              builder: (context, state) {
                                return state.when(initial: () {
                                  return Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
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
                                  );
                                }, loading: () {
                                  return Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    decoration: BoxDecoration(
                                      color: loadingButtonColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Updating profile..',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  );
                                }, loaded: (message) {
                                  return Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
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
                                  );
                                }, error: (message) {
                                  return Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
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
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 5,
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
      ],
    ));
  }
}

class Animal {
  final String name;
  final int id;

  Animal({required this.name, required this.id});
}

class _ViewItem extends StatelessWidget {
  String item;
  bool itemSelected;
  final Function(String) selected;

  _ViewItem(
      {required this.item, required this.itemSelected, required this.selected});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * .032, right: size.width * .098),
      child: Row(
        children: [
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: itemSelected,
              onChanged: (val) {
                selected(item);
              },
              activeColor: Colors.grey,
            ),
          ),
          SizedBox(
            width: size.width * .025,
          ),
          Text(
            item,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }
}
