#!/usr/bin/env bash

fvm flutter test test/widgets/common/icons/app_icon_test.dart --no-pub --update-goldens --tags app_store_screenshots
fvm flutter test test/design_assets --no-pub --update-goldens --tags app_store_screenshots

fvm dart run flutter_launcher_icons
