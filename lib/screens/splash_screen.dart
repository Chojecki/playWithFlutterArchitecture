import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:my_horses/state_models/loaded_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  final bool color;
  const SplashScreen({Key key, this.color}) : super(key: key);

  Color get c => color ? Colors.black : Color.fromRGBO(230, 39, 134, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          color: Colors.white,
          height: 400,
          width: 400,
          child: FlareActor("assets/animations/aaa.flr", animation: "Untitled",
              callback: (_) {
            Provider.of<LoadedModel>(context, listen: false).finishLoading();
          }, color: c),
        ),
      ),
    );
  }
}
