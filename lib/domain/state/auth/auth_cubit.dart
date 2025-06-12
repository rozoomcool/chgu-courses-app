import 'package:coursera/domain/api/auth/auth_api_client.dart';
import 'package:coursera/domain/api/user/user_api_client.dart';
import 'package:coursera/domain/model/auth/auth_request.dart';
import 'package:coursera/domain/model/auth/register_request.dart';
import 'package:coursera/domain/model/user/user.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../repository/shared/auth_shared_repository.dart';
import '../../../utils/custom_scaffold_util.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(UnknownAuthState());

  final _authSharedRepository = GetIt.I<AuthSharedRepository>();
  final _scaffoldUtils = GetIt.I<CustomScaffoldUtil>();
  final _authApiClient = AuthApiClient(GetIt.I<Dio>());
  final _userApiClient = UserApiClient(GetIt.I<Dio>());

  Future<void> init() async {
    if (_authSharedRepository.getAccessToken().isNotEmpty &&
        _authSharedRepository.getAccessToken() != "") {
      final user = await _userApiClient.findOne();
      emit(AuthenticatedAuthState(user: user));
    }
  }

  Future<void> signIn(AuthRequest authRequest) async {
    try {
      var data = await _authApiClient.login(authRequest);
      debugPrint(data.toString());
      _authSharedRepository.setTokens(data.access, data.refresh);
      _authSharedRepository.setEmail(data.user.email);
      _authSharedRepository.setId(data.user.id);
      final user = await _userApiClient.findOne();
      emit(AuthenticatedAuthState(user: user));
    } catch (e) {
      debugPrint("ERROR SIGN_IN: $e");
      _scaffoldUtils.showErrorSnack("Произошла ошибка авторизации");
    }
  }

  void signUp(RegisterRequest request) async {
    try {
      debugPrint(request.toJson().toString());

      await _authApiClient.create(request);
      emit(SuccessfluRegisteredAuthState());
    } catch (e) {
      debugPrint(e.toString());
      _scaffoldUtils.showErrorSnack("Произошла ошибка регистрации");
    }
  }

  void logOut() {
    _authSharedRepository.clear();
    emit(UnauthorizedAuthState());
  }
}
