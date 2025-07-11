import 'package:eventrecs/domain/api/user/user_api_client.dart';
import 'package:eventrecs/domain/model/user/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_screen_event.dart';
part 'profile_screen_state.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  // final CourseApiClient courseApiRepo;
  final UserApiClient userApiRepo;

  ProfileScreenBloc(this.userApiRepo)
      : super(ProfileScreenInitialState()) {
    on<ProfileScreenLoadEvent>(_onLoadProfile);
  }

  void init() {
    debugPrint("||||||");
    loadData();
  }

  void loadData() {
    add(ProfileScreenLoadEvent());
  }

  Future<void> _onLoadProfile(
      ProfileScreenLoadEvent event, Emitter<ProfileScreenState> emit) async {
    emit(ProfileScreenLoadingState());
    try {
      // await Future.delayed(Duration(milliseconds: 500));
      final user = await userApiRepo.findOne();
      emit(ProfileScreenLoadedState(
          user: user,));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(ProfileScreenErrorState(e.toString()));
    }
  }
}
