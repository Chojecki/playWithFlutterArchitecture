import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_horses/models/horse_model.dart';

class HorseDetailScreen extends StatelessWidget {
  final Horse horse;
  const HorseDetailScreen({Key key, this.horse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horse'),
      ),
      body: Container(
        child: Center(
          child: Hero(
            tag: 'kon${horse.id}',
            child: Image.file(
              File(horse.image),
            ),
          ),
        ),
      ),
    );
  }
}
