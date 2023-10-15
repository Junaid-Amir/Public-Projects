import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'image_shimmer.dart';

Padding customCategoriesLoadingShimmer({double height = 50}) {
  return Padding(
    padding: const EdgeInsets.only(left: 13.0, right: 13),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: SizedBox(
                width: 50,
                height: 15,
                child: imageShimmer(),
              ),
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: SizedBox(
                width: 50,
                height: 15,
                child: imageShimmer(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 21,
        ),

        /// here is the content card shimmer
        SizedBox(
          width: Get.width,
          height: 125,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 105,
                  height: 125,
                  //    radius: 40,
                  //    backgroundColor: Colors.transparent,
                  child: imageShimmer(),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 105,
                  height: 125,
                  //    radius: 40,
                  //    backgroundColor: Colors.transparent,
                  child: imageShimmer(),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 105,
                  height: 125,
                  //    radius: 40,
                  //    backgroundColor: Colors.transparent,
                  child: imageShimmer(),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 105,
                  height: 125,
                  //    radius: 40,
                  //    backgroundColor: Colors.transparent,
                  child: imageShimmer(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 41),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: SizedBox(
                width: 50,
                height: 15,
                child: imageShimmer(),
              ),
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: SizedBox(
                width: 50,
                height: 15,
                child: imageShimmer(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 21),
        SizedBox(
          width: Get.width,
          height: 125,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 105,
                  height: 125,
                  //    radius: 40,
                  //    backgroundColor: Colors.transparent,
                  child: imageShimmer(),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 105,
                  height: 125,
                  //    radius: 40,
                  //    backgroundColor: Colors.transparent,
                  child: imageShimmer(),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 105,
                  height: 125,
                  //    radius: 40,
                  //    backgroundColor: Colors.transparent,
                  child: imageShimmer(),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 105,
                  height: 125,
                  //    radius: 40,
                  //    backgroundColor: Colors.transparent,
                  child: imageShimmer(),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
