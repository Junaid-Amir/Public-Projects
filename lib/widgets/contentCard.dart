import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constants/colors.dart';
import '../helper/constants/utils.dart';
import 'image_shimmer.dart';

Widget contentCard({
  required String imageUrl,
  required String title,
}) {
  return SizedBox(
    width: 100,
    height: 200,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(width: 0.5, color: Colors.grey),
          ),
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: CachedNetworkImage(
              placeholder: (context, url) => imageShimmer(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error_outline,
                color: AppColors.errorColor,
              ),
              imageUrl: imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        textUtils.textContentCardTitle(text: title),
        const SizedBox(
          height: 7,
        ),
      ],
    ),
  );
}
