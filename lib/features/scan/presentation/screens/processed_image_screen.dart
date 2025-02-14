import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProcessedImageScreen extends StatelessWidget {
  final String imagePath;

  const ProcessedImageScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    int totalProducts = 5;
    int enemyProducts = 2;
    int friendlyProducts = totalProducts - enemyProducts;

    return Scaffold(
      body: Column(
        children: [
          // Scanned Image
          Expanded(
            child: Stack(
              children: [
                Image.file(File(imagePath),
                    fit: BoxFit.cover, width: double.infinity),
                Container(
                  color: Colors.black.withOpacity(0.3),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    "Scanned Image",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Product Details & Chart
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Product Analysis",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                const SizedBox(height: 10),

                // Product Information Card
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("Product Family", "Pack Ramy 2 L"),
                        _buildDetailRow(
                            "Total Products", totalProducts.toString()),
                        _buildDetailRow("Rouiba Products",
                            enemyProducts.toString(), Colors.red),
                        _buildDetailRow("Touja Products",
                            friendlyProducts.toString(), Colors.green),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Pie Chart
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
                              color: Colors.white),
                        ),
                        PieChartSectionData(
                          value: enemyProducts.toDouble(),
                          title: "$enemyProducts",
                          color: Colors.red,
                          radius: 50,
                          titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Approve & Decline Buttons
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
        ],
      ),
    );
  }

  // Show Approval/Decline Popup & Navigate Back
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
                // Icon
                Icon(
                  isApproved ? Icons.check_circle : Icons.flag,
                  size: 60,
                  color: isApproved ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  isApproved ? "Approved!" : "Declined!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isApproved ? Colors.green : Colors.red),
                ),

                const SizedBox(height: 10),

                // Message
                Text(
                  isApproved
                      ? "The product has been successfully approved."
                      : "The product has been declined.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),

                const SizedBox(height: 20),

                // Close Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close popup
                    Navigator.pop(context); // Go back to scanner
                  },
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

  // Helper function to build product details row
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

  // Helper function to build action buttons
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
