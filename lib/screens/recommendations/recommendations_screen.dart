import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:terramind/theme/app_theme.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI-Рекомендации'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Обновление рекомендаций...'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section с погодой
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryGreen,
                    AppTheme.lightGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Кызылорда',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.wb_sunny, color: Colors.white, size: 32),
                          SizedBox(width: 8),
                          Text(
                            '28°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Влажность: 45% | Ветер: 12 км/ч',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Срочные рекомендации
                  const Text(
                    'Срочные рекомендации',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildUrgentCard(
                    context,
                    'Идеальный день для полива',
                    'Сегодня оптимальная температура и влажность для полива томатов на участке "Дача"',
                    Icons.water_drop,
                    Colors.blue,
                    'high',
                  ),

                  _buildUrgentCard(
                    context,
                    'Предупреждение о заморозках',
                    'Через 3 дня ожидаются заморозки до -2°C. Рекомендуем укрыть ваши томаты!',
                    Icons.ac_unit,
                    Colors.orange,
                    'critical',
                  ),

                  const SizedBox(height: 24),

                  // Рекомендации по уходу
                  const Text(
                    'Рекомендации по уходу',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildRecommendationCard(
                    context,
                    'Подкормка азотом',
                    'Вашим растениям не хватает азота. Рекомендуем подкормку.',
                    'Анализ показал, что текущая стадия вегетации томатов требует дополнительного питания. Используйте мочевину (карбамид) 20-30г на 10л воды.',
                    Icons.science,
                    AppTheme.accentOrange,
                    hasAction: true,
                  ),

                  _buildRecommendationCard(
                    context,
                    'Профилактика болезней',
                    'Высокая влажность увеличивает риск фитофтороза',
                    'Рекомендуем профилактическую обработку фунгицидами. Используйте бордоскую жидкость 1% раствор.',
                    Icons.health_and_safety,
                    Colors.red,
                    hasAction: false,
                  ),

                  _buildRecommendationCard(
                    context,
                    'Оптимальное время сбора урожая',
                    'Через 14 дней начнется оптимальный период сбора дынь',
                    'На основе даты посадки и текущих погодных условий AI рассчитал, что ваши дыни достигнут полной зрелости к 21 октября.',
                    Icons.calendar_month,
                    AppTheme.lightGreen,
                    hasAction: false,
                  ),

                  const SizedBox(height: 24),

                  // Полезные статьи
                  const Text(
                    'Полезные статьи из базы знаний',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildArticleCard(
                    context,
                    'Как правильно поливать томаты в жаркую погоду',
                    'TerraMind Wiki • 5 мин чтения',
                  ),

                  _buildArticleCard(
                    context,
                    'Борьба с вредителями: органические методы',
                    'TerraMind Wiki • 8 мин чтения',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUrgentCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    String priority,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (priority == 'critical')
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'СРОЧНО',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(BuildContext context, String title,
      String subtitle, String description, IconData icon, Color color,
      {bool hasAction = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            if (hasAction) ...[
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => context.push('/marketplace'),
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Купить удобрение'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentOrange,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, String title, String meta) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.menu_book, color: AppTheme.primaryGreen),
        ),
        title: Text(title),
        subtitle: Text(meta),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => context.push('/wiki'),
      ),
    );
  }
}
