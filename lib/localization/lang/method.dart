import 'package:flutter/material.dart';
import 'package:tracker_payment/localization/lang/app_localization.dart';

Locale local(String languageCode) {
  switch (languageCode) {
    case 'en':
      return const Locale('en', 'US');
    default:
      return const Locale('en', 'US');
  }
}

String? getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context)?.translate(key);
}

Map<String, String>? localizedMap(BuildContext context) {
  return AppLocalization.of(context)!.localizedMap();
}
