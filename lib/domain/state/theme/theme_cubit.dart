import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightModeThemeState());

  void toggleTheme() {
    emit(state is LightModeThemeState
        ? DarkModeThemeState()
        : LightModeThemeState());
  }
}
