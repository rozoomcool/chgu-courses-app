import 'package:eventrecs/domain/state/auth/auth_cubit.dart';
import 'package:eventrecs/domain/state/theme/theme_cubit.dart';
import 'package:eventrecs/presentation/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:eventrecs/router/app_router.dart';
import 'package:eventrecs/utils/theme.dart';
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
        BlocProvider(
            create: (context) =>
                ProfileScreenBloc(GetIt.I())..init()),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final AppRouter appRouter = AppRouter(state);

          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                localizationsDelegates: const [
                ],
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.dark,
                theme: customTheme(context, Brightness.dark),
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
