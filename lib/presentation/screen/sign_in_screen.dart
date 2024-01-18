import 'package:bloc_firebase_test/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is ShowSnackBarSignInState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is SuccessfulSignInState) {
          Navigator.pushReplacementNamed(context, '/home');
          context.read<SignInBloc>().add(ResetSignInEvent());
        }
      },
      builder: (context, state) {
        if (state is SignInInitialState) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: Text('Sign in'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/signUp',
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text('Sign up'))
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
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<SignInBloc>().add(
                              SignInButtonClickedEvent(
                                  email: emailTextEditingController.text,
                                  password:
                                      passwordTextEditingController.text));
                        },
                        child: Text('Sign in')),
                  ]),
            ),
          );
        } else if (state is SignInLoadingState) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text('There is some other state!'),
            ),
          );
        }
      },
    );
  }
}
