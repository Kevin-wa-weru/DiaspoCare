import 'package:diasporacare/screens/auth/complete_profile/profile_completed.dart';
import 'package:diasporacare/screens/auth/location/cubit/update_location_cubit.dart';
import 'package:diasporacare/screens/auth/location/pick_region.dart';
import 'package:diasporacare/screens/auth/location/pick_towns.dart';
import 'package:flutter/material.dart';
import 'package:diasporacare/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({Key? key}) : super(key: key);

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  final regionController = TextEditingController();
  final townController = TextEditingController();
  final addressController = TextEditingController();
  bool hideTopBanner = false;
  bool keyboardVisible = false;
  bool regionhasIssue = false;
  bool townhasIssue = false;
  bool addressHasIssue = false;
  String? regionName = '';
  String? townName = '';

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> navigateAndDisplaySelection(
      BuildContext context, selectedRegion) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PickRegion(
                selectedRegion: selectedRegion,
              )),
    );
    setState(() {
      if (result == null) {
      } else {
        regionName = result;
      }

      if (result != '') {
        regionhasIssue = false;
      }
    });
  }

  Future<void> navigateAndDisplaySelection2(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PickTown(
                stateName: regionName!,
              )),
    );
    setState(() {
      if (result == null) {
      } else {
        townName = result;
      }

      if (result != '') {
        townhasIssue = false;
      }
    });
  }

  void showSnackBar(BuildContext context, message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

  clearSelectedCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('countryCode', "ke");
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
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
                BlocBuilder<UpdateLocationCubit, UpdateLocationState>(
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
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Update your Location so that we can ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'list you on our partner network',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            'Region',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          regionhasIssue
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '*',
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
                              InkWell(
                                onTap: () {
                                  navigateAndDisplaySelection(
                                      context, regionName);
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: regionhasIssue
                                          ? Colors.red
                                          : secondaryColor,
                                      width: 1.6,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          regionName!,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
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
                                        'Town',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      townhasIssue
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                '*',
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
                                  if (regionName!.isEmpty) {
                                    showSnackBarWithoutButton(
                                        context, 'Pick your region first');
                                  } else {
                                    navigateAndDisplaySelection2(context);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: townhasIssue
                                          ? Colors.red
                                          : secondaryColor,
                                      width: 1.6,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          townName!,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
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
                                        'Descriptive Address (eg Near Landmark A)',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      addressHasIssue
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                '*',
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
                                        color: addressHasIssue
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
                                    vertical: 40,
                                  ),
                                  isDense: true, // Added this

                                  filled: true,
                                  hintText: '',
                                  hintStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                onChanged: (value) {
                                  if (addressController.text.isNotEmpty) {
                                    setState(() {
                                      addressHasIssue = false;
                                    });
                                  }
                                },
                                controller: addressController,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              BlocConsumer<UpdateLocationCubit,
                                  UpdateLocationState>(
                                listener: (context, state) {
                                  state.when(
                                      initial: () {},
                                      loading: () {},
                                      loaded: (result) {
                                        if (result ==
                                            'Successfully updated location') {
                                          showSnackBarWithoutButton(
                                              context, result);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProfileComplete()));
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
                                    return InkWell(
                                        onTap: () async {
                                          if (regionName!.isEmpty) {
                                            setState(() {
                                              regionhasIssue = true;
                                            });
                                          } else {
                                            setState(() {
                                              regionhasIssue = false;
                                            });
                                          }

                                          if (townName!.isEmpty) {
                                            setState(() {
                                              townhasIssue = true;
                                            });
                                          } else {
                                            setState(() {
                                              townhasIssue = false;
                                            });
                                          }

                                          if (addressController.text.isEmpty) {
                                            setState(() {
                                              addressHasIssue = true;
                                            });
                                          } else {
                                            setState(() {
                                              addressHasIssue = false;
                                            });
                                          }

                                          if (!regionhasIssue &&
                                              !townhasIssue &&
                                              !addressHasIssue) {
                                            context
                                                .read<UpdateLocationCubit>()
                                                .updateLocation(
                                                  townName!,
                                                  regionName!,
                                                  addressController.text,
                                                  _currentPosition?.longitude,
                                                  _currentPosition?.longitude,
                                                );
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          decoration: BoxDecoration(
                                            // color: const Color(0xFF145DA0),
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Save Location Details',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ));
                                  }, loading: () {
                                    return Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      decoration: BoxDecoration(
                                        // color: const Color(0xFF145DA0),
                                        color: loadingButtonColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Saving Location Details...',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    );
                                  }, loaded: (result) {
                                    return InkWell(
                                        onTap: () async {
                                          if (regionName!.isEmpty) {
                                            setState(() {
                                              regionhasIssue = true;
                                            });
                                          } else {
                                            setState(() {
                                              regionhasIssue = false;
                                            });
                                          }

                                          if (townName!.isEmpty) {
                                            setState(() {
                                              townhasIssue = true;
                                            });
                                          } else {
                                            setState(() {
                                              townhasIssue = false;
                                            });
                                          }

                                          if (addressController.text.isEmpty) {
                                            setState(() {
                                              addressHasIssue = true;
                                            });
                                          } else {
                                            setState(() {
                                              addressHasIssue = false;
                                            });
                                          }

                                          if (!regionhasIssue &&
                                              !townhasIssue &&
                                              !addressHasIssue) {
                                            context
                                                .read<UpdateLocationCubit>()
                                                .updateLocation(
                                                  townName!,
                                                  regionName!,
                                                  addressController.text,
                                                  _currentPosition?.longitude,
                                                  _currentPosition?.longitude,
                                                );
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          decoration: BoxDecoration(
                                            // color: const Color(0xFF145DA0),
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Save Location Details',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ));
                                  }, error: (failureMessage) {
                                    return InkWell(
                                        onTap: () async {
                                          if (regionName!.isEmpty) {
                                            setState(() {
                                              regionhasIssue = true;
                                            });
                                          } else {
                                            setState(() {
                                              regionhasIssue = false;
                                            });
                                          }

                                          if (townName!.isEmpty) {
                                            setState(() {
                                              townhasIssue = true;
                                            });
                                          } else {
                                            setState(() {
                                              townhasIssue = false;
                                            });
                                          }

                                          if (addressController.text.isEmpty) {
                                            setState(() {
                                              addressHasIssue = true;
                                            });
                                          } else {
                                            setState(() {
                                              addressHasIssue = false;
                                            });
                                          }

                                          if (!regionhasIssue &&
                                              !townhasIssue &&
                                              !addressHasIssue) {
                                            context
                                                .read<UpdateLocationCubit>()
                                                .updateLocation(
                                                  townName!,
                                                  regionName!,
                                                  addressController.text,
                                                  _currentPosition?.longitude,
                                                  _currentPosition?.longitude,
                                                );
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          decoration: BoxDecoration(
                                            // color: const Color(0xFF145DA0),
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Save Location Details',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ));
                                  });
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
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
