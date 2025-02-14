import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/card.dart';
import '../../domain/entities/stat.dart';

// Bloc Events
abstract class ProgressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProgress extends ProgressEvent {}

// Bloc States
abstract class ProgressState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final List<ProgressCard> cards;
  final ProductivityStats stats;

  ProgressLoaded({required this.cards, required this.stats});

  @override
  List<Object> get props => [cards, stats];
}

class ProgressError extends ProgressState {
  final String message;
  ProgressError({required this.message});
}

// Bloc Logic
class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(ProgressLoading()) {
    on<LoadProgress>((event, emit) async {
      try {
        // Simulated Data Fetching
        await Future.delayed(Duration(seconds: 1));

        List<ProgressCard> cards = [
          ProgressCard(title: "Day 5", progress: 0.85, date: "Feb 14"),
          ProgressCard(title: "Day 4", progress: 0.72, date: "Feb 13"),
          ProgressCard(title: "Day 3", progress: 0.60, date: "Feb 12"),
        ];

        ProductivityStats stats = ProductivityStats(
          completedTasks: 8,
          totalTasks: 10,
          focusTime: 5.2,
          distractions: 20.0,
        );

        emit(ProgressLoaded(cards: cards, stats: stats));
      } catch (e) {
        emit(ProgressError(message: e.toString()));
      }
    });
  }
}
