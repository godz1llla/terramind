import 'package:flutter/material.dart';
import 'package:terramind/theme/app_theme.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Сообщество'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'SOS-Лента'),
              Tab(text: 'Группы'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _SOSFeedTab(),
            _GroupsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Показываем диалог создания поста
          },
          icon: const Icon(Icons.add),
          label: const Text('Создать пост'),
        ),
      ),
    );
  }
}

class _SOSFeedTab extends StatelessWidget {
  const _SOSFeedTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSOSPost(
            userName: 'Айгуль Сарсенова',
            userRating: 4.8,
            timeAgo: '2 часа назад',
            location: 'Кызылорда',
            title: 'Что с моими огурцами?',
            description:
                'Листья начали желтеть и скручиваться. Поливаю каждый день. Что делать?',
            hasImage: true,
            commentsCount: 12,
            likesCount: 8,
          ),
          _buildSOSPost(
            userName: 'Ержан Нурмаганбетов',
            userRating: 4.5,
            timeAgo: '5 часов назад',
            location: 'Кызылорда',
            title: 'Помогите определить вредителя',
            description:
                'На томатах появились странные насекомые. Прикладываю фото. Кто это и как бороться?',
            hasImage: true,
            commentsCount: 24,
            likesCount: 15,
          ),
          _buildSOSPost(
            userName: 'Гульнара Касымова',
            userRating: 4.9,
            timeAgo: '1 день назад',
            location: 'Шиели',
            title: 'Дыни не растут',
            description:
                'Посадила дыни месяц назад, но они почти не растут. Удобряла навозом. В чем может быть проблема?',
            hasImage: false,
            commentsCount: 18,
            likesCount: 11,
          ),
        ],
      ),
    );
  }

  static Widget _buildSOSPost({
    required String userName,
    required double userRating,
    required String timeAgo,
    required String location,
    required String title,
    required String description,
    required bool hasImage,
    required int commentsCount,
    required int likesCount,
  }) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User header
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.primaryGreen,
              child: Text(
                userName[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Row(
              children: [
                Text(
                  userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                Text(
                  userRating.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.place, size: 14),
                const SizedBox(width: 4),
                Text(location),
                const SizedBox(width: 8),
                Text('• $timeAgo'),
              ],
            ),
          ),

          // Post content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
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
                Text(description),
              ],
            ),
          ),

          // Image placeholder
          if (hasImage)
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 64, color: Colors.grey.shade500),
                  const SizedBox(height: 8),
                  Text(
                    'Фото растения',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up_outlined),
                  label: Text('$likesCount'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined),
                  label: Text('$commentsCount'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('Помочь'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupsTab extends StatelessWidget {
  const _GroupsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Популярные группы',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildGroupCard(
              name: 'Дыневоды Кызылорды',
              description: 'Всё о выращивании дынь в нашем регионе',
              membersCount: 1248,
              postsCount: 342,
              category: 'Культуры',
            ),
            _buildGroupCard(
              name: 'Органическое земледелие КЗ',
              description: 'Выращиваем без химии',
              membersCount: 3521,
              postsCount: 891,
              category: 'Методы',
            ),
            _buildGroupCard(
              name: 'Новички в земледелии',
              description: 'Задавайте любые вопросы, поможем разобраться',
              membersCount: 5234,
              postsCount: 1543,
              category: 'Обучение',
            ),
            _buildGroupCard(
              name: 'Садоводы Южного Казахстана',
              description: 'Фруктовые сады и виноградники',
              membersCount: 892,
              postsCount: 234,
              category: 'Регион',
            ),
            _buildGroupCard(
              name: 'Борьба с вредителями',
              description: 'Делимся опытом защиты растений',
              membersCount: 2156,
              postsCount: 678,
              category: 'Защита',
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildGroupCard({
    required String name,
    required String description,
    required int membersCount,
    required int postsCount,
    required String category,
  }) {
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
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.group,
                    color: AppTheme.primaryGreen,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.accentOrange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          category,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.accentOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(description),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.people, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  '$membersCount участников',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(width: 16),
                Icon(Icons.article, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  '$postsCount постов',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Вступить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
