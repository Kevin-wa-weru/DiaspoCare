import 'package:diasporacare/constants.dart';
import 'package:diasporacare/screens/auth/complete_profile/cubit/assign_tag_cubit.dart';
import 'package:diasporacare/screens/auth/location/update_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiselect/multiselect.dart';

class AreaOfSpecialty extends StatefulWidget {
  const AreaOfSpecialty({super.key});

  @override
  State<AreaOfSpecialty> createState() => _AreaOfSpecialtyState();
}

class _AreaOfSpecialtyState extends State<AreaOfSpecialty> {
  bool areaOfPracticeHasIssue = false;
  List<String> selectedAreaOfPractice = [];

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

  @override
  void initState() {
    // loginForToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BlocBuilder<AssignTagCubit, AssignTagState>(
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
          Column(
            children: [
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
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      'Help us understand your area\'s ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const Center(
                child: Text(
                  'of practice',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Area of Practice',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      areaOfPracticeHasIssue
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
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Select All applicable',
                      style: TextStyle(
                          color: Color(0x99BC343E),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: DropDownMultiSelect(
                  onChanged: (List<String> x) {
                    setState(() {
                      selectedAreaOfPractice = x;
                    });

                    if (selectedAreaOfPractice.isNotEmpty) {
                      setState(() {
                        areaOfPracticeHasIssue = false;
                      });
                    }
                  },
                  options: const [
                    'Pharmacy',
                    'Dentist',
                    'Clinic',
                    '24/7 service'
                  ],
                  icon: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.09,
                    child: SvgPicture.asset('assets/icons/dropdown.svg',
                        color: Colors.black, fit: BoxFit.contain),
                  ),
                  selectedValues: selectedAreaOfPractice,
                  whenEmpty: '',
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Colors.black12, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: areaOfPracticeHasIssue
                              ? Colors.red
                              : secondaryColor,
                          width: 1.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: secondaryColor, width: 1.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              InkWell(
                onTap: () {
                  if (selectedAreaOfPractice.isEmpty) {
                    setState(() {
                      areaOfPracticeHasIssue = true;
                    });
                  } else {
                    setState(() {
                      areaOfPracticeHasIssue = false;
                    });

                    context.read<AssignTagCubit>().assignTag(
                          selectedAreaOfPractice,
                        );
                  }
                },
                child: BlocConsumer<AssignTagCubit, AssignTagState>(
                  listener: (context, state) {
                    state.when(
                        initial: () {},
                        loading: () {},
                        loaded: (result) {
                          if (result == 'Area of practice saved') {
                            showSnackBarWithoutButton(context, result);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UpdateLocation()));
                          } else {
                            showSnackBarWithoutButton(context, result);
                          }
                        },
                        error: (message) {});
                  },
                  builder: (context, state) {
                    return state.when(initial: () {
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                          child: Text(
                            'Save Area of Practice',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      );
                    }, loading: () {
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: loadingButtonColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                          child: Text(
                            'Saving Area\'s of Practice ...',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      );
                    }, loaded: (mesage) {
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                          child: Text(
                            'Save Area of Practice',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      );
                    }, error: (message) {
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                          child: Text(
                            'Save Area of Practice',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
