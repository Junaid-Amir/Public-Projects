import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../models/county_model.dart';
import '../../models/moviesModels.dart';
import '../../utils/utils.dart';
import '../../widgets/contentCard.dart';
import 'single_content_detail_screen.dart';

class ViewAllChannelsScreen extends StatefulWidget {
  const ViewAllChannelsScreen({
    super.key,
    required this.title,
    required this.currentCountry,
  });

  final String title;
  final CountryModel currentCountry;

  @override
  State<ViewAllChannelsScreen> createState() => _ViewAllChannelsScreenState();
}

class _ViewAllChannelsScreenState extends State<ViewAllChannelsScreen> {
  final searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    callApis();
    super.didChangeDependencies();
  }

  List<ChannelModel> channels = [];
  bool isLoading = false;
  Future<void> callApis() async {
    isLoading = true;
    await Utils.downloadFile(
      widget.currentCountry.file,
      widget.currentCountry.name,
    );
    Map<String, dynamic> data = {};
    if (kIsWeb) {
      data = await Utils().getAllFileData(widget.currentCountry.file);
    } else {
      data = await Utils().getAllFileData(widget.currentCountry.name);
    }
    List<String> allLinks = [];
    List<String> groupTitles = [];
    List<String> urlsHttp = [];
    List<String> tvgIds = [];

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
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.7),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 21),
          searchField(),
          const SizedBox(height: 11),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ))
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 166,
                      mainAxisSpacing: 11,
                      crossAxisSpacing: 0,
                    ),
                    itemCount: _filteredData.isEmpty
                        ? channels.length
                        : _filteredData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 13),
                        child: GestureDetector(
                          onTap: () {
                            if (_filteredData.isEmpty) {
                              Get.to(SingleContentDetailScreen(
                                channelName: channels[index].title,
                                videoUrl: channels[index].videoUrl,
                              ));
                            } else {
                              Get.to(SingleContentDetailScreen(
                                channelName: _filteredData[index].title,
                                videoUrl: _filteredData[index].videoUrl,
                              ));
                            }
                          },
                          child: Row(
                            children: [
                              if (_filteredData.isNotEmpty &&
                                  searchController.text.isNotEmpty) ...{
                                contentCard(
                                  imageUrl: _filteredData[index].channelLogUrl,
                                  title: _filteredData[index].title.length <= 17
                                      ? _filteredData[index].title
                                      : '${_filteredData[index].title.substring(0, 17)}...',
                                ),
                              } else if (_filteredData.isEmpty &&
                                  searchController.text.isNotEmpty) ...{
                                const SizedBox(),
                              } else ...{
                                contentCard(
                                  imageUrl: channels[index].channelLogUrl,
                                  title: channels[index].title.length <= 17
                                      ? channels[index].title
                                      : '${channels[index].title.substring(0, 17)}...',
                                ),
                              }
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget searchField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) =>
                  performSearch(searchController.text, channels),
              cursorColor: Colors.deepOrangeAccent,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<ChannelModel> _filteredData = [];

  void performSearch(String query, Iterable<ChannelModel> data) {
    query = query.toLowerCase().trim();

    setState(() {
      _filteredData.clear();

      if (query.isEmpty || query == '') {
        _filteredData.addAll(data);
      } else {
        _filteredData.addAll(data.where((item) {
          return item.title.toLowerCase().trim().contains(query);
        }));
      }
    });
  }

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Future<void> firebaseAnalyticslyticsSearchChannel() async {
    await analytics.logEvent(name: 'A Channel Searched by user');
  }
}
