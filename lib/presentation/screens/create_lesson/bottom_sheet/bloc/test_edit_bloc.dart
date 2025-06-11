import 'package:coursera/domain/api/test/test_api_client.dart';
import 'package:coursera/domain/model/option/create_option_request.dart';
import 'package:coursera/domain/model/test/create_test_request.dart';
import 'package:coursera/domain/model/test/test.dart';
import 'package:coursera/domain/model/testStage/create_test_stage_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'test_edit_state.dart';
part 'test_edit_event.dart';

class TestEditBloc extends Bloc<TestEditEvent, TestEditState> {
  final TestApiClient testApiClient;

  TestEditBloc(this.testApiClient) : super(TestEditInitialState()) {
    on<TestEditLoadEvent>(_onLoadEvent);
    on<TestEditCreateTestStageEvent>(_onCreateTestStageEvent);
    on<TestEditDeleteTestStageEvent>(_onDeleteTestStageEvent);
    on<TestEditAddOptionEvent>(_onAddOption);
    on<TestEditDeleteOptionEvent>(_onDeleteOptionEvent);
  }

  void loadTest(int? id, int lessonId) {
    add(TestEditLoadEvent(id: id, lessonId: lessonId));
  }

  void addTestStage(CreateTestStageRequest request) {
    add(TestEditCreateTestStageEvent(data: request));
  }

  void deleteTestStage(int id) {
    add(TestEditDeleteTestStageEvent(testStageId: id));
  }

  void addOption(int testId, CreateOptionRequest data) {
    add(TestEditAddOptionEvent(testId: testId, data: data));
  }

  void deleteOption({required int testStageId, required int optionId}) {
    add(TestEditDeleteOptionEvent(testStageId: testStageId, optionId: optionId));
  }

  Future<void> _onLoadEvent(
      TestEditLoadEvent event, Emitter<TestEditState> emit) async {
    emit(TestEditLoadingState());
    try {
      if (event.id != null) {
        final test = await testApiClient.getOne(event.id!);
        emit(TestEditLoadedState(test: test));
      } else {
        final test = await testApiClient
            .create(CreateTestRequest(lessonId: event.lessonId));
        emit(TestEditLoadedState(test: test));
      }
    } catch (e) {
      emit(TestEditErrorState(message: e.toString()));
    }
  }

  Future<void> _onAddOption(
      TestEditAddOptionEvent event, Emitter<TestEditState> emit) async {
    emit(TestEditLoadingState());
    try {
      await testApiClient.addOption(event.data);
      final test = await testApiClient
          .getOne(event.testId);
      emit(TestEditLoadedState(test: test));
    } catch (e) {
      emit(TestEditErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteOptionEvent(
      TestEditDeleteOptionEvent event, Emitter<TestEditState> emit) async {
    emit(TestEditLoadingState());
    try {
      await testApiClient.deleteOption(event.optionId);
      final test = await testApiClient.getOne(event.testStageId);
      emit(TestEditLoadedState(test: test));
    } catch (e) {
      emit(TestEditErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteTestStageEvent(
      TestEditDeleteTestStageEvent event, Emitter<TestEditState> emit) async {
    emit(TestEditLoadingState());
    try {
      await testApiClient.deleteTestStage(event.testStageId);
      final test = await testApiClient.getOne(event.testStageId);
      emit(TestEditLoadedState(test: test));
    } catch (e) {
      emit(TestEditErrorState(message: e.toString()));
    }
  }

  Future<void> _onCreateTestStageEvent(
      TestEditCreateTestStageEvent event, Emitter<TestEditState> emit) async {
    emit(TestEditLoadingState());
    try {
      await testApiClient.addTestStage(event.data);
      final test = await testApiClient.getOne(event.data.testId);
      emit(TestEditLoadedState(test: test));
    } catch (e) {
      emit(TestEditErrorState(message: e.toString()));
    }
  }
}
