import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/utils/app_images.dart';

class GlobalLoader {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static OverlayEntry? _overlayEntry;

  static void show() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) => Container(
        color: Colors.black45,
        alignment: Alignment.center,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(AppImages.loader),
        ),
      ),
    );

    navigatorKey.currentState?.overlay?.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
