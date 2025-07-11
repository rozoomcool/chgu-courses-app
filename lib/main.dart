import 'package:eventrecs/app/app.dart';
import 'package:eventrecs/domain/api/api.dart';
import 'package:eventrecs/domain/api/user/user_api_client.dart';
import 'package:eventrecs/repository/shared/auth_shared_repository.dart';
import 'package:eventrecs/utils/custom_scaffold_util.dart';
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
  GetIt.I.registerFactory(() => UserApiClient(GetIt.I<Dio>()));

  runApp(const MainApp());
}
