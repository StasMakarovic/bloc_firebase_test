import 'package:bloc_firebase_test/bloc/add_data_bloc/add_data_bloc.dart';
import 'package:bloc_firebase_test/bloc/bloc/fetch_data_bloc.dart';
import 'package:bloc_firebase_test/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:bloc_firebase_test/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:bloc_firebase_test/data/repository/auth.dart';
import 'package:bloc_firebase_test/data/repository/firestore.dart';
import 'package:bloc_firebase_test/data/repository/logicMethods.dart';
import 'package:bloc_firebase_test/dependency_injection/di_container.dart';
import 'package:bloc_firebase_test/presentation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchDataBloc>(
          create: (BuildContext context) => FetchDataBloc(
              locator<LogicMethods>(), locator<FirestoreMethods>()),
        ),
        BlocProvider<AddDataBloc>(
          create: (BuildContext context) =>
              AddDataBloc(locator<FirestoreMethods>()),
        ),
        BlocProvider<SignUpBloc>(
          create: (BuildContext context) => SignUpBloc(locator<AuthMethods>()),
        ),

        BlocProvider<SignInBloc>(
          create: (BuildContext context) => SignInBloc(),
        ),
        // Add more BlocProviders if needed
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          onGenerateRoute: _appRouter.onGenerateRoute,
          initialRoute: _appRouter.isUserAuthenticated()),
    );
  }
}
