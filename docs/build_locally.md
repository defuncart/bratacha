# Building Locally

If you would like to build the app yourself, the following are required:

- Flutter >= 3.22
- Dart >= 3.4
- Xcode >= 15
- Cocoapods >= 1.13.0
- Android SDK >= 34
- Chrome

## Asset Generation

To generate database assets, run:

```sh
dart bin/db_importer.dart
```

To generate localizations, run:

```sh
sh bin/loca_generate.sh
```

To generate app icons, run:

```sh
sh bin/app_icon_generate.sh
```

### Deprecated

[flagpack](https://github.com/jackiboy/flagpack) repository is now archived, with some flag fixes not on main. Running

```sh
dart bin/flag_downloader.dart
```

may override these local fixes.
