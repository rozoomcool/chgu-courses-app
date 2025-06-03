import 'package:coursera/domain/model/auth/auth_request.dart';
import 'package:coursera/domain/model/auth/register_request.dart';
import 'package:coursera/domain/model/jwt_payload/jwt_payload.dart';
import 'package:coursera/domain/model/user/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:coursera/utils/constants.dart';

part 'user_api_client.g.dart';

@RestApi(baseUrl: '$baseUrl/api/v1/users')
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String? baseUrl}) = _UserApiClient;

  @POST('/register')
  Future<void> create(@Body() RegisterRequest authRequest);

  @GET('/')
  Future<User> findOne();

  @POST('/login')
  Future<JwtPayload> login(@Body() AuthRequest authRequest);
}