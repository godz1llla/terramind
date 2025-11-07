import 'package:flutter/material.dart';
import 'package:terramind/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:terramind/models/plot_model.dart';
import 'package:terramind/providers/plot_provider.dart';
import 'package:terramind/theme/app_theme.dart';

class PlotParametersScreen extends StatefulWidget {
  final String? plotId;

  const PlotParametersScreen({super.key, this.plotId});

  @override
  State<PlotParametersScreen> createState() => _PlotParametersScreenState();
}

class _PlotParametersScreenState extends State<PlotParametersScreen> {
  PlotModel? _plot;
  String? _selectedCrop;
  String? _selectedSoilType;
  DateTime? _selectedDate;

  static const List<String> _cropIds = [
    'tomato',
    'cucumber',
    'melon',
    'watermelon',
    'potato',
    'carrot',
    'cabbage',
    'pepper',
    'eggplant',
    'onion',
    'garlic',
    'beet',
    'corn',
    'wheat',
    'rice',
    'apple',
    'grape',
  ];

  static const List<String> _soilIds = [
    'chernozem',
    'sandy',
    'clay',
    'loam',
    'peat',
    'lime',
    'saline',
  ];

  static const Map<String, String> _legacyCropTranslation = {
    'Томаты': 'tomato',
    'Огурцы': 'cucumber',
    'Дыня': 'melon',
    'Арбуз': 'watermelon',
    'Картофель': 'potato',
    'Морковь': 'carrot',
    'Капуста': 'cabbage',
    'Перец': 'pepper',
    'Баклажаны': 'eggplant',
    'Лук': 'onion',
    'Чеснок': 'garlic',
    'Свёкла': 'beet',
    'Кукуруза': 'corn',
    'Пшеница': 'wheat',
    'Рис': 'rice',
    'Яблоки': 'apple',
    'Виноград': 'grape',
  };

  static const Map<String, String> _legacySoilTranslation = {
    'Чернозём': 'chernozem',
    'Песчаная': 'sandy',
    'Глинистая': 'clay',
    'Суглинистая': 'loam',
    'Торфяная': 'peat',
    'Известковая': 'lime',
    'Солончаковая': 'saline',
  };

  @override
  void initState() {
    super.initState();
    if (widget.plotId != null) {
      final plotProvider = Provider.of<PlotProvider>(context, listen: false);
      _plot = plotProvider.getPlotById(widget.plotId!);
      if (_plot != null) {
        _selectedCrop = _normalizeCropValue(_plot!.crop);
        _selectedSoilType = _normalizeSoilValue(_plot!.soilType);
        _selectedDate = _plot!.plantingDate;
      }
    }
  }

  void _savePlotParameters() {
    final loc = AppLocalizations.of(context)!;
    if (_plot == null || _selectedCrop == null || _selectedSoilType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.plotValidationError),
        ),
      );
      return;
    }

    final updatedPlot = _plot!.copyWith(
      crop: _selectedCrop,
      soilType: _selectedSoilType,
      plantingDate: _selectedDate,
    );

    Provider.of<PlotProvider>(context, listen: false)
        .updatePlot(_plot!.id, updatedPlot);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(loc.plotSaved)),
    );

    // Переход к рекомендациям
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.plotSavedDialogTitle),
        content: Text(loc.plotSavedDialogQuestion),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/map');
            },
            child: Text(loc.commonLater),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/recommendations');
            },
            child: Text(loc.plotGetRecommendations),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: Localizations.localeOf(context),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String? _normalizeCropValue(String? value) {
    if (value == null) return null;
    if (_cropIds.contains(value)) return value;
    return _legacyCropTranslation[value] ?? value;
  }

  String? _normalizeSoilValue(String? value) {
    if (value == null) return null;
    if (_soilIds.contains(value)) return value;
    return _legacySoilTranslation[value] ?? value;
  }

  String _cropLabel(AppLocalizations loc, String id) {
    switch (id) {
      case 'tomato':
        return loc.cropTomato;
      case 'cucumber':
        return loc.cropCucumber;
      case 'melon':
        return loc.cropMelon;
      case 'watermelon':
        return loc.cropWatermelon;
      case 'potato':
        return loc.cropPotato;
      case 'carrot':
        return loc.cropCarrot;
      case 'cabbage':
        return loc.cropCabbage;
      case 'pepper':
        return loc.cropPepper;
      case 'eggplant':
        return loc.cropEggplant;
      case 'onion':
        return loc.cropOnion;
      case 'garlic':
        return loc.cropGarlic;
      case 'beet':
        return loc.cropBeet;
      case 'corn':
        return loc.cropCorn;
      case 'wheat':
        return loc.cropWheat;
      case 'rice':
        return loc.cropRice;
      case 'apple':
        return loc.cropApple;
      case 'grape':
        return loc.cropGrape;
      default:
        return id;
    }
  }

  String _soilLabel(AppLocalizations loc, String id) {
    switch (id) {
      case 'chernozem':
        return loc.soilChernozem;
      case 'sandy':
        return loc.soilSandy;
      case 'clay':
        return loc.soilClay;
      case 'loam':
        return loc.soilLoam;
      case 'peat':
        return loc.soilPeat;
      case 'lime':
        return loc.soilLime;
      case 'saline':
        return loc.soilSaline;
      default:
        return id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (_plot == null) {
      return Scaffold(
        appBar: AppBar(title: Text(loc.commonError)),
        body: Center(
          child: Text(loc.plotNotFound),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.plotSettingsTitle(_plot!.name)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.plotMainParameters,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Культура
                      Text(
                        loc.plotCropLabel,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedCrop,
                        decoration: InputDecoration(
                          hintText: loc.plotCropHint,
                          prefixIcon: const Icon(Icons.grass),
                        ),
                        items: _cropIds.map((id) {
                          return DropdownMenuItem(
                            value: id,
                            child: Text(_cropLabel(loc, id)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCrop = value;
                          });
                        },
                      ),

                      const SizedBox(height: 24),

                      // Тип почвы
                      Text(
                        loc.plotSoilLabel,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedSoilType,
                        decoration: InputDecoration(
                          hintText: loc.plotSoilHint,
                          prefixIcon: const Icon(Icons.terrain),
                        ),
                        items: _soilIds.map((id) {
                          return DropdownMenuItem(
                            value: id,
                            child: Text(_soilLabel(loc, id)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSoilType = value;
                          });
                        },
                      ),

                      const SizedBox(height: 24),

                      // Дата посадки
                      Text(
                        loc.plotPlantingDate,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _selectDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            _selectedDate != null
                                ? '${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}'
                                : loc.plotDatePlaceholder,
                            style: TextStyle(
                              color: _selectedDate != null
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Информационная карточка
              Card(
                color: AppTheme.lightGreen.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppTheme.primaryGreen,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          loc.plotInfoText,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Кнопка сохранения
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _savePlotParameters,
                  icon: const Icon(Icons.save),
                  label: Text(
                    loc.plotSaveButton,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
