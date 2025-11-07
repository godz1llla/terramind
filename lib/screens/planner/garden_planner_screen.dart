import 'package:flutter/material.dart';
import 'package:terramind/theme/app_theme.dart';

class GardenPlannerScreen extends StatefulWidget {
  final String? plotId;

  const GardenPlannerScreen({super.key, this.plotId});

  @override
  State<GardenPlannerScreen> createState() => _GardenPlannerScreenState();
}

class _GardenPlannerScreenState extends State<GardenPlannerScreen> {
  final List<PlantedCrop> _plantedCrops = [];
  String? _selectedCrop;

  // Справочник культур с параметрами
  final Map<String, CropInfo> _cropDatabase = {
    'Томаты': CropInfo(
      name: 'Томаты',
      icon: Icons.spa,
      color: Colors.red,
      waterNeed: 40, // литров в неделю на кв.м
      spacing: 50, // см между растениями
      growthDays: 120,
    ),
    'Огурцы': CropInfo(
      name: 'Огурцы',
      icon: Icons.grass,
      color: Colors.green,
      waterNeed: 45,
      spacing: 40,
      growthDays: 60,
    ),
    'Картофель': CropInfo(
      name: 'Картофель',
      icon: Icons.grain,
      color: Colors.brown,
      waterNeed: 30,
      spacing: 35,
      growthDays: 90,
    ),
    'Морковь': CropInfo(
      name: 'Морковь',
      icon: Icons.eco,
      color: Colors.orange,
      waterNeed: 25,
      spacing: 10,
      growthDays: 80,
    ),
    'Капуста': CropInfo(
      name: 'Капуста',
      icon: Icons.spa_outlined,
      color: Colors.lightGreen,
      waterNeed: 50,
      spacing: 60,
      growthDays: 100,
    ),
    'Дыня': CropInfo(
      name: 'Дыня',
      icon: Icons.food_bank,
      color: Colors.yellow,
      waterNeed: 35,
      spacing: 100,
      growthDays: 90,
    ),
  };

  double _plotWidth = 10.0; // метры
  double _plotHeight = 8.0; // метры

