import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/state/auth/auth_cubit.dart';
import 'package:coursera/domain/state/course/course_bloc.dart';
import 'package:coursera/domain/state/theme/theme_cubit.dart';
import 'package:coursera/presentation/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()..init()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => CourseBloc(GetIt.I())..init()),
        BlocProvider(
            create: (context) =>
                ProfileScreenBloc(GetIt.I(), GetIt.I())..init())
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final AppRouter appRouter = AppRouter(state);

          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                themeMode: state is LightModeThemeState
                    ? ThemeMode.light
                    : ThemeMode.dark,
                theme: customTheme(context, Brightness.light),
                darkTheme: customTheme(context, Brightness.dark),
                routerConfig: appRouter.config(),
              );
            },
          );
        },
      ),
    );
  }
}
