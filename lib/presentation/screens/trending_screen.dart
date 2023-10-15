import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/constants/utils.dart';
import '../../interface/firebase_interface.dart';
import '../../main.dart';
import '../../models/county_model.dart';
import '../../models/moviesModels.dart';
import '../../models/trending_model.dart';
import '../../utils/utils.dart';
import '../../widgets/contentCard.dart';
import '../../widgets/customcategoriesLoadingShimmer.dart';
import 'single_content_detail_screen.dart';
import 'view_all_channel_screen.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  @override
  void initState() {
    callApis();
    super.initState();
  }

  RxBool isLoading = false.obs;

  Future<void> callApis() async {
    isLoading.value = true;
    await FirebaseInterface().getAllTrending();

    for (var file in commonController.allTrending) {
      await Utils.downloadFile(file.file, file.name);
    }

    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.45),
        title: const Text('Live Events'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 9.0),
          child: SingleChildScrollView(
            child: isLoading.isTrue
                ? Column(
                    children: [
                      customCategoriesLoadingShimmer(
                        height: 35,
                      ),
                      customCategoriesLoadingShimmer(
                        height: 30,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 21,
                      ),
                      for (var trendingData
                          in commonController.allTrending) ...{
                        trendingDataWidget(trendingData),
                      }
                    ],
                  ),
          ),
        ),
      ),
    ));
  }

  Widget trendingDataWidget(TrendingModel trendingData) {
    List<String> allLinks = [];
    List<String> groupTitles = [];
    List<String> urlsHttp = [];
    List<String> tvgIds = [];

    List<ChannelModel> channels = [];

    return FutureBuilder(
      future: Future(() async {
        Map<String, dynamic> data = {};

        if (kIsWeb) {
          data = await Utils().getAllFileData(trendingData.file);
        } else {
          data = await Utils().getAllFileData(trendingData.name);
        }

        // print('file data:' + data.toString());
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
          return customCategoriesLoadingShimmer(height: 20);
        }

        return Column(
          children: [
            Row(
              children: [
                textUtils.textCategoryHeading(
                    text: trendingData.name.capitalizeFirst!),
                const SizedBox(width: 7),
                textUtils.textBold14(
                    text: tvgIds.length.toString(), color: Colors.grey),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(ViewAllChannelsScreen(
                      currentCountry: CountryModel(
                          name: trendingData.name,
                          file: trendingData.file,
                          flag: ''),
                      title: trendingData.name.capitalizeFirst!,
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
              width: Get.width,
              height: 180,
              child: ListView.separated(
                itemCount: channels.length >= 10 ? 10 : channels.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 13),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(SingleContentDetailScreen(
                        channelName: channels[index].title,
                        videoUrl: channels[index].videoUrl,
                      ));
                    },
                    child: contentCard(
                      imageUrl: channels[index].channelLogUrl,
                      title: channels[index].title,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
