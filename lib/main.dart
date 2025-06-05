import 'package:coursera/app/app.dart';
import 'package:coursera/domain/api/api.dart';
import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/api/lesson/lesson_api_client.dart';
import 'package:coursera/domain/api/user/user_api_client.dart';
import 'package:coursera/repository/shared/auth_shared_repository.dart';
import 'package:coursera/utils/custom_scaffold_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final authSharedRepository = AuthSharedRepository(prefs);

  GetIt.I.registerFactory(() => prefs);
  GetIt.I.registerFactory(() => authSharedRepository);
  GetIt.I.registerFactory(() => CustomScaffoldUtil());
  GetIt.I.registerFactory(() => configureDio(authSharedRepository));
  GetIt.I.registerFactory(() => CourseApiClient(GetIt.I<Dio>()));
  GetIt.I.registerFactory(() => UserApiClient(GetIt.I<Dio>()));
  GetIt.I.registerFactory(() => LessonApiClient(GetIt.I<Dio>()));

  runApp(const MainApp());
}
