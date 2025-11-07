import 'package:flutter/material.dart';
import 'package:terramind/theme/app_theme.dart';

class EcoDashboardScreen extends StatelessWidget {
  const EcoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой Эко-Вклад'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section с профилем
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
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
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Айгуль Сарсенова',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      const Text(
                        '4.8',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Рейтинг помощника',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Статистика
                  const Text(
                    'Ваша статистика',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          '800 л',
                          'Воды сэкономлено',
                          Icons.water_drop,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          '245 кг',
                          'CO₂ сокращено',
                          Icons.cloud,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          '142 кг',
                          'Урожай собран',
                          Icons.agriculture,
                          AppTheme.accentOrange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          '3',
                          'Активных участка',
                          Icons.map,
                          AppTheme.primaryGreen,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Достижения
                  const Text(
                    'Достижения',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildAchievementCard(
                    'Чемпион Урожая',
                    'Собрано более 100 кг урожая',
                    Icons.emoji_events,
                    Colors.amber,
                    true,
                  ),

                  _buildAchievementCard(
                    'Магистр Воды',
                    'Сэкономлено 500+ литров воды',
                    Icons.water_drop,
                    Colors.blue,
                    true,
                  ),

                  _buildAchievementCard(
                    'Эко-Воин',
                    'Сокращено 200+ кг CO₂',
                    Icons.eco,
                    Colors.green,
                    true,
                  ),

                  _buildAchievementCard(
                    'Картограф',
                    'Создано 5+ участков',
                    Icons.map,
                    Colors.grey,
                    false,
                    progress: 0.6,
                  ),

                  _buildAchievementCard(
                    'Помощник Сообщества',
                    'Помогли 50+ пользователям',
                    Icons.people,
                    Colors.grey,
                    false,
                    progress: 0.3,
                  ),

                  const SizedBox(height: 24),

                  // История участков
                  const Text(
                    'История участков',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildHistoryCard(
                    'Дача',
                    'Томаты',
                    'Посадка: 15 апреля',
                    'Урожай: 45 кг',
                  ),

                  _buildHistoryCard(
                    'Огород у дома',
                    'Дыня',
                    'Посадка: 1 мая',
                    'В процессе роста',
                  ),

                  _buildHistoryCard(
                    'Поле',
                    'Картофель',
                    'Посадка: 10 марта',
                    'Урожай: 97 кг',
                  ),

                  const SizedBox(height: 24),

                  // Уровень пользователя
                  Card(
                    color: AppTheme.primaryGreen,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Уровень 7',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Опытный Фермер',
                                  style: TextStyle(
                                    color: AppTheme.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: 0.65,
                              minHeight: 12,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'До уровня 8: 650 / 1000 XP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard(
    String title,
    String description,
    IconData icon,
    Color color,
    bool unlocked, {
    double? progress,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: unlocked ? null : Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: unlocked ? color.withOpacity(0.2) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: unlocked ? color : Colors.grey,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: unlocked ? Colors.black : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (!unlocked && progress != null) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (unlocked)
              const Icon(Icons.check_circle, color: Colors.green, size: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
    String plotName,
    String crop,
    String planting,
    String harvest,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.lightGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.grass, color: AppTheme.primaryGreen),
        ),
        title: Row(
          children: [
            Text(
              plotName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.accentOrange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                crop,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.accentOrange,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(planting),
            Text(harvest),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
