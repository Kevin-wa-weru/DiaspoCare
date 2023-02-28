import 'package:diasporacare/screens/homepage/account.dart';
import 'package:diasporacare/screens/homepage/cubit/check_if_verified_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_best_selling_items_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_dash_board_stats_cubit.dart';
import 'package:diasporacare/screens/homepage/cubit/get_vendor_details_cubit.dart';
import 'package:diasporacare/screens/homepage/home_page.dart';
import 'package:diasporacare/screens/homepage/promotions.dart';
import 'package:diasporacare/screens/transactions/transactions.dart';
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
    context.read<GetDashBoardStatsCubit>().getDashboardStats();
    context.read<GetBestSellingItemsCubit>().getBestSellingItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const ClampingScrollPhysics(),
        // physics: const NeverScrollableScrollPhysics(),
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
      bottomNavigationBar: BottomNavigationBar(
        // elevation: 0,
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black54),
        unselectedLabelStyle: const TextStyle(
            fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black54,
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
                          color: Colors.black54,
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
                          color: Colors.black54,
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
                          color: Colors.black54,
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
                          color: Colors.black54,
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
