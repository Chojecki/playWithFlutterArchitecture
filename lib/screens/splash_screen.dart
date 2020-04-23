import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:my_horses/injectable.dart';
import 'package:my_horses/models/userState_model.dart';
import 'package:my_horses/routes_generator.dart';
import 'package:my_horses/screens/login_screen.dart';
import 'package:my_horses/state_models/auth_state_model.dart';
import 'package:my_horses/state_models/horse_list_model.dart';
import 'package:my_horses/theme/theme.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthStateModel>(context);
    return StateNotifierBuilder(
        stateNotifier: authState,
        builder: (context, UserState state, _) => state.map(
            initial: (_) => Initial(),
            authenticated: (_) => ChangeNotifierProvider(
                  create: (_) => getIt<HorseListModel>()..loadHorses(),
                  child: MaterialApp(
                    theme: AppTheme.theme,
                    initialRoute: '/',
                    onGenerateRoute: RouteGenerator.generateRoute,
                  ),
                ),
            unauthenticated: (_) => LoginScreen()));
  }
}

class Initial extends StatelessWidget {
  const Initial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
