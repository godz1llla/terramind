import 'package:flutter/material.dart';
import 'package:terramind/theme/app_theme.dart';

class WikiScreen extends StatelessWidget {
  const WikiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TerraMind Wiki'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: AppTheme.primaryGreen,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'База Знаний',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Полезные статьи и видео от экспертов',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
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
                  // Категории
                  const Text(
                    'Категории',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildCategoryChip(
                          'Борьба с вредителями', Icons.bug_report),
                      _buildCategoryChip('Сорта для Кызылорды', Icons.place),
                      _buildCategoryChip('Техники полива', Icons.water_drop),
                      _buildCategoryChip('Органическое земледелие', Icons.eco),
                      _buildCategoryChip('Удобрения', Icons.science),
                      _buildCategoryChip('Болезни растений', Icons.healing),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Популярные статьи
                  const Text(
                    'Популярные статьи',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildArticleCard(
                    'Выращивание дынь в условиях Кызылорды',
                    'Полное руководство по выращиванию сладких дынь в аридном климате',
                    'Органическое земледелие',
                    '12 мин чтения',
                    4.8,
                    245,
                  ),

                  _buildArticleCard(
                    'Как бороться с тлей без химикатов',
                    'Органические методы борьбы с тлей: проверенные рецепты',
                    'Борьба с вредителями',
                    '8 мин чтения',
                    4.9,
                    432,
                  ),

                  _buildArticleCard(
                    'Капельное орошение своими руками',
                    'Пошаговая инструкция по созданию системы капельного орошения',
                    'Техники полива',
                    '15 мин чтения',
                    4.7,
                    318,
                  ),

                  _buildArticleCard(
                    'Определение типа почвы на участке',
                    'Простые методы определения типа почвы без лабораторных анализов',
                    'Почвоведение',
                    '6 мин чтения',
                    4.6,
                    189,
                  ),

                  const SizedBox(height: 24),

                  // Видео уроки
                  const Text(
                    'Видео уроки',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildVideoCard(
                    'Правильная обрезка томатов',
                    'Агроном Нурлан Жумабаев',
                    '12:34',
                  ),

                  _buildVideoCard(
                    'Севооборот для начинающих',
                    'TerraMind Academy',
                    '18:45',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      backgroundColor: AppTheme.lightGreen.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  Widget _buildArticleCard(
    String title,
    String description,
    String category,
    String readTime,
    double rating,
    int views,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentOrange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.accentOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(rating.toString()),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  readTime,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.visibility, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  '$views просмотров',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(String title, String author, String duration) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.play_circle_outline,
                    size: 48, color: Colors.white),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
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
                  const SizedBox(height: 4),
                  Text(
                    author,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
