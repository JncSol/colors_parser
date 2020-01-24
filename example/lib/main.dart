// Copyright (c) 2020, Charles Esrock. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:colors_parser/colors_parser.dart' as cp;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final colors = <String>[];

  App() {
    for (var color in Colors.primaries) colors.add(cp.toColorsString(color));
    for (var color in Colors.accents) colors.add(cp.toColorsString(color));
    for (var index in [50, 100, 200, 300, 400, 500, 600, 700, 800, 900])
      colors.add(cp.toColorsString(Colors.blue[index]));
    for (var index in [100, 200, 400, 700])
      colors.add(cp.toColorsString(Colors.blueAccent[index]));
    for (var color in ['grey', 'black', 'white']) colors.add(color);
    for (var color in [12, 26, 38, 45, 54, 87]) colors.add('black$color');
    for (var color in [10, 12, 30, 38, 54, 60, 70]) colors.add('white$color');
  }

  Widget build(BuildContext context) {
    var black = cp.parse('black');
    var grey500 = cp.parse('grey[500]');
    var white54 = cp.parse('white54');
    var black54 = cp.parse('black54');
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
              child: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          var color = cp.parse(colors[index]);
          var backColor = color.alpha == 0xFF ? color : grey500;
          var textColor =
              color.alpha != 0xFF ? color : color == black ? white54 : black54;
          return Container(
            height: 50,
            color: backColor,
            child: Center(
                child: Text(
                    '${colors[index]} #${cp.parse(colors[index]).value.toRadixString(16)}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor))),
          );
        },
      ))),
    );
  }
}
