# bratacha

[![codecov](https://codecov.io/gh/defuncart/bratacha/branch/master/graph/badge.svg)](https://codecov.io/gh/defuncart/bratacha)

A fun flag quiz game as Gaeilge (and other languages)!

## About

*Bratacha* (Irish for flags) is an open source project targeting languages which are often ignored within the flag quiz space, for instance Irish, Welsh, Belarusian. English is also currently supported, while German and Polish may follow in the future.

Bratacha is apolitical. All flags adhere to full member states of the United Nations.

## Getting Started

If you would like to build the app yourself, then you simply need:

- Flutter >= 3.22
- Dart >= 3.4
- Xcode >= 15
- Cocoapods >= 1.13.0
- Android SDK >= 34
- Chrome

### Asset Generation

To generate the app icons, run:

```dart
dart run flutter_launcher_icons
```

To download flag assets, run:

```sh
dart bin/flag_downloader.dart
```

To generate database assets, run:

```sh
dart bin/db_importer.dart
```

## Contributing

If you'd like to help translating the app into Irish/Welsh/Belarusian, please get in touch! Likewise if you'd like to work on another language!

## Credits

Concept, Design and Programming by James Leahy.

Flags by [jackiboy](https://github.com/jackiboy/flagpack).
