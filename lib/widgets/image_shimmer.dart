import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

Widget imageShimmer() {
  return Shimmer(
    child: Container(
      color: const Color.fromARGB(88, 158, 158, 158),
    ),
  );
}

Widget imageCountryCardShimmer() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(40),
    child: Shimmer(
      child: Container(
        color: const Color.fromARGB(88, 158, 158, 158),
      ),
    ),
  );
}
