import 'package:flutter/material.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_matching_page/user_matching_page.dart';
import 'package:tinder_like/src/shared/l10n/l10n.dart';

class TinderLikeApp extends StatefulWidget {
  const TinderLikeApp({super.key});

  @override
  State<TinderLikeApp> createState() => _TinderLikeAppState();
}

class _TinderLikeAppState extends State<TinderLikeApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => WidgetsBinding.instance.allowFirstFrame());
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: Locales.localizationsDelegates,
      supportedLocales: Locales.supportedLocales,
      home: UserMatchingPage(),
    );
  }
}
