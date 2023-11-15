import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tinder_like/src/shared/l10n/l10n.dart';

abstract final class ErrorUtil {
  static String localeError(BuildContext context, Object error) {
    return switch (error) {
      final SocketException _ => context.locales.error_network_connection,
      _ => context.locales.error_unknown,
    };
  }
}
