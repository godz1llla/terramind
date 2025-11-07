import 'package:flutter/material.dart';
import 'package:terramind/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:terramind/providers/language_provider.dart';
import 'package:terramind/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final languageCode = context.watch<LanguageProvider>().locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            initialValue: languageCode,
            onSelected: (code) {
              context.read<LanguageProvider>().setLocale(Locale(code));
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'ru',
                child: Row(
                  children: [
                    if (languageCode == 'ru') const Icon(Icons.check, size: 18),
                    if (languageCode == 'ru') const SizedBox(width: 8),
                    Text(loc.languageRussian),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'kk',
                child: Row(
                  children: [
                    if (languageCode == 'kk') const Icon(Icons.check, size: 18),
                    if (languageCode == 'kk') const SizedBox(width: 8),
                    Text(loc.languageKazakh),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/eco-dashboard'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hero Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGreen,
                      AppTheme.accentTeal,
                      AppTheme.lightGreen,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.homeWelcomeTitle,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      loc.homeWelcomeSubtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/map'),
                      icon: const Icon(Icons.map),
                      label: Text(loc.homeStartMap),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primaryGreen,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Features Grid
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.homeFeaturesTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: [
                        _buildFeatureCard(
                          context,
                          loc.homeFeatureMapTitle,
                          Icons.map,
                          loc.homeFeatureMapDescription,
                          AppTheme.primaryGreen,
                          () => context.push('/map'),
                        ),
                        _buildFeatureCard(
                          context,
                          loc.homeFeaturePlannerTitle,
                          Icons.grid_on,
                          loc.homeFeaturePlannerDescription,
                          AppTheme.accentAmber,
                          () => context.push('/garden-planner'),
                        ),
                        _buildFeatureCard(
                          context,
                          loc.homeFeatureAiTitle,
                          Icons.psychology,
                          loc.homeFeatureAiDescription,
                          AppTheme.accentPurple,
                          () => context.push('/recommendations'),
                        ),
                        _buildFeatureCard(
                          context,
                          loc.homeFeatureWikiTitle,
                          Icons.menu_book,
                          loc.homeFeatureWikiDescription,
                          AppTheme.accentBlue,
                          () => context.push('/wiki'),
                        ),
                        _buildFeatureCard(
                          context,
                          loc.homeFeatureCommunityTitle,
                          Icons.people,
                          loc.homeFeatureCommunityDescription,
                          AppTheme.accentTeal,
                          () => context.push('/community'),
                        ),
                        _buildFeatureCard(
                          context,
                          loc.homeFeatureEcoTitle,
                          Icons.eco,
                          loc.homeFeatureEcoDescription,
                          AppTheme.accentPink,
                          () => context.push('/eco-dashboard'),
                        ),
                        _buildFeatureCard(
                          context,
                          loc.homeFeatureMarketplaceTitle,
                          Icons.shopping_cart,
                          loc.homeFeatureMarketplaceDescription,
                          AppTheme.accentOrange,
                          () => context.push('/marketplace'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
