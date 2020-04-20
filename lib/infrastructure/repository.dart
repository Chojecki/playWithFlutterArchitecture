import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:my_horses/domain/horse_entity.dart';
import 'package:my_horses/domain/horses_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
@RegisterAs(HorsesRepository, env: 'dev')
class LocalStorageRepository implements HorsesRepository {
  final SharedPreferences store;

  const LocalStorageRepository(this.store);

  @override
  Future<List<HorseEntity>> loadHorses() async {
    try {
      return json
          .decode(store.getString('my_horses'))['horses']
          .cast<Map<String, Object>>()
          .map<HorseEntity>(HorseEntity.fromJson)
          .toList(growable: false);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future saveHorses(List<HorseEntity> horses) {
    return store.setString(
      'my_horses',
      json.encode({
        'horses': horses.map((horse) => horse.toJson()).toList(),
      }),
    );
  }
}
