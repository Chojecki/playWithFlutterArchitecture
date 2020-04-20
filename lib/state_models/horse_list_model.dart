import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_horses/domain/horses_repository.dart';
import 'package:my_horses/models/horse_model.dart';

@injectable
class HorseListModel extends ChangeNotifier {
  final HorsesRepository repository;

  List<Horse> _horses;

  UnmodifiableListView<Horse> get horses => UnmodifiableListView(_horses);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  HorseListModel({@required this.repository, @factoryParam List<Horse> horses})
      : _horses = horses ?? [];

  void loadHorses() async {
    _isLoading = true;
    notifyListeners();

    try {
      final horsesEntities = await repository.loadHorses();
      final horsesList = horsesEntities.map((horse) => Horse.fromEntity(horse));
      _horses.addAll(horsesList);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addHorse(Horse horse) {
    _horses.add(horse);
    notifyListeners();
    _uploadHorses();
  }

  void _uploadHorses() {
    repository.saveHorses(_horses.map((horse) => horse.toEntity()).toList());
  }

  void removeHorse(Horse horse) {
    _horses.removeWhere((it) => it.id == horse.id);
    notifyListeners();
    _uploadHorses();
  }

  void updateHorse(Horse horse) {
    assert(horse != null);
    assert(horse.id != null);

    var oldHorse = _horses.firstWhere((it) => it.id == horse.id);
    var indexOfOldHorse = _horses.indexOf(oldHorse);
    _horses.replaceRange(indexOfOldHorse, indexOfOldHorse + 1, [horse]);
    notifyListeners();
    _uploadHorses();
  }

  Horse horseById(String id) {
    return _horses.firstWhere((it) => it.id == id, orElse: () => null);
  }
}
