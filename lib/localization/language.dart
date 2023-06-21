import 'dart:ui';

import '../gen/assets.gen.dart';

enum Language {
  english(
    Locale('en', 'US'),
    Assets.english,
    'English',
  ),
  kiswahili(
    Locale('sw', 'KE'),
    Assets.swahili,
    'Swahili Kenya',
  );

  // Add aother language support here

  const Language(this.value, this.image, this.text);

  final Locale value;
  final AssetGenImage image;  // options: this property used for ListTile details
  final String text;  // Optional: this properties used for ListTile details
}
