import 'package:get/get.dart';

import '../models/category_model.dart';
import '../models/county_model.dart';
import '../models/image_slider_model.dart';
import '../models/trending_model.dart';

class CommonController extends GetxController {
  RxList<CountryModel> countries = <CountryModel>[].obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;

  RxList<TrendingModel> allTrending = <TrendingModel>[].obs;
  RxList<ImageSliderModel> allSliderImages = <ImageSliderModel>[].obs;

//   ////////////////
//   static RxList<int> checkLengthTitleList = <int>[].obs;
//   static RxList<int> generatedLists = <int>[].obs;

// ////////////////////

//   static RxList<String> allLinks = <String>[].obs;
//   static RxList<String> groupTitles = <String>[].obs;
//   static RxList<String> urlsHttp = <String>[].obs;

//   static RxString fileContents = 'fetching data...'.obs;
}
