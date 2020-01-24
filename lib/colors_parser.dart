// Copyright (c) 2020, Charles Esrock.  All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'src/context.dart';

export 'src/context.dart';

/// The colors parser context.
///
/// This differs from a context created with [new Context] in that its
/// [Context.colorsMap] is always based on the English language, rather than
/// being set once when the context is created.
final Context context = Context();

/// Parses a string containing a Colors name or ARGB number into a Color
/// like [Context.parse].
Color parse(String source) => context.parse(source);

/// Parse [source] as a Colors name or ARGB number and return its value
/// like [Context.tryParse].
Color tryParse(String source) => context.tryParse(source);

/// Converts [color] to a Material Colors name or ARGB number
/// like [Context.toColorsString].
String toColorsString(Color color) => context.toColorsString(color);

/// Gets the colors map associated with the colors parser context
/// like [Context.colorsMap].
Map<String, Color> get colorsMap => context.colorsMap;