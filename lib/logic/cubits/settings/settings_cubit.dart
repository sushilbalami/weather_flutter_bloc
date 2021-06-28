import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          SettingsState(
            appNotifications: false,
            emailNotificaitons: false,
          ),
        );

  void toggleAppNotification(bool value) =>
      emit(state.copyWith(appNotifications: value));

  void toggleEmailNotification(bool value) =>
      emit(state.copyWith(emailNotificaitons: value));
}
