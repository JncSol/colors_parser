A Material Colors parsing library.

The colors_parser package provides string parsing operations for
MaterialColor and MaterialAccentColor values with an optional indexed
shade as well as black and white variants and even hex values.

## Installing ##

Use [pub][] to install this package. Add the following to your
`pubspec.yaml` file.

    dependencies:
      colors_parser: any

Then run `pub install`.

For more information, see the [colors_parser package on pub.dev][pkg].

[pub]: http://pub.dev
[pkg]: http://pub.dev/packages/colors_parser

## Using

The colors_parser package was designed to be imported with a prefix,
though you don't have to if you don't want to:

```dart
import 'package:colors_parser/colors_parser.dart' as cp;
```

The most common way to use the library is through the top-level functions.
These parse Material Colors based on English language names. For example:

```dart
cp.parse('blue');
```

This calls the top-level `parse()` function to parse "blue" using
English language names.

If you want to work with colors for a different language, you can create a
`ColorsParser` and give it an explicit colors map:

```dart
var cpES = new cp.ColorsParser(colorsMap: ["azul", Colors.blue]);
cpES.parse('azul');
```

This will parse "azul" using the supplied Spanish language colors map.
