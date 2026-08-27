import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppAnnotatedRegion extends StatelessWidget {
  final Widget child;

  const AppAnnotatedRegion({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.red,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: true,
      ),
      child: child,
    );
  }
}
