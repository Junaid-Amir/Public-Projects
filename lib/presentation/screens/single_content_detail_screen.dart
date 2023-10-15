import 'package:chewie/chewie.dart';
// import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:video_player/video_player.dart';

import '../../helper/constants/utils.dart';
import '../../utils/utils.dart';

class SingleContentDetailScreen extends StatefulWidget {
  const SingleContentDetailScreen({
    super.key,
    required this.videoUrl,
    required this.channelName,
  });

  final String videoUrl;
  final String channelName;

  @override
  State<SingleContentDetailScreen> createState() =>
      _SingleContentDetailScreenState();
}

class _SingleContentDetailScreenState extends State<SingleContentDetailScreen> {
  ChewieController? _chewieController;

  Future<String> callAdsApi() async {
    final clickCountBox = await Hive.openBox('clickCountBox');

    int clickCount = int.parse(clickCountBox.get('clickCount').toString());

    clickCount++;
    // print('clickCount:$clickCount');
    final result = isDivisibleBy2(clickCount);
    if (result) {
      await Utils().showRewardedAds();
    }
    await clickCountBox.put('clickCount', clickCount);
    return 'playVideo';
  }

  bool isDivisibleBy2(int number) {
    return (number % 2 == 0);
  }

  bool isLoading = false;

  Future<void> playVideoAfterAdsMethodExecution() async {
    isLoading = true;
    final result = await callAdsApi();
    if (result == 'playVideo') {
      _chewieController = ChewieController(
        allowFullScreen: true,
        aspectRatio: 16 / 9,
        isLive: true,
        progressIndicatorDelay: null,
        showOptions: true,
        showControls: true,
        showControlsOnInitialize: false,
        placeholder: const Center(
          child: CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
        ),
        autoPlay: true,
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(widget.videoUrl),
        ),
      );
    }

    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    playVideoAfterAdsMethodExecution();
    super.initState();

    // _chewieController = ChewieController(
    //   allowFullScreen: true,
    //   aspectRatio: 16 / 9,
    //   isLive: true,
    //   progressIndicatorDelay: null,
    //   showOptions: true,
    //   showControls: true,
    //   showControlsOnInitialize: false,
    //   placeholder: const Center(
    //     child: CircularProgressIndicator(
    //       color: Colors.deepOrange,
    //     ),
    //   ),
    //   autoPlay: true,
    //   videoPlayerController:
    //       VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl + '?low')),
    // );
  }

  // @override
  // void didChangeDependencies() {
  //   // callAdsApi();
  //   playVideoAfterAdsMethodExecution();

  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    _chewieController!.videoPlayerController.dispose();

    _chewieController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp]);

        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.size.width,
                height: 250,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepOrange,
                        ),
                      )
                    : Chewie(
                        controller: _chewieController!,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(21.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textUtils.textBold20(
                      text: widget.channelName,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(21.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textUtils.textBold16(text: 'Notes', color: Colors.white),
                    SizedBox(
                      height: 21,
                    ),
                    textUtils.textBold12(color: Colors.white70, text: '''
    1) Adjust Video Quality Settings
     
    2) Select a Lower Quality Option
     
    3) Wait for Buffering
    
    4) Consider Your Internet Connection
    
    5) Monitor Data Usage
    
    6) Revert to Higher Quality When Necessary
    
    7) Experiment with Quality Levels
    
    8) Clear Cache and Cookies (If Necessary)
    
    9) Check for App Updates
    
    10)Restart the App or Device
    
    11) Contact Support (If Problems Persist)'''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
