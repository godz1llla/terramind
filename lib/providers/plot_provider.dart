import 'package:flutter/foundation.dart';
import 'package:terramind/models/plot_model.dart';

class PlotProvider with ChangeNotifier {
  final List<PlotModel> _plots = [];

  List<PlotModel> get plots => _plots;

  void addPlot(PlotModel plot) {
    _plots.add(plot);
    notifyListeners();
  }

  void updatePlot(String id, PlotModel updatedPlot) {
    final index = _plots.indexWhere((p) => p.id == id);
    if (index != -1) {
      _plots[index] = updatedPlot;
      notifyListeners();
    }
  }

  void removePlot(String id) {
    _plots.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  PlotModel? getPlotById(String id) {
    try {
      return _plots.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
