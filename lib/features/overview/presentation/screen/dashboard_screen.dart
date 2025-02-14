import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../widgets/alert_card.dart';
import '../widgets/performance_card.dart';
import '../widgets/route_card.dart';


class DashboardScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  const DashboardScreen({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildNewScanButton(context),
                const SizedBox(height: 24),
                _buildPriorityAlerts(),
                const SizedBox(height: 24),
                _buildTodaysRoute(),
                const SizedBox(height: 24),
                _buildPerformanceSection(),
                const SizedBox(height: 80), // Space for bottom navigation
              ],
            ),
          ),
        ),
      ),
     
    );
  }

  Widget _buildNewScanButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navigateToScan(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'New Shelf Scan',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildPriorityAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Priority Alerts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        AlertCard(
          title: 'Low Stock Warning',
          description: '5 products below threshold',
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.orange,
          onDismiss: () {},
        ),
        const SizedBox(height: 12),
        AlertCard(
          title: 'Competitor Dominance',
          description: '3 stores affected',
          icon: Icons.trending_up,
          iconColor: Colors.red,
          onDismiss: () {},
        ),
      ],
    );
  }

  Widget _buildTodaysRoute() {
    return const RouteCard(
      storeCount: 12,
      subtitle: 'Stores to visit',
    );
  }

  Widget _buildPerformanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(
              child: PerformanceCard(
                value: '85%',
                label: 'Completion Rate',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: PerformanceCard(
                value: '92%',
                label: 'Accuracy',
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToScan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanScreen(cameras: cameras),
      ),
    );
  }
}

