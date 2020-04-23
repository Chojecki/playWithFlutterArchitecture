import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:my_horses/models/userState_model.dart';
import 'package:my_horses/screens/splash_screen.dart';
import 'package:my_horses/state_models/auth_state_model.dart';
import 'package:my_horses/state_models/loaded_model.dart';
import 'package:my_horses/injectable.dart';
import 'injectable.dart';

class App extends StatelessWidget {
  final RemoteConfigService remoteConfig;
  const App({Key key, @required this.remoteConfig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<AuthStateModel, UserState>(
        create: (context) => getIt<AuthStateModel>()..getSignedInUser(),
        child: SplashScreen());
  }
}
