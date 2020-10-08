# bratacha

A fun flag quiz game as Gaeilge (and other languages)!

## About

*Bratacha* (Irish for flags) is an open source project targeting languages which are often ignored within the flag quiz space, for instance Irish, Welsh, Belarusian. English is also be supported, while German and Polish will follow in the future.

Note that only flags of countries recognized by the UN are present.

## Getting Started

If you would like to build the app yourself, then you simply need:

- Flutter >= 1.22
- Dart >= 2.10
- Xcode >= 11.5
- Android SDK >= 29.0.4
- Chrome

### Asset Generation

To generate the app icons, run:

```dart
flutter pub run flutter_launcher_icons:main
```

To download flag assets, run:

```sh
dart bin/flag_downloader.dart
```

To generate database assets, run:

```sh
dart bin/db_importer.dart
```

To generate default player data database, run:

```sh
dart bin/player_data_exporter.dart
```

## Contributing

If you'd like to help translating the app into Irish/Welsh/Belarusian, please get in touch! Likewise if you'd like to work on another language!

## Credits

Concept, Design and Programming by James Leahy.

Flags by [jackiboy](https://github.com/jackiboy/flagpack).
