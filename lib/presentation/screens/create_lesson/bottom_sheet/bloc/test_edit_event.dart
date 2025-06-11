part of "test_edit_bloc.dart";

abstract class TestEditEvent extends Equatable {}

class TestEditLoadEvent extends TestEditEvent {
  final int? id;
  final int lessonId;

  TestEditLoadEvent({required this.id, required this.lessonId});

  @override
  List<Object?> get props => [id];
}

class TestEditCreateTestStageEvent extends TestEditEvent {
  final CreateTestStageRequest data;

  TestEditCreateTestStageEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class TestEditDeleteTestStageEvent extends TestEditEvent {
  final int testStageId;

  TestEditDeleteTestStageEvent({required this.testStageId});

  @override
  List<Object?> get props => [testStageId];
}

class TestEditAddOptionEvent extends TestEditEvent {
  final CreateOptionRequest data;
  final int testId;

  TestEditAddOptionEvent({required this.data, required this.testId});

  @override
  List<Object?> get props => [data];
}

class TestEditDeleteOptionEvent extends TestEditEvent {
  final int optionId;
  final int testStageId;

  TestEditDeleteOptionEvent(
      {required this.testStageId, required this.optionId});

  @override
  List<Object?> get props => [optionId];
}
