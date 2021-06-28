part of 'settings_cubit.dart';

class SettingsState {
  final bool appNotifications;
  final bool emailNotificaitons;

  SettingsState(
      {required this.appNotifications, required this.emailNotificaitons});

  SettingsState copyWith({bool? appNotifications, bool? emailNotificaitons}) {
    return SettingsState(
      appNotifications: appNotifications ?? this.appNotifications,
      emailNotificaitons: emailNotificaitons ?? this.emailNotificaitons,
    );
  }
}
