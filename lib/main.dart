import 'dart:async';
import 'dart:developer' as dev;

import 'package:tinder_like/runner_io.dart';

void main() {
  runZonedGuarded(
    $initializeApp,
    (e, st) => dev.log('Error occured in main zone', error: e, stackTrace: st),
  );
}
