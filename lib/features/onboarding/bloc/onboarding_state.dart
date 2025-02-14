abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingStepChanged extends OnboardingState {
  final int currentIndex;

  OnboardingStepChanged(this.currentIndex);
}
