dart run dart_code_coverage:generate_dart_file -r ".*\.g\.dart","localizations.dart","generated_plugin_registrant.dart"

flutter test --coverage --exclude-tags app_store_screenshots

dart run dart_code_coverage:edit_lcov -r ".*\.g\.dart","localizations.dart","app_icon.dart"

genhtml coverage/lcov.info -o coverage/html
