import 'package:eventrecs/domain/model/auth/auth_request.dart';
import 'package:eventrecs/domain/model/auth/register_request.dart';
import 'package:eventrecs/domain/model/jwt_payload/jwt_payload.dart';
import 'package:eventrecs/domain/model/user/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:eventrecs/utils/constants.dart';

part 'user_api_client.g.dart';

@RestApi(baseUrl: '$baseUrl/api/v1')
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String? baseUrl}) = _UserApiClient;

  @POST('/users/register')
  Future<void> create(@Body() RegisterRequest authRequest);

  @GET('/users/user/current')
  Future<User> findOne();

  @POST('/users/login')
  Future<JwtPayload> login(@Body() AuthRequest authRequest);
}