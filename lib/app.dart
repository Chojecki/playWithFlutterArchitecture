import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_horses/domain/horses_repository.dart';
import 'package:my_horses/routes_generator.dart';
import 'package:my_horses/screens/splash_screen.dart';
import 'package:my_horses/state_models/horse_list_model.dart';
import 'package:my_horses/state_models/loaded_model.dart';
import 'package:my_horses/theme/theme.dart';

import 'package:provider/provider.dart';

import 'injectable.dart';

class App extends StatelessWidget {
  final HorsesRepository repository;
  final RemoteConfigService remoteConfig;
  const App({Key key, @required this.repository, this.remoteConfig})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoadedModel(remoteConfigService: remoteConfig),
      child: Consumer<LoadedModel>(
        builder: (_, model, __) {
          if (model.loaded) {
            return ChangeNotifierProvider(
              create: (_) => getIt<HorseListModel>()..loadHorses(),
              child: MaterialApp(
                theme: ArchSampleTheme.theme,
                initialRoute: '/',
                onGenerateRoute: RouteGenerator.generateRoute,
              ),
            );
          }
          return SplashScreen(color: model.color);
        },
      ),
    );
  }
}
