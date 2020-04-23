import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:my_horses/models/signinState_model.dart';
import 'package:my_horses/state_models/signin_state_model.dart';
import 'package:my_horses/widgets/login_form.dart';

import '../injectable.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<SignInStateModel, SignInFormState>(
        create: (context) => getIt<SignInStateModel>(), child: LoginFrom());
  }
}
