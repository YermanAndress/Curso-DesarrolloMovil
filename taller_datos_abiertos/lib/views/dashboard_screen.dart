import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos Abiertos Colombia'),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            CustomCard(
              title: 'Departamentos',
              description:
                  'Información detallada de los departamentos de Colombia',
              icon: Icons.map,
              color: Colors.blue,
              onTap: () => context.push(
                '/list?endpoint=departments&title=Departamentos',
              ),
            ),
            CustomCard(
              title: 'Presidentes',
              description: 'Historia de los presidentes de Colombia',
              icon: Icons.people,
              color: Colors.green,
              onTap: () =>
                  context.push('/list?endpoint=presidents&title=Presidentes'),
            ),
            CustomCard(
              title: 'Atractivos Turísticos',
              description: 'Lugares turísticos destacados de Colombia',
              icon: Icons.tour,
              color: Colors.orange,
              onTap: () => context.push(
                '/list?endpoint=tourist_attractions&title=Atractivos Turísticos',
              ),
            ),
            CustomCard(
              title: 'Platos Típicos',
              description: 'Gastronomía tradicional colombiana',
              icon: Icons.restaurant,
              color: Colors.red,
              onTap: () => context.push(
                '/list?endpoint=typical_dishes&title=Platos Típicos',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
