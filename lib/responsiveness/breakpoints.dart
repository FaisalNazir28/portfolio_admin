import 'package:flutter/material.dart';

class Breakpoints {
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= 600;
  }

  static bool isMobileLessThan500(BuildContext context) {
    return MediaQuery.of(context).size.width <= 500;
  }

  static bool isMobile500to550(BuildContext context) {
    return MediaQuery.of(context).size.width > 500 &&
        MediaQuery.of(context).size.width <= 550;
  }

  static bool isTablet600to800(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 &&
        MediaQuery.of(context).size.width <= 800;
  }

  static bool isDesktop1200to1300(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200 &&
        MediaQuery.of(context).size.width <= 1300;
  }

  static bool isDesktop1300to1400(BuildContext context) {
    return MediaQuery.of(context).size.width > 1300 &&
        MediaQuery.of(context).size.width <= 1400;
  }

  static bool isDesktop1400to1500(BuildContext context) {
    return MediaQuery.of(context).size.width > 1400 &&
        MediaQuery.of(context).size.width <= 1500;
  }

  static bool isDesktop1500to1600(BuildContext context) {
    return MediaQuery.of(context).size.width > 1500 &&
        MediaQuery.of(context).size.width <= 1600;
  }

  static bool isDesktop1600to1700(BuildContext context) {
    return MediaQuery.of(context).size.width > 1600 &&
        MediaQuery.of(context).size.width <= 1700;
  }

  static bool isDesktop1700to1800(BuildContext context) {
    return MediaQuery.of(context).size.width > 1700 &&
        MediaQuery.of(context).size.width <= 1800;
  }

  static bool isDesktop1800to1900(BuildContext context) {
    return MediaQuery.of(context).size.width > 1800 &&
        MediaQuery.of(context).size.width <= 1900;
  }
}
