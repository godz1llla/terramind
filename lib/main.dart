import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terramind/l10n/app_localizations.dart';
import 'package:terramind/providers/plot_provider.dart';
import 'package:terramind/providers/language_provider.dart';
import 'package:terramind/router/app_router.dart';
import 'package:terramind/theme/app_theme.dart';

void main() {
  runApp(const TerraMindApp());
}

class TerraMindApp extends StatelessWidget {
  const TerraMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlotProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return MaterialApp.router(
            title: 'TerraMind',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            locale: languageProvider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          );
        },
      ),
    );
  }
}
