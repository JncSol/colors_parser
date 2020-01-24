// Copyright (c) 2020, Charles Esrock. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:colors_parser/colors_parser.dart' as cp;

void main() {
  test('Parse colors primaries', () {
    for (var color in Colors.primaries) {
      testNamedColor(color);
    }
  });

  test('Parse colors accents', () {
    for (var color in Colors.accents) {
      testNamedColor(color);
    }
  });

  test('Parse special colors and black/white variants', () {
    testNamedColor(Colors.transparent);
    testNamedColor(Colors.grey);
    testNamedColor(Colors.black);
    testNamedColor(Colors.white);

    testNamedColor(Colors.black12);
    testNamedColor(Colors.black26);
    testNamedColor(Colors.black38);
    testNamedColor(Colors.black45);
    testNamedColor(Colors.black54);
    testNamedColor(Colors.black87);

    testNamedColor(Colors.white10);
    testNamedColor(Colors.white12);
    testNamedColor(Colors.white24);
    testNamedColor(Colors.white30);
    testNamedColor(Colors.white38);
    testNamedColor(Colors.white54);
    testNamedColor(Colors.white60);
    testNamedColor(Colors.white70);
  });

  test('Parse shades', () {
    for (var color in Colors.primaries) {
      for (var shade in [50, 100, 200, 300, 400, 500, 600, 700, 800, 900]) {
        testNamedColor(color[shade]);
      }
    }
    for (var color in Colors.accents) {
      for (var shade in [100, 200, 400, 700]) {
        testNamedColor(color[shade]);
      }
    }
  });

  test('Parse numeric colors', () {
    testNumericColor(Color(0x123456));
    testNumericColor(Color(0x12345678));
  });

  test('Parse exceptions', () {
    expect(cp.tryParse(null), isNull);
    expect(cp.tryParse(''), isNull);
    expect(cp.tryParse('[100]'), isNull);
    expect(cp.tryParse('unknown'), isNull);
    expect(cp.tryParse('blue10'), isNull);
    expect(cp.tryParse('blue[100'), isNull);
    expect(cp.tryParse('blue[]'), isNull);
    expect(cp.tryParse('blue[10]'), isNull);
    expect(cp.tryParse('black10'), isNull);
    expect(cp.tryParse('black12[100]'), isNull);
    expect(cp.tryParse('ff123456'), isNull);
    expect(cp.tryParse('0xff123456'), isNull);

    expect(cp.toColorsString(null), '');

    expect(cp.colorsMapEN['green'], Colors.green);
    expect(cp.colorsMap["blue"], Colors.blue);
  });
}

void testNamedColor(Color color) {
  var source = cp.toColorsString(color);
  expect(source, isNot(startsWith('#')));
  expect(cp.parse(source), color);
}

void testNumericColor(Color color) {
  expect(cp.parse(cp.toColorsString(color)), color);
}
