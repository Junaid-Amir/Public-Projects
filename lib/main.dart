import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'controller/common_controller.dart';
import 'firebase_options.dart';
import 'helper/constants/colors.dart';
import 'helper/constants/constants.dart';
import 'interface/firebase_interface.dart';
import 'presentation/screens/wrapper.dart';
import 'utils/utils.dart';

final commonController = Get.put(CommonController());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  await callApis();
  final clickCountBox = await Hive.openBox('clickCountBox');
  await clickCountBox.put('clickCount', 0);

  runApp(const MyApp());
}

Future<void> callApis() async {
  await FirebaseInterface().getAllCategories();

  for (var data in commonController.allCategories) {
    await Utils.downloadFile(data.file, data.name);
  }

  await FirebaseInterface().getAllHomeSliderImages();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tvchan',
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
          fontFamily: AppConstants.manropeFont,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedLabelStyle: const TextStyle(
              height: AppConstants.bottomNavBarLabelAndIconHeight,
              fontSize: AppConstants.bottomNavBarlabelSize,
            ),
            unselectedLabelStyle: const TextStyle(
              height: AppConstants.bottomNavBarLabelAndIconHeight,
              fontSize: AppConstants.bottomNavBarlabelSize,
            ),
            elevation: AppConstants.bottomNavBarElevation,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.bottomNavBgColor,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedItemColor: AppColors.bottomNavBarItemSelectedColor,
            unselectedItemColor: AppColors.bottomNavBarItemUnSelectedColor,
          )),
      home: Wrapper(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
    );
  }
}
