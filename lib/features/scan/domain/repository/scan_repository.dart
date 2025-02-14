

import '../entities/scan_results.dart';

abstract class ScanRepository {
  Future<void> saveScan(String imagePath, int quantity);
  Future<List<ScanResult>> getRecentScans();
}