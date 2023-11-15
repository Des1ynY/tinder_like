import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final Widget? child;

  const ImagePlaceholder({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(colors: [Colors.white, Colors.grey]),
      ),
      child: child,
    );
  }
}
