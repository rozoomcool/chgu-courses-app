import 'package:eventrecs/domain/model/user/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UserCubit extends Cubit<User?> {
  UserCubit() : super(null);

  final Dio _dio = GetIt.I<Dio>();

  Future<void> init() async {
    fetchUser();
  }

  Future<void> fetchUser() async {
    final response = await _dio.get("/user");
    if (response.statusCode == 200) {
      emit(User.fromJson(response.data));
    }
  }
}
