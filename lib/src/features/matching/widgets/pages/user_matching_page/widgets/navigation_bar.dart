import 'package:flutter/material.dart';
import 'package:tinder_like/src/shared/theme/spacing.dart';

class UsersNavigationBar extends StatelessWidget {
  final PageController controller;

  const UsersNavigationBar({required this.controller, super.key});

  void _moveNext() => controller.nextPage(duration: slideDuration, curve: slideCurve);
  void _movePrevious() => controller.previousPage(duration: slideDuration, curve: slideCurve);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _NavigationButton(
            onPressed: _movePrevious,
            icon: Icons.arrow_back_ios,
          ),
        ),
        const SizedBox(width: Spacing.large),
        Expanded(
          child: _NavigationButton(
            onPressed: _moveNext,
            icon: Icons.arrow_forward_ios,
          ),
        ),
      ],
    );
  }

  static const slideDuration = Duration(milliseconds: 150);
  static const slideCurve = Curves.easeIn;
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _NavigationButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
