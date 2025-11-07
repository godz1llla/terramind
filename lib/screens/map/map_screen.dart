import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:terramind/l10n/app_localizations.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:terramind/models/plot_model.dart';
import 'package:terramind/providers/plot_provider.dart';
import 'package:terramind/theme/app_theme.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final List<LatLng> _currentPolygonPoints = [];
  final List<Polygon> _polygons = [];
  final List<Marker> _markers = [];
  bool _isDrawingMode = false;

  // Координаты Кызылорды
  static const LatLng _kyzylordaCenter = LatLng(44.8526, 65.5092);

  @override
  void initState() {
    super.initState();
    _loadExistingPlots();
  }

  void _loadExistingPlots() {
    final plotProvider = Provider.of<PlotProvider>(context, listen: false);

    for (var plot in plotProvider.plots) {
      if (plot.coordinates.isNotEmpty && plot.coordinates.length >= 3) {
        final points = plot.coordinates
            .map((c) => LatLng(c.latitude, c.longitude))
            .toList();

        if (points.isNotEmpty && points.length >= 3) {
          _polygons.add(
            Polygon(
              points: points,
              color: AppTheme.primaryGreen.withOpacity(0.3),
              borderStrokeWidth: 3,
              borderColor: AppTheme.primaryGreen,
            ),
          );
        }
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng point) {
    if (!_isDrawingMode) return;

    setState(() {
      _currentPolygonPoints.add(point);
      _markers.add(
        Marker(
          point: point,
          width: 20,
          height: 20,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.accentOrange,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      );
    });
  }

  void _toggleDrawingMode() {
    setState(() {
      _isDrawingMode = !_isDrawingMode;
      if (!_isDrawingMode) {
        _currentPolygonPoints.clear();
        _markers.clear();
      }
    });
  }

  void _finishDrawing() {
    if (_currentPolygonPoints.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.mapMinPointsError),
        ),
      );
      return;
    }

    _showPlotNameDialog();
  }

  void _showPlotNameDialog() {
    final TextEditingController nameController = TextEditingController();
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.mapPlotNameTitle),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: loc.mapPlotNameHint,
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.commonCancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                _savePlot(nameController.text);
                Navigator.pop(context);
              }
            },
            child: Text(loc.commonSave),
          ),
        ],
      ),
    );
  }

  void _savePlot(String name) {
    final loc = AppLocalizations.of(context)!;
    final String plotId = DateTime.now().millisecondsSinceEpoch.toString();

    final coordinates = _currentPolygonPoints
        .map((point) => PlotCoordinate(
            latitude: point.latitude, longitude: point.longitude))
        .toList();

    final PlotModel newPlot = PlotModel(
      id: plotId,
      name: name,
      coordinates: coordinates,
    );

    Provider.of<PlotProvider>(context, listen: false).addPlot(newPlot);

    setState(() {
      if (_currentPolygonPoints.length >= 3) {
        _polygons.add(
          Polygon(
            points: List.from(_currentPolygonPoints),
            color: AppTheme.primaryGreen.withOpacity(0.3),
            borderStrokeWidth: 3,
            borderColor: AppTheme.primaryGreen,
          ),
        );
      }

      _currentPolygonPoints.clear();
      _markers.clear();
      _isDrawingMode = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.mapPlotCreated(name)),
        action: SnackBarAction(
          label: loc.mapPlotConfigure,
          onPressed: () => context.push('/plot-parameters?plotId=$plotId'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.mapTitle),
        actions: [
          if (_isDrawingMode && _currentPolygonPoints.isNotEmpty)
            TextButton.icon(
              onPressed: _finishDrawing,
              icon: const Icon(Icons.check, color: Colors.white),
              label: Text(
                loc.mapFinish,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _kyzylordaCenter,
              initialZoom: 13.0,
              onTap: _onMapTap,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.terramind.app',
                maxZoom: 19,
              ),
              PolygonLayer(
                polygons: [
                  ..._polygons,
                  if (_currentPolygonPoints.length >= 2)
                    Polygon(
                      points: _currentPolygonPoints,
                      color: AppTheme.accentOrange.withOpacity(0.3),
                      borderStrokeWidth: 2,
                      borderColor: AppTheme.accentOrange,
                    ),
                ],
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          ),

          // Drawing mode indicator
          if (_isDrawingMode)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Card(
                color: AppTheme.accentOrange,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.touch_app, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          loc.mapDrawingHint,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        loc.mapDrawingPoints(_currentPolygonPoints.length),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Attribution (required for OSM)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                loc.mapAttribution,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'map_draw_button',
            onPressed: _toggleDrawingMode,
            backgroundColor:
                _isDrawingMode ? AppTheme.accentOrange : AppTheme.primaryGreen,
            child: Icon(_isDrawingMode ? Icons.close : Icons.add_location),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'map_ai_button',
            onPressed: () => context.push('/recommendations'),
            backgroundColor: AppTheme.lightGreen,
            child: const Icon(Icons.psychology),
          ),
        ],
      ),
    );
  }
}
