import 'package:flutter/material.dart';
import 'package:my_horses/state_models/auth_state_model.dart';
import 'package:my_horses/state_models/horse_list_model.dart';
import 'package:my_horses/widgets/horsesListView.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Horses"),
          actions: <Widget>[
            FlatButton(
                child: Text('Logout', style: TextStyle(color: Colors.white)),
                onPressed: () =>
                    Provider.of<AuthStateModel>(context, listen: false)
                        .signOut())
          ],
        ),
        floatingActionButton: FloatingActionButton(
          key: Key('__fab__'),
          onPressed: () => Navigator.of(context).pushNamed('/addHorse'),
          tooltip: 'Add Horse',
          child: const Icon(Icons.add),
        ),
        body: Selector<HorseListModel, bool>(
          selector: (context, model) => model.isLoading,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  key: Key('__horseListProgresIndicator__'),
                ),
              );
            }
            return HorsesListView(
              onRemove: (context, horse) {
                Provider.of<HorseListModel>(context, listen: false)
                    .removeHorse(horse);
              },
            );
          },
        ));
  }
}
