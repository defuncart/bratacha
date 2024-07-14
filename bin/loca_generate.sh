#!/usr/bin/env bash

# generate from csv
fvm dart pub get --offline
fvm dart run arb_generator

# generate localization delegates
fvm flutter pub get --offline
