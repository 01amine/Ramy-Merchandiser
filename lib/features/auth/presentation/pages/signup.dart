import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ramy/shared/utils/dep_inj.dart';

import '../../data/models/signup_req_params.dart';
import '../../domain/usecases/signup.dart';
import '../cubit/button/button_state.dart';
import '../cubit/button/button_state_cubit.dart';
import 'signin.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _nomCon = TextEditingController();
  final TextEditingController _prenomCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _dateCon = TextEditingController();
  final TextEditingController _sexeCon = TextEditingController();
  final TextEditingController _numCartCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _verifpasswordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget dateDeNaissancelField() {
      return TextField(
        controller: _dateCon,
        readOnly: true,
        decoration: const InputDecoration(
          hintText: 'Date De Naissance',
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            _dateCon.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          }
        },
      );
    }

    return Scaffold(
      body: BlocProvider(
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
            minimum: const EdgeInsets.only(
                top: 100, right: 16, left: 16, bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _signup(),
                  const SizedBox(
                    height: 50,
                  ),
                  _nameField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _prenomField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _emailField(),
                  const SizedBox(
                    height: 20,
                  ),
                  dateDeNaissancelField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _sexeField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _numeroCarteEdantiteField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _passwordField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _verifyPasswordField(),
                  const SizedBox(
                    height: 60,
                  ),
                  _createAccountButton(context),
                  const SizedBox(
                    height: 20,
                  ),
                  _signinText(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signup() {
    return Text(
      'Sign Up',
      style: GoogleFonts.inter(
          color: Color(0xff495CF5), fontWeight: FontWeight.bold, fontSize: 42),
    );
  }

  Widget _nameField() {
    return TextField(
      controller: _nomCon,
      decoration: const InputDecoration(hintText: 'Nom'),
    );
  }

  Widget _prenomField() {
    return TextField(
      controller: _prenomCon,
      decoration: const InputDecoration(hintText: 'Prénom'),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _sexeField() {
    return TextField(
      controller: _sexeCon,
      decoration: const InputDecoration(hintText: 'Sexe'),
    );
  }

  Widget _numeroCarteEdantiteField() {
    return TextField(
      controller: _numCartCon,
      decoration: const InputDecoration(hintText: 'Numero Carte Edentite'),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordCon,
      decoration: const InputDecoration(hintText: 'Mot De Pass'),
    );
  }

  Widget _verifyPasswordField() {
    return TextField(
      controller: _verifpasswordCon,
      decoration: const InputDecoration(hintText: 'Verifier Le Mot De Pass'),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialButton(
        child: Text('Create Account'),
        onPressed: () {
          if (_passwordCon.text != _verifpasswordCon.text) {
            var snackBar = const SnackBar(
              content: Text('Passwords do not match!'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }

          context.read<ButtonStateCubit>().excute(
                usecase: DepInj.sl<SignupUseCase>(),
                params: SignupReqParams(
                  nom: _nomCon.text,
                  prenom: _prenomCon.text,
                  email: _emailCon.text,
                  date_naissance: _dateCon.text,
                  sexe: _sexeCon.text,
                  numero_carte_identite: _numCartCon.text,
                  password: _passwordCon.text,
                  permission_parentale: false,
                ),
              );
        },
      );
    });
  }

  Widget _signinText(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(
            text: 'Do you have account?',
            style: TextStyle(
                color: Color(0xff3B4054), fontWeight: FontWeight.w500)),
        TextSpan(
            text: ' Sign In',
            style: const TextStyle(
                color: Color(0xff3461FD), fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninPage(),
                    ));
              })
      ]),
    );
  }
}
