import 'package:flutter/widgets.dart';

String localizedText(
  BuildContext context, {
  required String ru,
  required String kk,
}) {
  final code = Localizations.localeOf(context).languageCode;
  return code == 'kk' ? kk : ru;
}

