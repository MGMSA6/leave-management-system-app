import 'package:flutter/material.dart';

import '../../core/utils/app_images.dart';

class LoaderOverlay extends StatelessWidget {
  const LoaderOverlay({super.key});

  static final _loaderKey = GlobalKey<_LoaderOverlayState>();

  static void show() => _loaderKey.currentState?.show();

  static void hide() => _loaderKey.currentState?.hide();

  @override
  Widget build(BuildContext context) {
    return _LoaderOverlay(key: _loaderKey);
  }
}

class _LoaderOverlay extends StatefulWidget {
  const _LoaderOverlay({super.key});

  @override
  State<_LoaderOverlay> createState() => _LoaderOverlayState();
}

class _LoaderOverlayState extends State<_LoaderOverlay> {
  bool _isVisible = false;

  void show() => setState(() => _isVisible = true);

  void hide() => setState(() => _isVisible = false);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !_isVisible,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          color: Colors.black45,
          child: Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset(AppImages.loader),
            ),
          ),
        ),
      ),
    );
  }
}
