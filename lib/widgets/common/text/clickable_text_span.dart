import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// A TextSpan which is clickable and opens a given url
class ClickableTextSpan extends TextSpan {
  /// Constructs a new instance of `ClickableTextSpan`
  ///
  /// [text] and [url] are required.
  /// [style] is optional. If not given, default from theme will be used.
  ClickableTextSpan({
    required String super.text,
    required String url,
    super.style,
  }) : super(
          recognizer: TapGestureRecognizer()..onTap = () async => await _openUrl(url),
        );

  static Future<void> _openUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }
}
