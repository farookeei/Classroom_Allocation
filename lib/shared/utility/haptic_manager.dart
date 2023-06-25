import 'dart:io';

import 'package:flutter/services.dart';

class HapticType {
  final String type;
  HapticType({required this.type});
}

class HapticManager {
  static HapticType light = HapticType(type: "light");
  static HapticType heavy = HapticType(type: "heavy");
  static HapticType medium = HapticType(type: "medium");

  static void vibrate({HapticType? haptic}) {
    (Platform.isIOS
        ? haptic != null
            ? haptic.type == "light"
                ? HapticFeedback.lightImpact
                : haptic.type == "heavy"
                    ? HapticFeedback.heavyImpact
                    : haptic.type == "medium"
                        ? HapticFeedback.mediumImpact
                        : HapticFeedback.lightImpact
            : HapticFeedback.lightImpact
        : HapticFeedback.vibrate)();
  }
}
