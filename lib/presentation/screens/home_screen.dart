import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mj_image_slider/mj_image_slider.dart';
import 'package:mj_image_slider/mj_options.dart';

import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../../controller/common_controller.dart';
import '../../helper/constants/utils.dart';
import '../../interface/firebase_interface.dart';
import '../../models/category_model.dart';
import '../../models/county_model.dart';
import '../../models/moviesModels.dart';
import '../../utils/utils.dart';
import '../../widgets/contentCard.dart';
import '../../widgets/countryCard.dart';
import '../../widgets/customcategoriesLoadingShimmer.dart';
import '../../widgets/image_shimmer.dart';
import 'single_content_detail_screen.dart';
import 'view_all_channel_screen.dart';
import 'view_all_countries_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final commonController = Get.put(CommonController());

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> firebaseAnalyticslyticsAppOpen() async {
    await analytics.logAppOpen();
  }

  @override
  void initState() {
    firebaseAnalyticslyticsAppOpen();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    commonController.countries.clear();
    callApisOfMain();
    callApis();

    super.didChangeDependencies();
  }

  Future<void> callApisOfMain() async {
    for (var data in commonController.allCategories) {
      await Utils.downloadFile(data.file, data.name);
    }
  }

  UnityBannerAd? unityBannerAd1;
  UnityBannerAd? unityBannerAd2;
  Future<void> callApis() async {
    commonController.countries.clear();

    await FirebaseInterface().getAllCategories();

//    unityBannerAd1 = await Utils().showBannerAds();
    //  unityBannerAd2 = await Utils().showBannerAds();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  width: Get.width * 0.95,
                  height: Get.height * 0.33,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(21),
                      bottomRight: Radius.circular(21),
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21),
                    ),
                    child: MJImageSlider(
                      options: MjOptions(
                        width: Get.width,
                        height: Get.height,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        scrollDirection: Axis.horizontal,
                      ),
                      widgets: commonController.allSliderImages
                          .map(
                            (element) => ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(21),
                                bottomRight: Radius.circular(21),
                                topLeft: Radius.circular(21),
                                topRight: Radius.circular(21),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: element.image,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => imageShimmer(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              FutureBuilder(
                future: Future(() async {
                  unityBannerAd1 = await Utils().showBannerAds();
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  return Center(
                    child: Container(
                      child: unityBannerAd1,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 26,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 13),
                child: Row(
                  children: [
                    textUtils.textCategoryHeading(
                      text: 'Country',
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        analytics.logEvent(name: "Button Click");
                        Get.to(const ViewAllCountriesScreen());
                      },
                      child: textUtils.textCategoryHeading(
                        text: 'See All',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: FirebaseInterface().getAllCountries(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            child: imageCountryCardShimmer(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            child: imageCountryCardShimmer(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            child: imageCountryCardShimmer(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            child: imageCountryCardShimmer(),
                          ),
                        ),
                      ],
                    );
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 13),
                    width: Get.width,
                    height: 120,
                    child: ListView.separated(
                      itemCount: commonController.countries.length > 10
                          ? 10
                          : commonController.countries.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 13,
                        );
                      },
                      itemBuilder: (context, index) {
                        final countryName =
                            commonController.countries[index].name;
                        String newName = '';
                        if (countryName.length > 11) {
                          newName = countryName.substring(0, 11);
                        } else {
                          newName = countryName;
                        }
                        return GestureDetector(
                          onTap: () async {
                            Get.to(
                              ViewAllChannelsScreen(
                                currentCountry:
                                    commonController.countries[index],
                                title: countryName,
                              ),
                            );
                          },
                          child: countryCard(
                            backgroundImage:
                                commonController.countries[index].flag,
                            countryName: newName,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              FutureBuilder(
                future: Future(() async {
                  unityBannerAd2 = await Utils().showBannerAds();
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }

                  return Center(
                    child: Container(
                      child: unityBannerAd2,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 0,
              ),
              FutureBuilder(
                future: FirebaseInterface().getAllCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return customCategoriesLoadingShimmer();
                  }

                  return SizedBox(
                    width: Get.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: commonController.allCategories.length,
                      itemBuilder: (context, index) {
                        return categories(
                            commonController.allCategories[index]);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categories(CategoryModel category) {
    List<String> allLinks = [];
    List<String> groupTitles = [];
    List<String> urlsHttp = [];
    List<String> tvgIds = [];

    List<ChannelModel> channels = [];
    return FutureBuilder(
      future: Future(() async {
        Map<String, dynamic> data = {};
        if (kIsWeb) {
          data = await Utils().getAllFileData(category.file);
        } else {
          data = await Utils().getAllFileData(category.name);
        }

        allLinks = data['tvgLogoMatches'] as List<String>;
        groupTitles = data['groupTitles'] as List<String>;
        urlsHttp = data['urlsHttp'] as List<String>;
        tvgIds = data['tvgIds'] as List<String>;

        for (var i = 0; i < groupTitles.length; i++) {
          channels.add(
            ChannelModel(
              title: tvgIds[i],
              channelLogUrl: allLinks[i],
              videoUrl: urlsHttp[i],
            ),
          );
        }
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return customCategoriesLoadingShimmer();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            channels.isEmpty) {
          return Container();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  textUtils.textCategoryHeading(
                      text: category.name.capitalizeFirst!),
                  const SizedBox(width: 7),
                  textUtils.textBold14(
                      text: tvgIds.length.toString(), color: Colors.grey),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(ViewAllChannelsScreen(
                        currentCountry: CountryModel(
                            name: category.name, file: category.file, flag: ''),
                        title: category.name.capitalizeFirst!,
                      ));
                    },
                    child: textUtils.textCategoryHeading(
                      text: 'See All',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 21),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: groupTitles.length <= 10 ? groupTitles.length : 10,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(SingleContentDetailScreen(
                              channelName: tvgIds[index],
                              videoUrl: urlsHttp[index],
                            ));
                          },
                          child: contentCard(
                            imageUrl: allLinks[index],
                            title: tvgIds[index].length <= 17
                                ? tvgIds[index]
                                : '${tvgIds[index].substring(0, 17)}...',
                          ),
                        ),
                        const SizedBox(width: 11),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
