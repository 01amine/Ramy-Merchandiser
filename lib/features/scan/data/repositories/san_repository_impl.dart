



import '../../domain/entities/scan_results.dart';
import '../../domain/repository/scan_repository.dart';

class ScanRepositoryImpl implements ScanRepository {
  @override
  Future<void> saveScan(String imagePath, int quantity) async {
    // Implementation
  }
  
  @override
  Future<List<ScanResult>> getRecentScans() async {
    // Implementation
    return [];
  }
}