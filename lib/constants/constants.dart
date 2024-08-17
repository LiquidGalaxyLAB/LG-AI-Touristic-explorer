import 'package:flutter/material.dart';

var primary = ThemeData(
    primaryColor: const Color(0xff001945),
    secondaryHeaderColor: const Color(0xff254eb9),
    cardColor: const Color.fromARGB(255, 138, 235, 249),
    dividerColor: const Color.fromARGB(255, 29, 92, 65),
    hintColor: const Color.fromARGB(255, 1, 188, 212));

var profile1 = ThemeData(
  primaryColor: const Color(0xff311B41),
  secondaryHeaderColor: const Color(0xff7A37B6),
  cardColor: Color.fromARGB(255, 255, 193, 135),
  dividerColor: const Color.fromARGB(255, 64, 32, 0),
  hintColor: const Color.fromARGB(255, 255, 224, 100),
);

var profile2 = ThemeData(
  primaryColor: const Color(0xff152337), // Darker blue
  secondaryHeaderColor:
      const Color(0xff324860), // Darker blue, slightly lighter
  cardColor: const Color(0xfff0f0f0), // Light grey for contrast
  dividerColor: Color.fromARGB(255, 0, 0, 0), // Medium grey
  hintColor: const Color.fromARGB(255, 1, 188, 212), // Dark grey
);
var profile3 = ThemeData(
    primaryColor: Color.fromARGB(255, 15, 19, 18), // Dark olive
    secondaryHeaderColor: Color.fromARGB(255, 34, 82, 59), // Lighter olive
    cardColor: const Color.fromARGB(255, 210, 235, 204), // Light green
    dividerColor: const Color(0xff23473a), // Darker olive
    hintColor: Color.fromARGB(255, 95, 255, 116)); // Lighter green
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
