import 'dart:io';
import 'package:coursera/domain/model/admission/course_admission.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/utils/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'course_api_client.g.dart';

@RestApi(baseUrl: "$baseUrl/api/v1")
abstract class CourseApiClient {
  factory CourseApiClient(Dio dio, {String baseUrl}) = _CourseApiClient;

  @GET("/course/")
  Future<List<Course>> getCourses(
      {@Query("skip") int? skip, @Query("take") int? take});

  @DELETE("/course/{courseId}/lesson/{lessonId}")
  Future<void> deleteLesson(
      {@Path("courseId") required int courseId,
      @Path("lessonId") required int lessonId});

  @GET("/course")
  Future<List<Course>> getAllCoursesDeep(
      {@Query("skip") int? skip, @Query("take") int? take});

  @GET("/course/all/teacher/{id}")
  Future<List<Course>> getByTeacherId(@Path("id") int id);

  @GET("/course/{id}")
  Future<Course> getCourse(@Path("id") int id,
      {@Query("teacher") bool teacher = false,
      @Query("lessons") bool lessons = false});

  @POST("/course/")
  @MultiPart()
  Future<HttpResponse<Course>> createCourse(
    @Part(name: "file") File file,
    @Part(name: "title") String title,
    @Part(name: "description") String description,
  );

  @PUT("/course/{id}")
  @MultiPart()
  Future<Course> updateCourse({
    @Path("id") required int id,
    @Part(name: "file") File? file,
    @Part() String? title,
    @Part() String? description,
    @Part() String? imageUrl,
  });

  @DELETE("/course/{id}")
  Future<HttpResponse<Course>> deleteCourse(@Path("id") int id);

  @POST("/course/{courseId}/admission")
  Future<CourseAdmission> addAdmission(@Path("courseId") int id);

  @PUT("/course/{courseId}/admission/user/{userId}")
  Future<CourseAdmission> changeAdmission(
      {@Path("courseId") required int courseId,
      @Path("userId") required int userId,
      @Query("admissionState") required AdmissionState admissionState});

  @GET("/course/{courseId}/admission")
  Future<List<CourseAdmission>> getAllAdmissionsByCourse(
      {@Path("courseId") required int courseId});

  @GET("/course/{courseId}/admission/user")
  Future<CourseAdmission?> getMyAdmission(
      {@Path("courseId") required int courseId});

  @GET("/course/user/admission")
  Future<List<CourseAdmission>> getAllAdmissionsByUser();
}
