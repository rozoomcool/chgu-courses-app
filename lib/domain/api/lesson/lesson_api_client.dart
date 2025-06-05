import 'package:coursera/domain/model/auth/auth_request.dart';
import 'package:coursera/domain/model/jwt_payload/jwt_payload.dart';
import 'package:coursera/domain/model/lesson/create_lesson_request.dart';
import 'package:coursera/domain/model/lesson/lesson.dart';
import 'package:coursera/domain/model/lesson/update_lesson_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:coursera/utils/constants.dart';

part 'lesson_api_client.g.dart';

@RestApi(baseUrl: '$baseUrl/api/v1')
abstract class LessonApiClient {
  factory LessonApiClient(Dio dio, {String? baseUrl}) = _LessonApiClient;

  @POST('/lessons')
  Future<Lesson> create(@Body() CreateLessonRequest authRequest);

  @PUT('/lessons/{id}')
  Future<Lesson> update(
      @Path("id") int id, @Body() UpdateLessonRequest request);

  @GET('/lessons/{id}')
  Future<Lesson> getOne(@Path("id") int id);

  @GET('/lessons/course/{id}')
  Future<List<Lesson>> getAllByCourse(@Path("id") int id);

  @POST('/lessons/login')
  Future<JwtPayload> login(@Body() AuthRequest authRequest);
}
