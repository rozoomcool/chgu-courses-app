import 'package:coursera/domain/api/test/test_api_client.dart';
import 'package:coursera/domain/model/test/test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StudentTestScreenState extends Equatable {}

class StudentTestScreenInitialState extends StudentTestScreenState {
  @override
  List<Object?> get props => [];
}

class StudentTestScreenLoadingState extends StudentTestScreenState {
  @override
  List<Object?> get props => [];
}

class StudentTestScreenErrorState extends StudentTestScreenState {
  final String message;

  StudentTestScreenErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class StudentTestScreenLoadedState extends StudentTestScreenState {
  final Test test;

  StudentTestScreenLoadedState({required this.test});

  @override
  List<Object?> get props => [];
}

class StudentTestScreenCubit extends Cubit<StudentTestScreenState> {
  final TestApiClient testApiClient;
  StudentTestScreenCubit(this.testApiClient)
      : super(StudentTestScreenInitialState());

  Future<void> loadTest(int testId) async {
    emit(StudentTestScreenLoadingState());
    try {
      final test = await testApiClient.getOne(testId);
      emit(StudentTestScreenLoadedState(test: test));
    } catch (e) {
      emit(StudentTestScreenErrorState(message: e.toString()));
    }
  }
}
