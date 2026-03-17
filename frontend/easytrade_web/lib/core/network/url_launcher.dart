import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  /// Launch a URL in the browser.
  static Future<void> launchUrlInBrowser(String url, {BuildContext? context}) async {
    final uri = Uri.tryParse(url);

    if (uri == null || !(uri.isAbsolute)) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid URL")),
        );
      }
      return;
    }

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not launch URL")),
        );
      }
    }
  }
}