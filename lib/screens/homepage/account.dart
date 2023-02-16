import 'package:diasporacare/models/user_detail_type.dart';
import 'package:diasporacare/screens/homepage/cubit/get_accout_details_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_bank_details_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_facility_details_cubit.dart';
import 'package:diasporacare/screens/widgets/loading_container_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    context.read<GetAccoutDetailsCubit>().getAccountDetails();
    context.read<GetBankDetailsCubit>().getBankDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int selected = 0;

    List<UserDetailType> userDetailTypes = [
      UserDetailType(
        userDetailType: 'User Details',
      ),
      UserDetailType(
        userDetailType: 'Facility Details',
      ),
      UserDetailType(
        userDetailType: 'Bank Details',
      ),
    ];

    Widget resolveWidetBody(String userDetailsType) {
      if (userDetailsType == 'User Details') {
        return BlocBuilder<GetAccoutDetailsCubit, GetAccoutDetailsState>(
          builder: (context, state) {
            return state.when(initial: () {
              return const UserDetailPanelLoading();
            }, loading: () {
              return const UserDetailPanelLoading();
            }, loaded: (accountDetails) {
              return UserDetailPanel(
                userDetails: accountDetails,
              );
            }, error: (error) {
              return Text(error);
            });
          },
        );
      }

      if (userDetailsType == 'Facility Details') {
        return BlocBuilder<GetFacilityDetailsCubit, GetFacilityDetailsState>(
          builder: (context, state) {
            return state.when(initial: () {
              return const DetailPanelLoading();
            }, loading: () {
              return const DetailPanelLoading();
            }, loaded: (accountDetails) {
              return const DetailPanelLoading();
              // return FacilityDetailPanel(
              //   facilityDetails: accountDetails,
              // );
            }, error: (error) {
              return Text(error);
            });
          },
        );
      }

      if (userDetailsType == 'Bank Details') {
        return BlocBuilder<GetBankDetailsCubit, GetBankDetailsState>(
          builder: (context, state) {
            return state.when(initial: () {
              return const DetailPanelLoading();
            }, loading: () {
              return const DetailPanelLoading();
            }, loaded: (accountDetails) {
              return BankDetailPanel(
                bankDetails: accountDetails,
              );
            }, error: (error) {
              return Text(error);
            });
          },
        );
      } else {
        return Container();
      }
    }

    Widget resolveAccountDetailHeader(String userDetailsType) {
      if (userDetailsType == 'User Details') {
        return BlocBuilder<GetAccoutDetailsCubit, GetAccoutDetailsState>(
          builder: (context, state) {
            return state.when(initial: () {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black12,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            }, loading: () {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black12,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            }, loaded: (accountDetails) {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            }, error: (error) {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black12,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            });
          },
        );
      }

      if (userDetailsType == 'Facility Details') {
        return BlocBuilder<GetFacilityDetailsCubit, GetFacilityDetailsState>(
          builder: (context, state) {
            return state.when(initial: () {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black12,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            }, loading: () {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black12,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            }, loaded: (accountDetails) {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            }, error: (error) {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black12,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            });
          },
        );
      }

      if (userDetailsType == 'Bank Details') {
        return BlocBuilder<GetBankDetailsCubit, GetBankDetailsState>(
          builder: (context, state) {
            return state.when(initial: () {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black12,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            }, loading: () {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black12,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            }, loaded: (accountDetails) {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            }, error: (error) {
              return Text(userDetailsType,
                  style: const TextStyle(
                    color: Colors.black12,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ));
            });
          },
        );
      } else {
        return Container();
      }
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color(0xFF145DA0),
          title: const Text(
            'Account Details',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
        ),
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(children: [
                ListView.builder(
                  key: Key('builder ${selected.toString()}'),
                  padding: const EdgeInsets.only(
                      left: 13.0, right: 13.0, bottom: 25.0),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: userDetailTypes.length,
                  itemBuilder: (context, index) {
                    return Column(children: <Widget>[
                      const Divider(
                        height: 5.0,
                        color: Colors.white,
                      ),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                            backgroundColor: Colors.transparent,
                            iconColor: const Color(0xFF145DA0),
                            collapsedIconColor: Colors.black,
                            key: Key(index.toString()),
                            initiallyExpanded: true,
                            // initiallyExpanded: index == selected,
                            title: resolveAccountDetailHeader(
                                userDetailTypes[index].userDetailType),
                            onExpansionChanged: ((newState) {
                              if (newState) {
                                setState(() {
                                  const Duration(milliseconds: 20000);
                                  selected = index;
                                });
                              } else {
                                setState(() {
                                  selected = -1;
                                });
                              }
                            }),
                            children: <Widget>[
                              resolveWidetBody(
                                  userDetailTypes[index].userDetailType),
                            ]),
                      ),
                    ]);
                  },
                )
              ]),
            )));
  }
}

class UserDetailPanel extends StatelessWidget {
  const UserDetailPanel({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  final Map<String, dynamic> userDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 25, bottom: 5),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'User',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      userDetails['full_name'],
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: const [
                      Text(
                        'Email Address',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      userDetails['email'],
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: const [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      userDetails['mobile_no'] ?? '0000000000',
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 0, left: 15),
          child: Row(
            children: [
              const Text('Update Password',
                  style: TextStyle(
                    color: Color(0xFF145DA0),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const Text('Logout',
                  style: TextStyle(
                    color: Color(0xFF145DA0),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        )
      ],
    );
  }
}

class UserDetailPanelLoading extends StatelessWidget {
  const UserDetailPanelLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 25, bottom: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    LoadingContainerAnimation(
                      targetContainer: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      LoadingContainerAnimation(
                        targetContainer: Container(
                          height: MediaQuery.of(context).size.width * 0.02,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      LoadingContainerAnimation(
                        targetContainer: Container(
                          height: MediaQuery.of(context).size.width * 0.02,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 0, left: 15),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.02,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.02,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DetailPanelLoading extends StatelessWidget {
  const DetailPanelLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 25, bottom: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    LoadingContainerAnimation(
                      targetContainer: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      LoadingContainerAnimation(
                        targetContainer: Container(
                          height: MediaQuery.of(context).size.width * 0.02,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      LoadingContainerAnimation(
                        targetContainer: Container(
                          height: MediaQuery.of(context).size.width * 0.02,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.02,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

class FacilityDetailPanel extends StatelessWidget {
  const FacilityDetailPanel({
    Key? key,
    required this.facilityDetails,
  }) : super(key: key);

  final Map<String, dynamic> facilityDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 25, bottom: 5),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'Facility Name',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      facilityDetails['full_name'],
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: const [
                      Text(
                        'Email Address',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      facilityDetails['email'],
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: const [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      facilityDetails['mobile_no'],
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

class BankDetailPanel extends StatelessWidget {
  const BankDetailPanel({
    Key? key,
    required this.bankDetails,
  }) : super(key: key);

  final Map<String, dynamic> bankDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 25, bottom: 5),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'Bank Name',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      bankDetails['bank_account']['bank'],
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: const [
                      Text(
                        'Account Name',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      bankDetails['bank_account']['account_name'],
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: const [
                      Text(
                        'Account Number',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      bankDetails['bank_account']['bank_account_no'],
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
