// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

// import '../../widgets/image_shimmer.dart';

// class SingleContentDetailScreen extends StatelessWidget {
//   const SingleContentDetailScreen({
//     super.key,
//     required this.videoUrl,
//     required this.channelName,
//     // required this.imageUrl,
//     // required this.title,
//     // required this.subTitle,
//   });
//   // final String imageUrl;
//   // final String title;
//   // final String subTitle;

//   final String videoUrl;
//   final String channelName;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       // child: Scaffold(
//       //   body: Column(
//       //     crossAxisAlignment: CrossAxisAlignment.start,
//       //     children: [
//       //       Center(
//       //         child: Container(
//       //           padding: EdgeInsets.zero,
//       //           margin: EdgeInsets.zero,
//       //           //   width: Get.width * 0.95,
//       //           width: Get.width,
//       //           // height: Get.height * 0.33,
//       //           height: Get.height * 0.35,

//       //           child: ClipRRect(
//       //             borderRadius: const BorderRadius.only(
//       //               bottomLeft: Radius.circular(11),
//       //               bottomRight: Radius.circular(11),
//       //               topLeft: Radius.circular(21),
//       //               topRight: Radius.circular(21),
//       //             ),
//       //             child: CachedNetworkImage(
//       //               imageUrl:
//       //                   //'https://movies.universalpictures.com/media/06-opp-dm-mobile-banner-1080x745-now-pl-f01-071223-64bab982784c7-1.jpg',
//       //                   imageUrl,
//       //               placeholder: (context, url) => imageShimmer(),
//       //               errorWidget: (context, url, error) => const Icon(
//       //                 Icons.error,
//       //                 color: AppColors.errorColor,
//       //               ),
//       //               fit: BoxFit.fill,
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //       SizedBox(
//       //         height: 21,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.symmetric(
//       //           horizontal: 20,
//       //           vertical: 9,
//       //         ),
//       //         child: Row(
//       //           children: [
//       //             textUtils.textBold16(
//       //               text: 'Title',
//       //               //  color: Colors.white54,
//       //               color: Colors.deepOrangeAccent,
//       //             ),
//       //             SizedBox(
//       //               width: 13,
//       //             ),
//       //             textUtils.textBold20(
//       //               text: title,
//       //               color: Colors.white,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.symmetric(
//       //           horizontal: 20,
//       //           vertical: 9,
//       //         ),
//       //         child: Row(
//       //           children: [
//       //             textUtils.textBold16(
//       //               text: 'Description',
//       //               //    color: Colors.white54,
//       //               color: Colors.deepOrangeAccent,
//       //             ),
//       //             SizedBox(
//       //               width: 13,
//       //             ),
//       //             textUtils.textBold14(
//       //               text: subTitle,
//       //               color: Colors.white,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       SizedBox(
//       //         height: 33,
//       //       ),
//       //       Center(
//       //         child: Container(
//       //           height: 50,
//       //           width: Get.width * 0.9,
//       //           child: ElevatedButton(
//       //             style: ButtonStyle(
//       //                 backgroundColor: MaterialStatePropertyAll(
//       //               Colors.white,
//       //             )),
//       //             onPressed: () {},
//       //             child: Row(
//       //               mainAxisAlignment: MainAxisAlignment.center,
//       //               children: [
//       //                 Icon(
//       //                   Icons.play_arrow,
//       //                   color: Colors.black,
//       //                 ),
//       //                 SizedBox(
//       //                   width: 7,
//       //                 ),
//       //                 textUtils.textBold16(text: 'Resume', color: Colors.black),
//       //               ],
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//       child: Scaffold(
//         //   floatingActionButton: FloatingActionButton(onPressed: () {
//         //   print('videoUrl: ' + videoUrl);
//         //   }),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             YoYoPlayer(
//               aspectRatio: 16 / 9,
//               url: videoUrl,
//               videoStyle: VideoStyle(),
//               videoLoadingStyle: VideoLoadingStyle(),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(21.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   textUtils.textBold20(
//                     text: channelName,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(21.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   textUtils.textBold16(text: 'Notes', color: Colors.white),
//                   SizedBox(
//                     height: 21,
//                   ),
//                   textUtils.textBold12(color: Colors.white70, text: '''
// 1) Adjust Video Quality Settings
 
// 2) Select a Lower Quality Option
 
// 3) Wait for Buffering

// 4) Consider Your Internet Connection

// 5) Monitor Data Usage

// 6) Revert to Higher Quality When Necessary

// 7) Experiment with Quality Levels

// 8) Clear Cache and Cookies (If Necessary)

// 9) Check for App Updates

// 10)Restart the App or Device

// 11) Contact Support (If Problems Persist)'''),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



