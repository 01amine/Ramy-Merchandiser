import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProcessedTextScreen extends StatelessWidget {
  const ProcessedTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int totalProducts = 5;
    int enemyProducts = 2;
    int friendlyProducts = totalProducts - enemyProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Analysis"),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        elevation: 5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Product Analysis",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                            "Product Family", "Pack Frutty Kids 20 CL"),
                        _buildDetailRow(
                            "Total Products", totalProducts.toString()),
                        _buildDetailRow("Enemy Products",
                            enemyProducts.toString(), Colors.red),
                        _buildDetailRow("Friendly Products",
                            friendlyProducts.toString(), Colors.green),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 30,
                      sections: [
                        PieChartSectionData(
                          value: friendlyProducts.toDouble(),
                          title: "$friendlyProducts",
                          color: Colors.green,
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: enemyProducts.toDouble(),
                          title: "$enemyProducts",
                          color: Colors.red,
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      label: "Approve",
                      icon: Icons.check_circle,
                      color: Colors.green,
                      onTap: () => _showResultPopup(context, true),
                    ),
                    _buildActionButton(
                      label: "Decline",
                      icon: Icons.cancel,
                      color: Colors.red,
                      onTap: () => _showResultPopup(context, false),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResultPopup(BuildContext context, bool isApproved) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isApproved ? Icons.check_circle : Icons.flag,
                  size: 60,
                  color: isApproved ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  isApproved ? "Approved!" : "Declined!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isApproved ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isApproved
                      ? "The product has been successfully approved."
                      : "The product has been declined.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isApproved ? Colors.green : Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child:
                      const Text("OK", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color ?? Colors.black)),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      {required String label,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: Icon(icon, size: 20, color: Colors.white),
      label: Text(label,
          style: const TextStyle(fontSize: 16, color: Colors.white)),
      onPressed: onTap,
    );
  }
}
