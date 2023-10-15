// import 'dart:html' as html;

import 'dart:io' as ioFile;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class Utils {
  static Future<void> downloadFile(String fileUrl, String filename) async {
    print('fileUrl:' + fileUrl);
    try {
      if (kIsWeb) {
        final response = await http.get(Uri.parse(fileUrl));
        //   print('web response:' + response.body);

        // html.AnchorElement anchorElement = html.AnchorElement(href: fileUrl);
        // anchorElement.download = fileUrl;
        // anchorElement.click();

        // anchorElement.remove();

        // final res = await launchUrl(Uri.parse(fileUrl));
        // print(res);

        // final fileInput = html.FileUploadInputElement()
        //   // Specify the allowed file types
        //   ..multiple = false; // Allow only single file selection

        // // Trigger the file selection dialog
        // fileInput.click();

        //  final a = anchorElement.download;
        //  print('a:' + a.toString());
        //   print('=======================');
        ///   print(a == fileUrl);
        //   print('=======================');
        return;
      }
      final response = await http.get(Uri.parse(fileUrl));

      if (response.statusCode == 200) {
        // Generate the file name with the desired extension
        final fileNameWith = '$filename.m3u8';

        // Get the app's temporary directory
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/$fileNameWith';

        final file = ioFile.File(filePath);

        //  Check if the file already exists
        if (await file.exists()) {
          return; // File already downloaded, skip the download
        }

        // File doesn't exist, proceed with the download
        await file.writeAsBytes(response.bodyBytes);
      } else {}
    } catch (error) {
      print('error: $error');
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> getAllFileData(String fileUrl) async {
    try {
      // Get the path to the file in the application's documents directory

      if (kIsWeb) {
        final response = await http.get(Uri.parse(fileUrl));
        print('===========================================');
        //  print('GET ALL FILE DATA METHOD: ' + response.body);
        print('===========================================');
        String inputString = response.body;

        final splittedInputString = inputString.split('\n');

        print(splittedInputString.runtimeType);

        List<String> tvgLogoList = [];
        List<String> groupTitleList = [];
        List<String> urlList = [];
        List<String> tvgIdList = [];

        // Define a regular expression to match the tvg-id, tvg-logo, and group-title values
        RegExp regExp = RegExp(
            r'tvg-id="([^"]+)"\s+tvg-logo="([^"]+)"\s+group-title="([^"]+)"');

        //  RegExp regExp = RegExp(r'group-title="([^"]+\s\d+\s\w+)"');

        for (var line in splittedInputString) {
          print('======================');
          print('line: ' + line);
          Match? match = regExp.firstMatch(line);

          if (line.contains('#EXTINF')) {
            if (match != null) {
              String tvgId = match.group(1)!;
              String tvgLogo = match.group(2)!;
              String groupTitle = match.group(3)!;

              tvgLogoList.add(tvgLogo);
              groupTitleList.add(groupTitle);
              tvgIdList.add(tvgId);
            }
          } else {
            urlList.add(line);
          }
        }

        return {
          'tvgLogoMatches':
              //   tvgLogoMatches.map((match) => match.group(1)!).toList(),
              tvgLogoList.toList(),
          'urlsHttp': urlList.toList(),

          //  urlMatches.map((match) => match.group(0)!).toList(),

          'groupTitles': groupTitleList.toList(),

          //    groupTitleMatches.map((match) => match.group(1)!).toList(),
          'tvgIds':

              // tvgIds.toList(),
              //  tvgIdsList,
              tvgIdList.toList(),
        };
      }

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$fileUrl.m3u8';

      final file = ioFile.File(filePath);
      if (await file.exists()) {
        // Read the contents of the file
        String inputString = await file.readAsString();
        final fileLines = await file.readAsLines();
        fileLines.removeAt(0);

        //  final RegExp tvgLogoPattern = RegExp(r'tvg-logo="([^"]+)"');
        //  final RegExp groupTitlePattern = RegExp(r',([^,]+)\s*\(');
        //  final RegExp tvgIdPattern = RegExp(r'tvg-id="([^"]+)"');
        //   final RegExp groupTitlePattern = RegExp(r',([^,]+)\s*\)\s');
        //  final RegExp urlPattern = RegExp(r'https?://[^\s]+\.m3u8');

        //  final tvgLogoMatches = tvgLogoPattern.allMatches(inputString);
        //  final groupTitleMatches = groupTitlePattern.allMatches(inputString);
        //  final urlMatches = urlPattern.allMatches(inputString);
        //  final tvgIdMatches = tvgIdPattern.allMatches(inputString);

        List<String> tvgLogoList = [];
        List<String> groupTitleList = [];
        List<String> urlList = [];
        List<String> tvgIdList = [];

        // Define a regular expression to match the tvg-id, tvg-logo, and group-title values
        RegExp regExp = RegExp(
            r'tvg-id="([^"]+)"\s+tvg-logo="([^"]+)"\s+group-title="([^"]+)"');

        //  RegExp regExp = RegExp(r'group-title="([^"]+\s\d+\s\w+)"');

        for (var line in fileLines) {
          Match? match = regExp.firstMatch(line);

          if (line.contains('#EXTINF')) {
            if (match != null) {
              String tvgId = match.group(1)!;
              String tvgLogo = match.group(2)!;
              String groupTitle = match.group(3)!;

              tvgLogoList.add(tvgLogo);
              groupTitleList.add(groupTitle);
              tvgIdList.add(tvgId);
            }
          } else {
            urlList.add(line);
          }
        }

        await file.delete(recursive: false);

        return {
          'tvgLogoMatches':
              //   tvgLogoMatches.map((match) => match.group(1)!).toList(),
              tvgLogoList.toList(),
          'urlsHttp': urlList.toList(),

          //  urlMatches.map((match) => match.group(0)!).toList(),

          'groupTitles': groupTitleList.toList(),

          //    groupTitleMatches.map((match) => match.group(1)!).toList(),
          'tvgIds':

              // tvgIds.toList(),
              //  tvgIdsList,
              tvgIdList.toList(),
        };
      } else {
        print('File not found at: $filePath');
      }
    } catch (e) {
      print('Error reading file: $e');
    }
    return {};
  }

  Future<void> showRewardedAds() async {
    await UnityAds.init(
      gameId: ioFile.Platform.isAndroid ? '5430483' : '5430482',
      onComplete: () => print('Initialization of Android ads Complete'),
      onFailed: (error, message) =>
          print('Initialization on Android ads Failed: $error $message'),
    );

    await UnityAds.load(placementId: 'Rewarded_Android');
    await UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) => print('Video Ad $placementId completed'),
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }

  Future<UnityBannerAd> showBannerAds(
      {int width = 320, int height = 50}) async {
    await UnityAds.init(
      gameId: ioFile.Platform.isAndroid ? '5430483' : '5430482',
      onComplete: () => print('Initialization of Android ads Complete'),
      onFailed: (error, message) =>
          print('Initialization on Android ads Failed: $error $message'),
    );

    final unityBannerAd = UnityBannerAd(
      size: BannerSize(width: width, height: height),
      placementId: 'Banner_Android',
      onLoad: (placementId) => print('Banner loaded: $placementId'),
      onClick: (placementId) => print('Banner clicked: $placementId'),
      onFailed: (placementId, error, message) =>
          print('Banner Ad $placementId failed: $error $message'),
    );

    await UnityAds.load(placementId: 'Banner_Android');

    return Future.value(unityBannerAd);
  }
}




//from single_content_detail_screen
  // Future<void> callApi() async {
  //   final clickCountBox = await Hive.openBox('clickCountBox');

  //   int clickCount = int.parse(clickCountBox.get('clickCount').toString());

  //   clickCount++;
  //   print('clickCount:$clickCount');
  //   final result = isDivisibleBy2(clickCount);
  //   if (result) {
  //     await Utils().showRewardedAds();
  //   }
  //   await clickCountBox.put('clickCount', clickCount);
  // }
