// Copyright (c) 2020, Charles Esrock. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// An instantiable class for parsing colors. Unlike the top-level
/// functions, this lets you explicitly specify the colors map.
class Context {
  /// Creates a new colors parser context for the given colors map.
  ///
  /// If [colorsMap] is omitted, it uses the default English language
  /// colors map.
  Context({Map<String, Color> colorsMap})
      : colorsMap = colorsMap ?? colorsMapEN;

  /// The colors map that this context works with.
  final Map<String, Color> colorsMap;

  /// Parses a string containing a Colors name or ARGB number into a Color.
  ///
  /// The method first tries to read the [source] as a Colors MaterialColor
  /// or MaterialAccentColor name with an optional indexed shade. If that
  /// fails, it tries to read the [source] as a Colors black or white
  /// variant. If that also fails, it tries to parse the [source] as an
  /// ARGB integer. If that all fails, a [FormatException] is thrown.
  ///
  /// An ARGB integer [source] can include '#' for hex numbers. Make sure
  /// you specify 8 hex digits. If you only specify 6 hex digits, then the
  /// leading 2 digits default to 0, a fully transparent alpha value.
  ///
  /// Rather than throwing and immediately catching the [FormatException],
  /// instead use [tryParse] to handle a parsing error. Example:
  ///
  ///     var value = context.tryParse(text);
  ///     if (value == null) ... handle the problem
  Color parse(String source) {
    RegExpMatch match;

    match = RegExp(r'^([a-zA-Z]+([0-9]{0,3}))(\[([0-9]{2,3})\])?$')
        .firstMatch(source);
    if (match != null) {
      dynamic color = colorsMap[match.group(1)];
      if (color != null) {
        var index = match.group(4) == null ? 0 : int.parse(match.group(4));
        if (index == 0) return color;
        if (color[index] != null) return color[index];
      }
    }

    match = RegExp(r'^(\#?)([0-9a-fA-F]+)$').firstMatch(source);
    if (match != null) {
      var radix = match.group(1) != '' ? 16 : 10;
      var colorValue = int.tryParse(match.group(2), radix: radix);
      if (colorValue != null) return Color(colorValue);
    }

    throw FormatException('Invalid color name/number', source, 0);
  }

  /// Parse [source] as a Colors name or ARGB number and return its value.
  ///
  /// Like [parse] except that this method returns `null` where a similar call
  /// to [parse] would throw a [FormatException], and the [source] must still
  /// not be `null`.
  Color tryParse(String source) {
    try {
      return parse(source);
    } catch (e) {
      return null;
    }
  }

  /// Converts [color] to a Material Colors name or ARGB number.
  String toColorsString(Color color) {
    if (color != null) {
      for (var entry in colorsMap.entries) {
        if (entry.value == color) return entry.key;
        if (entry.value is MaterialColor) {
          MaterialColor materialColor = entry.value;
          for (var shade in [50, 100, 200, 300, 400, 500, 600, 700, 800, 900]) {
            if (materialColor[shade] == color) return '${entry.key}[$shade]';
          }
        }
        if (entry.value is MaterialAccentColor) {
          MaterialAccentColor materialAccentColor = entry.value;
          for (var shade in [100, 200, 400, 700]) {
            if (materialAccentColor[shade] == color)
              return '${entry.key}[$shade]';
          }
        }
      }
      return '#' + color.value.toRadixString(16);
    } else {
      return '';
    }
  }
}

/// Default English language colors map.
final colorsMapEN = {
  'red': Colors.red,
  'pink': Colors.pink,
  'purple': Colors.purple,
  'deepPurple': Colors.deepPurple,
  'indigo': Colors.indigo,
  'blue': Colors.blue,
  'lightBlue': Colors.lightBlue,
  'cyan': Colors.cyan,
  'teal': Colors.teal,
  'green': Colors.green,
  'lightGreen': Colors.lightGreen,
  'lime': Colors.lime,
  'yellow': Colors.yellow,
  'amber': Colors.amber,
  'orange': Colors.orange,
  'deepOrange': Colors.deepOrange,
  'brown': Colors.brown,
  'grey': Colors.grey,
  'blueGrey': Colors.blueGrey,
  'redAccent': Colors.redAccent,
  'pinkAccent': Colors.pinkAccent,
  'purpleAccent': Colors.purpleAccent,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'indigoAccent': Colors.indigoAccent,
  'blueAccent': Colors.blueAccent,
  'lightBlueAccent': Colors.lightBlueAccent,
  'cyanAccent': Colors.cyanAccent,
  'tealAccent': Colors.tealAccent,
  'greenAccent': Colors.greenAccent,
  'lightGreenAccent': Colors.lightGreenAccent,
  'limeAccent': Colors.limeAccent,
  'yellowAccent': Colors.yellowAccent,
  'amberAccent': Colors.amberAccent,
  'orangeAccent': Colors.orangeAccent,
  'deepOrangeAccent': Colors.deepOrangeAccent,
  'black': Colors.black,
  'black12': Colors.black12,
  'black26': Colors.black26,
  'black38': Colors.black38,
  'black45': Colors.black45,
  'black54': Colors.black54,
  'black87': Colors.black87,
  'white': Colors.white,
  'white10': Colors.white10,
  'white12': Colors.white12,
  'white24': Colors.white24,
  'white30': Colors.white30,
  'white38': Colors.white38,
  'white54': Colors.white54,
  'white60': Colors.white60,
  'white70': Colors.white70,
  'transparent': Colors.transparent
};
