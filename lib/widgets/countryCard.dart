import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helper/constants/utils.dart';
import 'image_shimmer.dart';

Widget countryCard({
  required String backgroundImage,
  required String countryName,
}) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: const Color.fromARGB(88, 158, 158, 158),
        radius: 40,
        backgroundImage: NetworkImage(
          backgroundImage,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: CachedNetworkImage(
            imageUrl: backgroundImage,
            fit: BoxFit.cover,
            placeholder: (context, url) => imageCountryCardShimmer(),
          ),
        ),
      ),
      const SizedBox(
        height: 11,
      ),
      textUtils.textBold14(
        text: countryName,
        color: Colors.white70,
      ),
    ],
  );
}
