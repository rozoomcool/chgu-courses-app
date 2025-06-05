import 'package:coursera/domain/state/auth/auth_cubit.dart';
import 'package:coursera/domain/state/course/course_bloc.dart';
import 'package:coursera/domain/state/theme/theme_cubit.dart';
import 'package:coursera/presentation/screens/course_info/bloc/course_info_bloc.dart';
import 'package:coursera/presentation/screens/create_course/bloc/create_course_bloc.dart';
import 'package:coursera/presentation/screens/create_lesson/bloc/create_lesson_bloc.dart';
import 'package:coursera/presentation/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
                ProfileScreenBloc(GetIt.I(), GetIt.I())..init()),
        BlocProvider(create: (context) => CreateCourseBloc(GetIt.I())),
        BlocProvider(create: (context) => CourseInfoBloc(GetIt.I(), GetIt.I())),
        BlocProvider(create: (context) => CreateLessonBloc(GetIt.I()))
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final AppRouter appRouter = AppRouter(state);

          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  FlutterQuillLocalizations.delegate,
                ],
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