  void _addCropToPlot(double x, double y) {
    if (_selectedCrop == null) return;

    setState(() {
      _plantedCrops.add(
        PlantedCrop(
          cropName: _selectedCrop!,
          x: x - 30,
          y: y - 30,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        ),
      );
      _selectedCrop = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$_selectedCrop добавлен на план'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalArea = _plotWidth * _plotHeight;
    final totalWaterPerWeek = _calculateTotalWater();
    final totalPlants = _plantedCrops.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Планировщик огорода'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: _showCalculations,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Размеры участка
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryGreen,
                    AppTheme.accentTeal,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Размеры участка',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDimensionInput('Ширина (м)', _plotWidth,
                            (val) {
                          setState(() => _plotWidth = val);
                        }),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDimensionInput('Длина (м)', _plotHeight,
                            (val) {
                          setState(() => _plotHeight = val);
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                            'Площадь', '${totalArea.toStringAsFixed(1)} м²'),
                        _buildStatItem('Растений', '$totalPlants'),
                        _buildStatItem('Полив/неделя',
                            '${totalWaterPerWeek.toStringAsFixed(0)} л'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Визуальный план огорода
                  const Text(
                    'План огорода',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  GestureDetector(
                    onTapDown: (details) {
                      if (_selectedCrop != null) {
                        final RenderBox box =
                            context.findRenderObject() as RenderBox;
                        final localPosition = details.localPosition;

                        // Проверяем что клик внутри контейнера
                        if (localPosition.dx >= 0 &&
                            localPosition.dx <= box.size.width &&
                            localPosition.dy >= 0 &&
                            localPosition.dy <= 350) {
                          _addCropToPlot(
                              localPosition.dx, localPosition.dy - 450);
                        }
                      }
                    },
                    child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedCrop != null
                              ? AppTheme.accentOrange
                              : Colors.grey.shade300,
                          width: _selectedCrop != null ? 3 : 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.brown.shade50,
                      ),
                      child: Stack(
                        children: [
                          // Сетка
                          CustomPaint(
                            size: const Size(double.infinity, 350),
                            painter: GridPainter(),
                          ),
                          // Размещенные культуры
                          ..._plantedCrops
                              .map((crop) => _buildPlantedCropWidget(crop)),
                          // Подсказка
                          if (_selectedCrop != null)
                            Positioned(
                              top: 10,
                              left: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentOrange,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Нажмите на план, чтобы разместить $_selectedCrop',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Выбор культуры для добавления
                  const Text(
                    'Добавить культуру',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _cropDatabase.entries.map((entry) {
                      return _buildCropChip(entry.value);
                    }).toList(),
                  ),

                  if (_selectedCrop != null) ...[
                    const SizedBox(height: 16),
                    Card(
                      color: AppTheme.accentOrange.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Добавить: $_selectedCrop',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                                'Нажмите на план огорода выше, чтобы разместить'),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () =>
                                  setState(() => _selectedCrop = null),
                              child: const Text('Отмена'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Расчёты и рекомендации
                  const Text(
                    'Расчёты и рекомендации',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildCalculationCard(
                    'Система полива',
                    'На основе размещенных культур',
                    Icons.water_drop,
                    AppTheme.accentBlue,
                    _buildWaterCalculation(),
                  ),

                  _buildCalculationCard(
                    'Севооборот',
                    'Что посадить в следующем сезоне',
                    Icons.autorenew,
                    AppTheme.accentTeal,
                    _buildRotationAdvice(),
                  ),

                  _buildCalculationCard(
                    'Совместимость растений',
                    'Какие культуры хорошо растут вместе',
                    Icons.people,
                    AppTheme.accentPurple,
                    _buildCompatibilityAdvice(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _plantedCrops.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _showCalculations,
              icon: const Icon(Icons.calculate),
              label: const Text('Полный расчёт'),
              backgroundColor: AppTheme.accentOrange,
            )
          : null,
    );
  }

  Widget _buildDimensionInput(
      String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (value > 1) onChanged(value - 1);
                },
              ),
              Expanded(
                child: Text(
                  value.toStringAsFixed(1),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (value < 100) onChanged(value + 1);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCropChip(CropInfo crop) {
    final isSelected = _selectedCrop == crop.name;

    return FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(crop.icon,
              size: 18, color: isSelected ? Colors.white : crop.color),
          const SizedBox(width: 8),
          Text(crop.name),
        ],
      ),
      onSelected: (selected) {
        setState(() {
          _selectedCrop = selected ? crop.name : null;
        });
      },
      selectedColor: crop.color,
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildPlantedCropWidget(PlantedCrop crop) {
    final cropInfo = _cropDatabase[crop.cropName]!;

    return Positioned(
      left: crop.x,
      top: crop.y,
      child: GestureDetector(
        onTap: () => _showCropDetails(crop),
        onLongPress: () => _removeCrop(crop),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: cropInfo.color.withOpacity(0.9),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(cropInfo.icon, color: Colors.white, size: 24),
              const SizedBox(height: 2),
              Text(
                crop.cropName[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalculationCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    Widget content,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildWaterCalculation() {
    if (_plantedCrops.isEmpty) {
      return const Text('Добавьте растения для расчёта полива');
    }

    final waterByDay = <String, double>{};
    for (var crop in _plantedCrops) {
      final info = _cropDatabase[crop.cropName]!;
      waterByDay['Понедельник'] =
          (waterByDay['Понедельник'] ?? 0) + info.waterNeed * 0.3;
      waterByDay['Четверг'] =
          (waterByDay['Четверг'] ?? 0) + info.waterNeed * 0.35;
      waterByDay['Воскресенье'] =
          (waterByDay['Воскресенье'] ?? 0) + info.waterNeed * 0.35;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'График полива на неделю:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...waterByDay.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    entry.key,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: (entry.value / 200).clamp(0.0, 1.0),
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppTheme.accentBlue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              '${entry.value.toStringAsFixed(0)} л',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.accentBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.water_drop, color: AppTheme.accentBlue),
              const SizedBox(width: 12),
              Text(
                'Общий объём: ${_calculateTotalWater().toStringAsFixed(0)} литров в неделю',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRotationAdvice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Рекомендации на следующий сезон:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildAdviceItem(
          'После томатов',
          'Посадите: Капусту, Огурцы, Морковь',
          Icons.arrow_forward,
          Colors.green,
        ),
        _buildAdviceItem(
          'После картофеля',
          'Посадите: Капусту, Бобовые, Морковь',
          Icons.arrow_forward,
          Colors.blue,
        ),
        _buildAdviceItem(
          'После капусты',
          'Посадите: Томаты, Картофель, Лук',
          Icons.arrow_forward,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildCompatibilityAdvice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Хорошие соседи:',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 8),
        _buildCompatibilityItem(
            '✓', 'Томаты + Базилик = Защита от вредителей', Colors.green),
        _buildCompatibilityItem('✓',
            'Морковь + Лук = Отпугивают вредителей друг друга', Colors.green),
        _buildCompatibilityItem(
            '✓', 'Огурцы + Укроп = Улучшение вкуса', Colors.green),
        const SizedBox(height: 16),
        const Text(
          'Плохие соседи:',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        const SizedBox(height: 8),
        _buildCompatibilityItem(
            '✗', 'Томаты + Картофель = Общие болезни', Colors.red),
        _buildCompatibilityItem(
            '✗', 'Огурцы + Томаты = Конкуренция за свет', Colors.red),
      ],
    );
  }

  Widget _buildAdviceItem(
      String title, String advice, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  advice,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompatibilityItem(String mark, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            mark,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  double _calculateTotalWater() {
    double total = 0;
    for (var crop in _plantedCrops) {
      final info = _cropDatabase[crop.cropName]!;
      total += info.waterNeed;
    }
    return total;
  }

  void _showCropDetails(PlantedCrop crop) {
    final info = _cropDatabase[crop.cropName]!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(info.icon, color: info.color),
            const SizedBox(width: 12),
            Text(crop.cropName),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Полив в неделю', '${info.waterNeed} л/м²'),
            _buildDetailRow('Расстояние', '${info.spacing} см'),
            _buildDetailRow('Срок созревания', '${info.growthDays} дней'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeCrop(crop);
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }

  void _removeCrop(PlantedCrop crop) {
    setState(() {
      _plantedCrops.remove(crop);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${crop.cropName} удалён')),
    );
  }

  void _showCalculations() {
    final totalWater = _calculateTotalWater();
    final totalArea = _plotWidth * _plotHeight;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Полный расчёт огорода',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildCalcSection('Общие параметры', [
                'Площадь участка: ${totalArea.toStringAsFixed(1)} м²',
                'Количество культур: ${_plantedCrops.length}',
                'Уникальных видов: ${_cropDatabase.keys.where((k) => _plantedCrops.any((p) => p.cropName == k)).length}',
              ]),
              _buildCalcSection('Потребность в воде', [
                'В неделю: ${totalWater.toStringAsFixed(0)} литров',
                'В месяц: ${(totalWater * 4.3).toStringAsFixed(0)} литров',
                'За сезон (4 мес): ${(totalWater * 17).toStringAsFixed(0)} литров',
              ]),
              _buildCalcSection('Экономия с капельным поливом', [
                'Традиционный полив: ${(totalWater * 1.5).toStringAsFixed(0)} л/неделя',
                'Капельный полив: ${totalWater.toStringAsFixed(0)} л/неделя',
                'Экономия: ${(totalWater * 0.5).toStringAsFixed(0)} л/неделя (33%)',
              ]),
              _buildCalcSection('Ожидаемый урожай (прогноз)', [
                'Томаты: ${_plantedCrops.where((c) => c.cropName == 'Томаты').length * 4} кг',
                'Огурцы: ${_plantedCrops.where((c) => c.cropName == 'Огурцы').length * 3} кг',
                'Картофель: ${_plantedCrops.where((c) => c.cropName == 'Картофель').length * 2} кг',
              ]),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check),
                  label: const Text('Понятно'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalcSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.check,
                      size: 16, color: AppTheme.primaryGreen),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
        const SizedBox(height: 16),
      ],
    );
  }
}

// Модель для размещенной культуры
class PlantedCrop {
  final String cropName;
  final double x;
  final double y;
  final String id;

  PlantedCrop({
    required this.cropName,
    required this.x,
    required this.y,
    required this.id,
  });
}

// Информация о культуре
class CropInfo {
  final String name;
  final IconData icon;
  final Color color;
  final double waterNeed; // литров в неделю на растение
  final int spacing; // см между растениями
  final int growthDays; // дней до урожая

  CropInfo({
    required this.name,
    required this.icon,
    required this.color,
    required this.waterNeed,
    required this.spacing,
    required this.growthDays,
  });
}

// Рисовальщик сетки
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    // Вертикальные линии
    for (int i = 0; i <= 10; i++) {
      final x = (size.width / 10) * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Горизонтальные линии
    for (int i = 0; i <= 10; i++) {
      final y = (size.height / 10) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
