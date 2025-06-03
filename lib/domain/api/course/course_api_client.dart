import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/domain/model/course/update_course_request.dart';
import 'package:coursera/utils/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'course_api_client.g.dart';

@RestApi(baseUrl: "$baseUrl/api/v1")
abstract class CourseApiClient {
  factory CourseApiClient(Dio dio, {String baseUrl}) = _CourseApiClient;

  @GET("/course/")
  Future<List<Course>> getCourses({
    @Query("skip") int? skip,
    @Query("take") int? take
  });

  @GET("/course")
  Future<List<Course>> getAllCoursesDeep({
    @Query("skip") int? skip,
    @Query("take") int? take
  });

  @GET("/course/all/teacher/{id}")
  Future<List<Course>> getByTeacherId(@Path("id") int id);

  @GET("/course/{id}")
  Future<Course> getCourse(@Path("id") int id);

  @POST("/course/")
  @MultiPart()
  Future<HttpResponse<Course>> createCourse(
    @Part(name: "file") File file,
    @Part(name: "title") String title,
    @Part(name: "description") String description,
  );

  @PATCH("/course/{id}")
  Future<Course> updateCourse(
    @Path("id") int id,
    @Body() UpdateCourseRequest data,
  );

  @DELETE("/course/{id}")
  Future<HttpResponse<Course>> deleteCourse(@Path("id") int id);
}
