import 'package:bloc_firebase_test/dependency_injection/di_container.dart';
import 'package:bloc_firebase_test/presentation/screen/home_screen.dart';
import 'package:bloc_firebase_test/presentation/screen/sign_in_screen.dart';
import 'package:bloc_firebase_test/presentation/screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final _auth = locator<FirebaseAuth>();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/signIn':
        return MaterialPageRoute(builder: (_) => SignInScreen());

      default:
        return null;
    }
  }

  String isUserAuthenticated() {
    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      return '/signUp';
    } else {
      return '/home';
    }
  }
}
