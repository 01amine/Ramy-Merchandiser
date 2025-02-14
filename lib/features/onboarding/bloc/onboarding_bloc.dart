import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final int totalSteps;

  int currentIndex = 0;

  OnboardingBloc(this.totalSteps) : super(OnboardingInitial()) {
    on<OnboardingNextEvent>((event, emit) {
      if (currentIndex < totalSteps - 1) {
        currentIndex++;
        emit(OnboardingStepChanged(currentIndex));
      }
    });

    on<OnboardingPreviousEvent>((event, emit) {
      if (currentIndex > 0) {
        currentIndex--;
        emit(OnboardingStepChanged(currentIndex));
      }
    });

    on<OnboardingSkipEvent>((event, emit) {
      currentIndex = totalSteps - 1;
      emit(OnboardingStepChanged(currentIndex));
    });
  }
}
