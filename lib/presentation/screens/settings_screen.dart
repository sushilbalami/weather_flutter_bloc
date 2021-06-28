import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/logic/cubits/settings/settings_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
          ),
          body: Column(
            children: [
              SwitchListTile(
                value: state.appNotifications,
                onChanged: (value) =>
                    context.read<SettingsCubit>().toggleAppNotification(value),
                title: Text("App Notificaitons"),
              ),
              SwitchListTile(
                value: state.emailNotificaitons,
                onChanged: (value) => context
                    .read<SettingsCubit>()
                    .toggleEmailNotification(value),
                title: Text("Email Notificaitons"),
              ),
            ],
          ),
        );
      },
    );
  }
}
