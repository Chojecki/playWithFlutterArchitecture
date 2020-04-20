import 'package:flutter/material.dart';
import 'package:my_horses/domain/horses_repository.dart';
import 'package:my_horses/infrastructure/mock_repository.dart';
import 'package:my_horses/models/horse_model.dart';
import 'package:my_horses/screens/home_screen.dart';
import 'package:my_horses/state_models/horse_list_model.dart';
import 'package:provider/provider.dart';

class TestWidget extends StatelessWidget {
  final Widget child;
  final HorsesRepository repository;
  final List<Horse> horses;

  const TestWidget({Key key, this.child, this.repository, this.horses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HorseListModel>(
      create: (_) {
        final repository = MockRepository(horses ?? _defaultHorses);
        return HorseListModel(repository: repository)..loadHorses();
      },
      child: MaterialApp(home: child ?? const HomeScreen()),
    );
  }

  List<Horse> get _defaultHorses {
    return [Horse("Aris", id: "1"), Horse("Sandi", id: "2")];
  }
}
