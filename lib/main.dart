import 'package:flutter/material.dart';
import 'package:my_horses/app.dart';
import 'package:my_horses/domain/horses_repository.dart';

import 'package:my_horses/injectable.dart';
import 'package:my_horses/state_models/loaded_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection('dev');

  final c = await RemoteConfigService.getInstance();
  await c.initialise();

  runApp(
    App(
      remoteConfig: c,
      repository: getIt<HorsesRepository>(),
    ),
  );
}
