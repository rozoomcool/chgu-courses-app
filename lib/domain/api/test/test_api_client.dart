import 'package:coursera/domain/model/lesson/update_lesson_request.dart';
import 'package:coursera/domain/model/option/create_option_request.dart';
import 'package:coursera/domain/model/option/option.dart';
import 'package:coursera/domain/model/test/create_test_request.dart';
import 'package:coursera/domain/model/test/test.dart';
import 'package:coursera/domain/model/testStage/create_test_stage_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:coursera/utils/constants.dart';

part 'test_api_client.g.dart';

@RestApi(baseUrl: '$baseUrl/api/v1')
abstract class TestApiClient {
  factory TestApiClient(Dio dio, {String? baseUrl}) = _TestApiClient;

  @POST('/tests')
  Future<Test> create(@Body() CreateTestRequest request);

  @POST('/test-stages')
  Future<Test> addTestStage(@Body() CreateTestStageRequest request);

  @POST('/options')
  Future<Option> addOption(@Body() CreateOptionRequest request);

  @DELETE('/options/{id}')
  Future<void> deleteOption(@Path("id") int id);

  @DELETE('/test-stages/{id}')
  Future<void> deleteTestStage(@Path("id") int id);

  @PUT('/lessons/{id}')
  Future<Test> update(@Path("id") int id, @Body() UpdateLessonRequest request);

  @GET('/tests/{id}')
  Future<Test> getOne(@Path("id") int id);
}
