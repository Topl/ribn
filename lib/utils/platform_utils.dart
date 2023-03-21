// Dart imports:
import 'dart:io' show Platform;

// Flutter imports:
import 'package:flutter/foundation.dart';

String getPlatform() {
  if (kIsWeb) return "Web";

  switch (Platform.operatingSystem) {
    case "android":
      return "Android";
    case "ios":
      return "iOS";
    case "macos":
      return "MacOS";
    case "windows":
      return "Windows";
    case "linux":
      return "Linux";
    case "fuchsia":
      return "Fuchsia";
    default:
      return "Unknown";
  }
}
