import 'package:diasporacare/screens/auth/complete_profile/complete_profile.dart';
import 'package:diasporacare/screens/auth/sign_in/sign_in.dart';
import 'package:diasporacare/screens/auth/sign_up/cubit/country_switcher_cubit.dart';
import 'package:diasporacare/screens/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:diasporacare/constants.dart';
import 'package:diasporacare/services/misc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hideTopBanner = false;
  bool keyboardVisible = false;
  bool emailhasIssue = false;
  bool phonehasIssue = false;
  bool passwordHasIssue = false;
  bool showPassword = true;
  bool emailIsValid = true;
  bool phoneIsValid = true;
  bool checkBoxValue = false;
  bool appIsLoading = false;
  var selectedCountry = 'Kenya';

  void showSnackBar(BuildContext context, message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      duration: const Duration(seconds: 10),
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 15.0),
            child: Text(
              message,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'JosefinSans',
                  fontSize: 13),
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Container(
              height: 35,
              width: 80,
              color: const Color(0xFF181717),
              child: const Center(
                child: Text(
                  'Okay',
                  style: TextStyle(
                      fontFamily: 'JosefinSans',
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 13),
                ),
              ),
            ),
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

  void showSnackBarWithoutButton(BuildContext context, message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
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

  clearSelectedCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('countryCode', "ke");
  }

  @override
  void initState() {
    super.initState();
    clearSelectedCountry();
  }

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            // height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                BlocBuilder<SignUpCubit, SignUpState>(
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
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Welcome to DiaspoCare',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Join our DiaspoCare Care Provider Network to be part of a movement to provide a quality affordable healthcare in Africa',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
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
                        'Owner Details',
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
                            'Email Address',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          emailhasIssue
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
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  suffixText:
                                      emailIsValid ? '' : 'Invalid email',
                                  suffixStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  fillColor: Colors.transparent,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Colors.black12, width: 0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: emailhasIssue
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
                                  if (emailController.text.isNotEmpty) {
                                    setState(() {
                                      emailhasIssue = false;
                                    });
                                  }

                                  if (Misc.validateEmail(
                                          emailController.text) !=
                                      null) {
                                    setState(() {
                                      emailIsValid = false;
                                    });
                                  } else {
                                    setState(() {
                                      emailIsValid = true;
                                    });
                                  }
                                },
                                controller: emailController,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Phone Number',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      phonehasIssue
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
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
                              Container(
                                height: 49,
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: phonehasIssue
                                        ? Colors.red
                                        : secondaryColor,
                                    width: 1.6,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.white,
                                            context: context,
                                            builder: (builder) {
                                              return SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    CountrySwitcherCubit>()
                                                                .swithCountries(
                                                                    'Kenya');
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.04,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.1,
                                                                child: SvgPicture.asset(
                                                                    'assets/icons/kenya.svg',
                                                                    fit: BoxFit
                                                                        .contain),
                                                              ),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            8.0),
                                                                child: Text(
                                                                  'Kenya',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Transform.translate(
                                                          offset: const Offset(
                                                              0.0, -3.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              context
                                                                  .read<
                                                                      CountrySwitcherCubit>()
                                                                  .swithCountries(
                                                                      'Nigeria');
                                                              Navigator.pop(
                                                                  context);
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
                                                                      fit: BoxFit
                                                                          .contain),
                                                                ),
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 0.0),
                                                                  child: Text(
                                                                    'Nigeria',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    CountrySwitcherCubit>()
                                                                .swithCountries(
                                                                    'Ghana');
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.04,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.1,
                                                                child: SvgPicture.asset(
                                                                    'assets/icons/ghana.svg',
                                                                    fit: BoxFit
                                                                        .contain),
                                                              ),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            8.0),
                                                                child: Text(
                                                                  'Ghana',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
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
                                      child: Row(
                                        children: [
                                          BlocBuilder<CountrySwitcherCubit,
                                              CountrySwitcherState>(
                                            builder: (context, state) {
                                              return state.when(initial: () {
                                                return Row(
                                                  children: [
                                                    Transform.translate(
                                                      offset: const Offset(
                                                          10.0, 0.0),
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.025,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/kenya.svg',
                                                            fit:
                                                                BoxFit.contain),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.009,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/arrow_down.svg',
                                                            fit:
                                                                BoxFit.contain),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "+254",
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                );
                                              }, loading: () {
                                                return Container();
                                              }, loaded: (String country,
                                                  String countrycode) {
                                                return Row(
                                                  children: [
                                                    Transform.translate(
                                                      offset: const Offset(
                                                          10.0, 0.0),
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.025,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/$country.svg',
                                                            fit:
                                                                BoxFit.contain),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.009,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/arrow_down.svg',
                                                            fit:
                                                                BoxFit.contain),
                                                      ),
                                                    ),
                                                    Text(
                                                      countrycode,
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                );
                                              }, error: (message) {
                                                return Container();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                        keyboardType: TextInputType.phone,
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ''),
                                        onChanged: (value) {
                                          if (phoneController.text.isNotEmpty) {
                                            setState(() {
                                              phonehasIssue = false;
                                            });
                                          }

                                          if (Misc.validateMobile(
                                                  emailController.text) !=
                                              null) {
                                            setState(() {
                                              phoneIsValid = false;
                                            });
                                          } else {
                                            setState(() {
                                              phoneIsValid = true;
                                            });
                                          }
                                        },
                                        controller: phoneController,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Password',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      passwordHasIssue
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
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
                                obscureText: showPassword,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                    child: !showPassword
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: Colors.grey,
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                  ),
                                  fillColor: Colors.transparent,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: Colors.black12, width: 0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: passwordHasIssue
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
                                  hintText: '',
                                  hintStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                onChanged: (value) {
                                  if (passwordController.text.isNotEmpty) {
                                    setState(() {
                                      passwordHasIssue = false;
                                    });
                                  }
                                },
                                controller: passwordController,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Transform.translate(
                                    offset: const Offset(-10.0, 0.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                                value: checkBoxValue,
                                                activeColor: primaryColor,
                                                onChanged: (bool? newValue) {
                                                  setState(() {
                                                    checkBoxValue = newValue!;
                                                  });
                                                }),
                                            const Text(
                                              'I have read and do understand the terms of',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Transform.translate(
                                          offset: const Offset(0.0, -10.0),
                                          child: Row(
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 49.0),
                                                child: Text(
                                                  'use and privacy policy',
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (phoneController.text.isEmpty) {
                                    setState(() {
                                      phonehasIssue = true;
                                    });
                                  } else {
                                    setState(() {
                                      phonehasIssue = false;
                                    });
                                  }

                                  if (emailController.text.isEmpty) {
                                    setState(() {
                                      emailhasIssue = true;
                                    });
                                  } else {
                                    setState(() {
                                      emailhasIssue = false;
                                    });
                                  }

                                  if (passwordController.text.isEmpty) {
                                    setState(() {
                                      passwordHasIssue = true;
                                    });
                                  } else {
                                    setState(() {
                                      passwordHasIssue = false;
                                    });
                                  }

                                  if (!phonehasIssue &&
                                      !emailhasIssue &&
                                      !passwordHasIssue) {
                                    if (checkBoxValue == false) {
                                      showSnackBar(
                                          context, 'Accept privacy policy');
                                    } else {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      String? countryCode =
                                          prefs.getString('countryCode');

                                      debugPrint('CountryCoooooooooooooode');
                                      debugPrint(countryCode);

                                      // ignore: use_build_context_synchronously
                                      context.read<SignUpCubit>().signUp(
                                          emailController.text.trim(),
                                          countryCode!,
                                          phoneController.text.trim(),
                                          passwordController.text.trim());
                                    }
                                  }
                                },
                                child: BlocConsumer<SignUpCubit, SignUpState>(
                                  listener: (context, state) {
                                    state.when(
                                        initial: () {},
                                        loading: () {},
                                        loaded: (result) {
                                          if (result ==
                                              'Your Account has been created') {
                                            showSnackBarWithoutButton(
                                                context, result);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CompleteProfile()));
                                          } else {
                                            showSnackBarWithoutButton(
                                                context, result);
                                          }
                                        },
                                        error: (failureMessage) {
                                          showSnackBarWithoutButton(
                                              context, failureMessage);
                                        });
                                  },
                                  builder: (context, state) {
                                    return state.when(initial: () {
                                      return Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Create Account',
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
                                            MediaQuery.of(context).size.width -
                                                40,
                                        decoration: BoxDecoration(
                                          color: loadingButtonColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Creating..',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      );
                                    }, loaded: (result) {
                                      return Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Create Account',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      );
                                    }, error: (failureMessage) {
                                      return Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Create Account',
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignIn()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Already have an account ?',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
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
      ),
    ));
  }
}
