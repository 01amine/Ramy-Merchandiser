import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramy/shared/utils/persist_data.dart';

import '../../auth/presentation/pages/signin.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../model/model.dart';

class OnboardingScreen extends StatelessWidget {
  final List<OnboardingModel> pages = [
    OnboardingModel(
        title: "Bienvenue dans Ramy",
        description:
            "Commencez votre adventure de Mechandising!",
        imagePath: 'assets/onBoardingPhone1.png'),
    OnboardingModel(
        title: "Trouvez les meilleurs points de ventes",
        description:
            "Explorez les meilleurs supperettes, malles, et sites de ventes en Algérie",
        imagePath: 'assets/onBoardingPhone4.png'),
    OnboardingModel(
        title: "Découvrez des destinations incroyables",
        description:
            "Accédez à des informations détaillées sur les hôtels, auberges, et complexes touristiques",
        imagePath: 'assets/onBoardingPhone2.png'),
    OnboardingModel(
        title: "Analyse des produits rapidement",
        description:
            "Notre IA vous aide à optimizez votre travail",
        imagePath: 'assets/onBoardingPhone5.png'),
    OnboardingModel(
        title: "Scanner les produits facilement",
        description: "Automatiser le processus avec une click de button",
        imagePath: 'assets/onBoardingPhone3.png'),
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void completeOnboarding(BuildContext context) async {
      final prefs = await PersistData.isNew;
      if (prefs) {
        await PersistData.getStarted();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SigninPage()),
      );
    }

    return BlocProvider(
      create: (_) => OnboardingBloc(pages.length),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            final bloc = context.read<OnboardingBloc>();
            final currentIndex =
                state is OnboardingStepChanged ? state.currentIndex : 0;

            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Image.asset(pages[currentIndex].imagePath),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Color(0xff495CF5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          pages[currentIndex].title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Text(
                          pages[currentIndex].description,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (currentIndex > 0 &&
                                currentIndex != pages.length - 1)
                              TextButton(
                                onPressed: () {
                                  completeOnboarding(
                                      context); // Call the completion function
                                },
                                child: Text(
                                  "Skip",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            if (currentIndex > 0 &&
                                currentIndex != pages.length - 1)
                              Row(
                                children: List.generate(
                                  pages.length,
                                  (index) {
                                    final isActive =
                                        state is OnboardingStepChanged &&
                                            state.currentIndex == index;
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      width: isActive ? 12 : 8,
                                      height: isActive ? 12 : 8,
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? Colors.white
                                            : Colors.white54,
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            if (currentIndex < pages.length - 1)
                              TextButton(
                                onPressed: () {
                                  bloc.add(OnboardingNextEvent());
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                        if (currentIndex == pages.length - 1)
                          MaterialButton(
                            elevation: 1,
                            minWidth: 300,
                            color: Color(0xffE76F51),
                            onPressed: () {
                              completeOnboarding(context);
                            },
                            child: Text(
                              "Commancer!",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
