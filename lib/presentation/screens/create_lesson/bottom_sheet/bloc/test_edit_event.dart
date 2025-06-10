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
