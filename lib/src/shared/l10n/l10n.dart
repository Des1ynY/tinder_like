import 'package:flutter/widgets.dart';
import 'package:tinder_like/src/shared/l10n/gen/app_localizations.dart';

export 'gen/app_localizations.dart';

extension LocalesGetter on BuildContext {
  Locales get locales => Locales.of(this);
}
