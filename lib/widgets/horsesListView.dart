import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_horses/models/horse_model.dart';
import 'package:my_horses/state_models/horse_list_model.dart';
import 'package:my_horses/state_models/loaded_model.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';

class HorsesListView extends StatelessWidget {
  final void Function(BuildContext context, Horse horse) onRemove;
  const HorsesListView({Key key, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HorseListModel, List<Horse>>(
      selector: (_, model) => model.horses,
      shouldRebuild: (old, next) => old != next,
      builder: (context, horses, _) {
        if (horses.isEmpty) {
          return Center(
            child: Text('Emtpy'),
          );
        }
        return ListView.builder(
          key: Key('__horseList__'),
          itemCount: horses.length,
          itemBuilder: (context, index) {
            final horse = horses[index];

            return Dismissible(
                direction: DismissDirection.endToStart,
                key: Key('__dismissaibleHorse${horse.id}__'),
                onDismissed: (_) => onRemove(context, horse),
                background: slideLeftBackground(context),
                child: ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed('/horseDetail', arguments: horse),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  leading: Hero(
                    tag: 'kon${horse.id}',
                    child: CircleAvatar(
                        backgroundImage: FileImage(File(horse.image))),
                  ),
                  title: Text(horse.name,
                      style: Theme.of(context).textTheme.title,
                      key: Key('__${horse.name}key__')),
                  subtitle: Text(horse.note,
                      style: Theme.of(context).textTheme.subhead,
                      key: Key('__${horse.note}key__')),
                ));
          },
        );
      },
    );
  }
}

Widget slideLeftBackground(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(color: Colors.blue, height: 100.0, width: 100.0),
      Container(
        width: 100.0,
        color: Colors.white,
        child: FlareActor("assets/animations/t.flr", animation: "Like heart",
            callback: (_) {
          Provider.of<LoadedModel>(context, listen: false).finishLoading();
        }),
      ),
    ],
  );
}
