import 'package:flutter/material.dart';

var primary = ThemeData(
    primaryColor: const Color(0xff001945),
    secondaryHeaderColor: const Color(0xff254eb9),
    cardColor: const Color.fromARGB(255, 138, 235, 249),
    dividerColor: const Color.fromARGB(255, 29, 92, 65),
    hintColor: const Color.fromARGB(255, 1, 188, 212));

var secondary = ThemeData(
    primaryColor: const Color.fromARGB(255, 63, 0, 69),
    secondaryHeaderColor: const Color.fromARGB(255, 118, 37, 185),
    cardColor: const Color.fromARGB(255, 214, 138, 249),
    dividerColor: const Color.fromARGB(255, 92, 29, 73),
    hintColor: Color.fromARGB(255, 26, 1, 37));

var profile1 = ThemeData(
  primaryColor: const Color(0xff311B41), // Dark Purple
  secondaryHeaderColor: const Color(0xff7A37B6), // Lighter Purple
  cardColor: Color.fromARGB(255, 255, 193, 135), // Orange
  dividerColor: const Color.fromARGB(255, 64, 32, 0), // Dark Orange
  hintColor: const Color.fromARGB(255, 255, 224, 100), // Light Orange
);
const white = Color.fromARGB(255, 255, 255, 255);
const factorLogo = 1621 / 2560;
String getLanguageName(String localeCode) {
  switch (localeCode) {
    case 'en':
      return 'ENGLISH';
    case 'es':
      return 'SPANISH';
    case 'hi':
      return 'HINDI';
    case 'fr':
      return 'FRENCH';
    case 'it':
      return 'ITALIAN';
    case 'ja':
      return 'JAPANESE';
    case 'zh':
      return 'CHINESE';
    default:
      return 'ENGLISH';
  }
}
