import 'package:diasporacare/features/homepage/account.dart';
import 'package:diasporacare/features/homepage/cubit/check_if_verified_cubit.dart';
import 'package:diasporacare/features/homepage/cubit/get_best_selling_items_cubit.dart';
import 'package:diasporacare/features/homepage/cubit/get_dash_board_stats_cubit.dart';
import 'package:diasporacare/features/homepage/cubit/get_new_request_count_cubit.dart';
import 'package:diasporacare/features/homepage/cubit/get_vendor_details_cubit.dart';
import 'package:diasporacare/features/homepage/home_page.dart';
import 'package:diasporacare/features/homepage/promotions.dart';
import 'package:diasporacare/features/transactions/transactions.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    context.read<GetVendorDetailsCubit>().getVendorDetails();
    context.read<CheckIfVerifiedCubit>().checkIfVerified();
    context.read<GetNewRequestCountCubit>().getNewREquestCount();
    context.read<GetDashBoardStatsCubit>().getDashboardStats();
    context.read<GetBestSellingItemsCubit>().getBestSellingItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          backgroundColor: Colors.black54,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          duration: const Duration(seconds: 2),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Tap again to exit the app',
                style: TextStyle(
                    fontFamily: 'JosefinSans',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 2,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 5,
          ),
        ),
        child: PageView(
          physics: const ClampingScrollPhysics(),
          controller: _pageController,
          allowImplicitScrolling: true,
          onPageChanged: (int page) {
            setState(() {
              currentIndex = page;
            });
          },
          children: const [
            HomePage(
              pharmacyName: '',
              vendorName: '',
            ),
            Transaction(),
            Promotions(),
            Account(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
        unselectedItemColor: Colors.black54,
        selectedItemColor: const Color(0xFF145DA0),
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() => currentIndex = index);
          HapticFeedback.lightImpact();
          _pageController.animateToPage(index,
              duration: const Duration(seconds: 1), curve: Curves.ease);
        },
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: currentIndex == 0
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/home.svg',
                          color: const Color(0xFF145DA0),
                        ),
                      ),
                      const SizedBox(height: 4)
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/home.svg',
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4)
                    ],
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 1
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/transaction.svg',
                          color: const Color(0xFF145DA0),
                        ),
                      ),
                      const SizedBox(height: 4)
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/transaction.svg',
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4)
                    ],
                  ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 2
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/promotions.svg',
                          color: const Color(0xFF145DA0),
                        ),
                      ),
                      const SizedBox(height: 4)
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/promotions.svg',
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4)
                    ],
                  ),
            label: 'Promotions',
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 3
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/account.svg',
                          color: const Color(0xFF145DA0),
                        ),
                      ),
                      const SizedBox(height: 4)
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/account.svg',
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4)
                    ],
                  ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
