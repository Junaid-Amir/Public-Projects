import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';
import 'trending_screen.dart';
import 'view_all_countries_screen.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  RxInt selectedIndex = 0.obs;

  List<Widget> screens = [
    const HomeScreen(),
    // Center(

    //   child: Container(
    //     child: textUtils.textCategoryHeading(text: 'index1'),
    //   ),
    // ),
    const TrendingScreen(),

    const ViewAllCountriesScreen(
        // allCountries: commonController.countries,
        // isCommingFromWrapperScreen: true,
        )
    // Center(
    //   child: Container(
    //     child: textUtils.textCategoryHeading(text: 'index3'),
    //   ),
    // ),
    // UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: screens[selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              debugPrint(value.toString());
              selectedIndex.value = value;
            },
            currentIndex: selectedIndex.value,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.live_tv_rounded,
                ),
                label: 'Live Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.blur_circular_rounded,
                ),
                label: 'All Countries',
              ),
            ],
          ),
        ));
  }
}
