
import '../repository/scan_repository.dart';

class PerformScan {
  final ScanRepository repository;
  
  PerformScan(this.repository);
  
  Future<void> call(String imagePath, int quantity) {
    return repository.saveScan(imagePath, quantity);
  }
}