import 'package:bloc_firebase_test/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is NavigateToSignInState) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/signIn', (Route<dynamic> route) => false);
          context.read<SignUpBloc>().add(ResetSignUpStateEvent());
        } else if (state is ShowSnackBarState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is SuccessfulSignUpState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is SignUpInitialState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Sign up'),
              actions: [
                TextButton(
                    onPressed: () {
                      context
                          .read<SignUpBloc>()
                          .add(SignInNavigateButtonClickedEvent());
                    },
                    child: Text('Sign in'))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: emailTextEditingController,
                      decoration: InputDecoration(hintText: 'email'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      decoration: InputDecoration(hintText: 'password'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<SignUpBloc>().add(
                              SignUpButtonClickedEvent(
                                  email: emailTextEditingController.text,
                                  password:
                                      passwordTextEditingController.text));
                        },
                        child: Text('Sign up')),
                  ]),
            ),
          );
        } else if (state is SignUpLoadingState) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text('There is no any state known'),
            ),
          );
        }
      },
    );
  }
}
