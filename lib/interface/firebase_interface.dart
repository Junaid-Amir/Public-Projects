import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/common_controller.dart';
import '../models/category_model.dart';
import '../models/county_model.dart';
import '../models/image_slider_model.dart';
import '../models/trending_model.dart';

class FirebaseInterface {
  final commonController = Get.put(CommonController());
  Future<void> getAllCountries() async {
    commonController.countries.clear();

    commonController.countries = <CountryModel>[].obs;

    final countryCollection =
        FirebaseFirestore.instance.collection('countries');

    final data = await countryCollection.get();
    for (var country in data.docs) {
      debugPrint(country.data().runtimeType.toString());

      commonController.countries.add(CountryModel.fromMap(country.data()));
      debugPrint(commonController.countries.length.toString());
    }
  }

  Future<void> getAllCategories() async {
    //  commonController.allCategories.clear();
    commonController.allCategories = <CategoryModel>[].obs;

    final categoryCollection =
        FirebaseFirestore.instance.collection('categories');

    final data = await categoryCollection
        .orderBy(
          'timestamp',
          descending: true,
        )
        .get();
    for (var category in data.docs) {
      debugPrint(category.data().runtimeType.toString());

      commonController.allCategories
          .add(CategoryModel.fromMap(category.data()));
      debugPrint(commonController.allCategories.length.toString());
    }
  }

  Future<void> getAllTrending() async {
    //  commonController.allCategories.clear();
    commonController.allTrending = <TrendingModel>[].obs;

    final trendingCollection =
        FirebaseFirestore.instance.collection('trending');

    final data =
        await trendingCollection.orderBy('timestamp', descending: true).get();
    for (var category in data.docs) {
      debugPrint(category.data().runtimeType.toString());

      commonController.allTrending.add(TrendingModel.fromMap(category.data()));
      debugPrint(commonController.allTrending.length.toString());
    }
  }

  Future<void> getAllHomeSliderImages() async {
    //  commonController.allCategories.clear();
    commonController.allTrending = <TrendingModel>[].obs;

    final homesliderCollection =
        FirebaseFirestore.instance.collection('homeslider');

    final data = await homesliderCollection.get();

    for (var category in data.docs) {
      debugPrint(category.data().runtimeType.toString());

      commonController.allSliderImages
          .add(ImageSliderModel.fromMap(category.data()));
      debugPrint(commonController.allSliderImages.length.toString());
    }
  }
}
