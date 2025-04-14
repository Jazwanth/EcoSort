import 'package:flutter/material.dart';
import '../widgets/waste_category_card.dart';
import '../widgets/eco_stats_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoSort'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EcoStatsCard(),
            const SizedBox(height: 24),
            const Text(
              'Waste Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: const [
                WasteCategoryCard(
                  icon: Icons.recycling,
                  title: 'Recyclable',
                  color: Colors.blue,
                ),
                WasteCategoryCard(
                  icon: Icons.delete,
                  title: 'Non-Recyclable',
                  color: Colors.red,
                ),
                WasteCategoryCard(
                  icon: Icons.eco,
                  title: 'Organic',
                  color: Colors.green,
                ),
                WasteCategoryCard(
                  icon: Icons.warning,
                  title: 'Hazardous',
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Tip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Rinse food containers before recycling to prevent contamination and improve recycling efficiency.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement tip sharing
                      },
                      child: const Text('Share Tip'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 