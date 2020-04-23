import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:my_horses/models/signinState_model.dart';
import 'package:my_horses/state_models/auth_state_model.dart';
import 'package:my_horses/state_models/signin_state_model.dart';
import 'package:my_horses/theme/theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:my_horses/widgets/decorators/draw_ciricle.dart';
import 'package:provider/provider.dart';

class LoginFrom extends StatefulWidget {
  const LoginFrom({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginFrom> {
  final FocusNode _focus = FocusNode();
  final FlareControls _flareControl = FlareControls();

  final _formKey = GlobalKey<FormState>();
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onPasswordFocusChange);
  }

  void _onPasswordFocusChange() {
    if (_focus.hasFocus) {
      _flareControl.play("close");
    } else {
      _flareControl.play("open");
    }
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var singinFormState = Provider.of<SignInStateModel>(context);
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      theme: AppTheme.theme,
      home: StateNotifierBuilder(
        stateNotifier: singinFormState,
        builder: (context, SignInFormState state, _) {
          if (state.isSuccess) {
            Provider.of<AuthStateModel>(context, listen: false)
                .getSignedInUser();
          }

          // if (state.showErrorMessages) {
          //   _flareControl.play("fail");
          // }
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.white],
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 300,
                    child: CustomPaint(painter: DrawCircle()),
                  ),
                  SafeArea(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 400.0,
                            height: 150.0,
                            child: FlareActor("assets/animations/bbb.flr",
                                animation:
                                    state.showErrorMessages ? "fail" : null,
                                controller: _flareControl,
                                callback: (_) {}),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 20,
                                    spreadRadius: -2,
                                  ),
                                ]),
                            child: Form(
                              key: _formKey,
                              autovalidate: false,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      key: Key('__emailTextField__'),
                                      controller: _emailEditingController,
                                      onChanged: (value) =>
                                          singinFormState.emailChanged(value),
                                      decoration:
                                          InputDecoration(hintText: 'email'),
                                      style: textTheme.subhead,
                                      validator: (val) {
                                        return val.trim().isEmpty
                                            ? 'empty error'
                                            : null;
                                      },
                                    ),
                                    SizedBox(height: 10.0),
                                    TextFormField(
                                      key: Key('__passwordTextField__'),
                                      controller: _passwordEditingController,
                                      onChanged: (value) => singinFormState
                                          .passwordChanged(value),
                                      style: textTheme.subhead,
                                      obscureText: true,
                                      focusNode: _focus,
                                      decoration:
                                          InputDecoration(hintText: 'password'),
                                    ),
                                    SizedBox(height: 20.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue[900]),
                                child: MaterialButton(
                                  key: Key('__submitFormButton__'),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Text('Login',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white)),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      singinFormState
                                          .signInWithEmailAndPasswordPressed();
                                    }
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue[900]),
                                child: FlatButton(
                                  key: Key('__submitFormButton__'),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Text('Register',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white)),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      singinFormState
                                          .registerWithEmailAndPasswordPressed();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state.isSubmitting) ...[
                          const SizedBox(height: 8),
                          const LinearProgressIndicator(value: null),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
