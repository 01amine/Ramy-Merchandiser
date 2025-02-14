
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/perform_scan.dart';


// Events
abstract class ScanEvent {}

class StartScan extends ScanEvent {}
class CaptureImage extends ScanEvent {}
class StartVoiceCount extends ScanEvent {}

// States
abstract class ScanState {}

class ScanInitial extends ScanState {}
class ScanInProgress extends ScanState {}
class ScanComplete extends ScanState {}
class ScanError extends ScanState {
  final String message;
  ScanError(this.message);
}

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final PerformScan performScan;
  
  ScanBloc(this.performScan) : super(ScanInitial()) {
    on<StartScan>(_onStartScan);
    on<CaptureImage>(_onCaptureImage);
    on<StartVoiceCount>(_onStartVoiceCount);
  }
  
  void _onStartScan(StartScan event, Emitter<ScanState> emit) {
    // Implementation
  }
  
  void _onCaptureImage(CaptureImage event, Emitter<ScanState> emit) {
    // Implementation
  }
  
  void _onStartVoiceCount(StartVoiceCount event, Emitter<ScanState> emit) {
    // Implementation
  }
}
