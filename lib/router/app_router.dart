import 'package:go_router/go_router.dart';
import 'package:terramind/screens/home/home_screen.dart';
import 'package:terramind/screens/map/map_screen.dart';
import 'package:terramind/screens/plot/plot_parameters_screen.dart';
import 'package:terramind/screens/planner/garden_planner_screen.dart';
import 'package:terramind/screens/recommendations/ai_recommendations_screen.dart';
import 'package:terramind/screens/wiki/wiki_screen.dart';
import 'package:terramind/screens/community/community_screen.dart';
import 'package:terramind/screens/profile/eco_dashboard_screen.dart';
import 'package:terramind/screens/marketplace/marketplace_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => const MapScreen(),
    ),
    GoRoute(
      path: '/plot-parameters',
      builder: (context, state) {
        final plotId = state.uri.queryParameters['plotId'];
        return PlotParametersScreen(plotId: plotId);
      },
    ),
    GoRoute(
      path: '/garden-planner',
      builder: (context, state) {
        final plotId = state.uri.queryParameters['plotId'];
        return GardenPlannerScreen(plotId: plotId);
      },
    ),
    GoRoute(
      path: '/recommendations',
      builder: (context, state) => const AIRecommendationsScreen(),
    ),
    GoRoute(
      path: '/wiki',
      builder: (context, state) => const WikiScreen(),
    ),
    GoRoute(
      path: '/community',
      builder: (context, state) => const CommunityScreen(),
    ),
    GoRoute(
      path: '/eco-dashboard',
      builder: (context, state) => const EcoDashboardScreen(),
    ),
    GoRoute(
      path: '/marketplace',
      builder: (context, state) => const MarketplaceScreen(),
    ),
  ],
);
