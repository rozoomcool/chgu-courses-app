import 'package:coursera/domain/model/auth/auth_request.dart';
import 'package:coursera/domain/model/auth/register_request.dart';
import 'package:coursera/domain/model/jwt_payload/jwt_payload.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:coursera/utils/constants.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: '$baseUrl/api/v1/auth')
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String? baseUrl}) = _AuthApiClient;

  @POST('/register')
  Future<void> create(@Body() RegisterRequest authRequest);

  @POST('/login')
  Future<JwtPayload> login(@Body() AuthRequest authRequest);
}