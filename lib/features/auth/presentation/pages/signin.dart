import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramy/features/auth/presentation/pages/signup.dart';
import 'package:ramy/features/home/screens/home_screen.dart';
import 'package:ramy/shared/utils/dep_inj.dart';

import '../../data/models/signin_req_params.dart';
import '../../domain/usecases/signin.dart';
import '../cubit/button/button_state.dart';
import '../cubit/button/button_state_cubit.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonSuccessState) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Scaffold(),
                    ));
              }
              if (state is ButtonFailureState) {
                var snackBar = SnackBar(content: Text(state.errorMessage));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: SafeArea(
              minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _signin(),
                  const SizedBox(
                    height: 50,
                  ),
                  _emailField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _password(),
                  const SizedBox(
                    height: 60,
                  ),
                  _createAccountButton(context),
                  const SizedBox(
                    height: 20,
                  ),
                  _signupText(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signin() {
    return Text(
      'Sign In',
      style: GoogleFonts.inter(
          color: Color(0xff495CF5), fontWeight: FontWeight.bold, fontSize: 42),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _password() {
    return TextField(
      obscureText: true,
      controller: _passwordCon,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialButton(
          child: Text('Login'),
          onPressed: () {
            context.read<ButtonStateCubit>().excute(
                usecase: DepInj.sl<SigninUseCase>(),
                params: SigninReqParams(
                    email: _emailCon.text, password: _passwordCon.text));
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          });
    });
  }

  Widget _signupText(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(
            text: "Don't you have account?",
            style: TextStyle(
                color: Color(0xff3B4054), fontWeight: FontWeight.w500)),
        TextSpan(
            text: ' Sign Up',
            style: const TextStyle(
                color: Color(0xff3461FD), fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ));
              })
      ]),
    );
  }
}
