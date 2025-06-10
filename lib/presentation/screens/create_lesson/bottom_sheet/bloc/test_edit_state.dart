part of "test_edit_bloc.dart";

abstract class TestEditState extends Equatable {}

class TestEditInitialState extends TestEditState {
  @override
  List<Object?> get props => [];
}

class TestEditLoadingState extends TestEditState {
  @override
  List<Object?> get props => [];
}

class TestEditLoadedState extends TestEditState {
  final Test test;

  TestEditLoadedState({required this.test});

  @override
  List<Object?> get props => [test];
}

class TestEditErrorState extends TestEditState {
  final String message;

  TestEditErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}