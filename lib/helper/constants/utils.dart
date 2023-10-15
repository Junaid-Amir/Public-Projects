import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

final textUtils = TextUtils();

class TextUtils {
  Text textCategoryHeading({
    required String text,
    double fontSize = 15,
    // Color color = Colors.white70,
    Color color = const Color.fromRGBO(255, 110, 64, 1),
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  Text textContentCardTitle(
      {required String text,
      double fontSize = 11.5,
      TextAlign textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.textCategoryHeadingColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }

  Text textContentCardSubTitle({
    required String text,
    double fontSize = AppConstants.textContentCardSubTitleFontSize,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.textCategoryHeadingColor.withOpacity(0.4),
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }

/////////////////////////////////////////////////////////////////

  Text textBold20({
    required String text,
    double fontSize = 20,
    Color color = Colors.white70,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  Text textBold22({
    required String text,
    double fontSize = 22,
    Color color = Colors.white,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  Text textBold16({
    required String text,
    double fontSize = 16,
    Color color = Colors.white70,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  Text textBold14({
    required String text,
    double fontSize = 14,
    Color color = Colors.white,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  Text textBold12({
    required String text,
    double fontSize = 12,
    Color color = Colors.white,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  Text textBold12_5({
    required String text,
    double fontSize = 12.5,
    Color color = Colors.white,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  Text textBold18({
    required String text,
    double fontSize = 18,
    Color color = Colors.white,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}
