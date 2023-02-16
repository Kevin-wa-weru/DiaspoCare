import 'package:diasporacare/constants.dart';
import 'package:diasporacare/screens/auth/location/cubit/get_towns_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickTown extends StatefulWidget {
  const PickTown({super.key, required this.stateName});
  final String stateName;
  @override
  State<PickTown> createState() => _PickTownState();
}

class _PickTownState extends State<PickTown> {
  getTowns() async {
    context.read<GetTownsCubit>().getTowns(widget.stateName);
  }

  @override
  void initState() {
    getTowns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          'Select Your Town',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              bottom: 8,
              top: 8,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(800),
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/icons/cancel2.svg',
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          BlocBuilder<GetTownsCubit, GetTownsState>(
            builder: (context, state) {
              return state.when(initial: () {
                return Container();
              }, loading: () {
                return const LinearProgressIndicator(
                  color: loadingButtonColor,
                );
              }, loaded: (message) {
                return Container();
              }, error: (message) {
                return Container();
              });
            },
          ),
          BlocBuilder<GetTownsCubit, GetTownsState>(
            builder: (context, state) {
              return state.when(initial: () {
                return Container();
              }, loading: () {
                return Container();
              }, loaded: (townNames) {
                return Column(
                  children: townNames
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            Navigator.pop(
                              context,
                              e['name'],
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, left: 15.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.6,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    e['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              }, error: (message) {
                return Center(
                  child: Text(message.toString()),
                );
              });
            },
          )
        ],
      ),
    );
  }
}
