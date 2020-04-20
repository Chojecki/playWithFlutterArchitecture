import 'dart:async';
import 'dart:core';

import 'horse_entity.dart';

abstract class HorsesRepository {
  // Loads horses from storage
  Future<List<HorseEntity>> loadHorses();

  // Persist hroses on disc
  Future saveHorses(List<HorseEntity> horses);
}
