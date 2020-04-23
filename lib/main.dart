import 'package:flutter/material.dart';
import 'package:my_horses/app.dart';

import 'package:my_horses/injectable.dart';
import 'package:my_horses/state_models/loaded_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection('dev');

  final remoteConfig = await RemoteConfigService.getInstance();
  await remoteConfig.initialise();

  runApp(
    App(
      remoteConfig: remoteConfig,
    ),
  );
}
