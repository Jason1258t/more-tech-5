import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/feature/auth/bloc/app/app_cubit.dart';
import 'package:starter/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:starter/feature/auth/data/auth_repository.dart';
import 'package:starter/feature/auth/ui/login_screen.dart';
import 'package:starter/feature/home/ui/home_screen.dart';
import 'package:starter/feature/map/bloc/routes/routes_cubit.dart';
import 'package:starter/feature/map/data/map_repository.dart';
import 'package:starter/feature/map/ui/map_screen.dart';
import 'package:starter/main.dart';
import 'package:starter/services/api/api_service.dart';
import 'package:starter/services/preferences.dart';

final PreferencesService prefs = PreferencesService();
final ApiService apiService = ApiService(preferencesService: prefs);

class MyRepositoryProvider extends StatelessWidget {
  const MyRepositoryProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
     MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (_) =>
                  AuthRepository(apiService: apiService)..checkLogin()),
          RepositoryProvider(create: (_) => MapRepository()),
        ],
        child: const MyBlocProviders(),
        // child: MyApp(),

    );
  }
}

class MyBlocProviders extends StatelessWidget {
  const MyBlocProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (_) => AppCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
            lazy: false,
          ),
          BlocProvider<AuthCubit>(
            create: (_) => AuthCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
            lazy: false,
          ),
          BlocProvider<RoutesCubit>(
            create: (_) => RoutesCubit(),
            lazy: false,
          ),
        ],
        child: const MyApp(),

    );
  }
}

class AppStateWidget extends StatelessWidget {
  const AppStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          // if (state is AppAuthState) {
          //   return Scaffold();
          // } else if (state is AppUnAuthState) {
          //   return const LoginScreen();
          // } else {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return const HomeScreen();
        },
      ),
    );
  }
}
