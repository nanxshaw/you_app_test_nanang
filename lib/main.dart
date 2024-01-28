import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/api_service.dart';
import 'package:test/bloc/auth/auth_bloc.dart';
import 'package:test/bloc/user/user_bloc.dart';
import 'package:test/pages/login.dart';
import 'package:test/pages/profile.dart';
import 'package:test/pages/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final ApiService apiService = ApiService();

  MyApp({required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
              apiService: apiService, sharedPreferences: sharedPreferences),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
              apiService: apiService, sharedPreferences: sharedPreferences),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Auth Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/profile': (context) => Profile(),
          // '/update-profile': (context) => UpdateProfilePage(),
        },
      ),
    );
  }
}
