import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:my_horses/domain/horse_entity.dart';
import 'package:my_horses/infrastructure/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

class MockFileStorage extends Mock implements LocalStorageRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('HorsesRepository', () {
    List<HorseEntity> createHorses() {
      return [HorseEntity('Aris', "1", "Czarny kon", "")];
    }

    test('Should load horse from storage when there is no any error', () {
      final repository = MockFileStorage();
      final horses = createHorses();

      when(repository.loadHorses()).thenAnswer((_) => Future.value(horses));
      expect(repository.loadHorses(), completion(horses));
    });

    test('Should persis horses to local disc', () {
      final repository = MockFileStorage();
      final horses = createHorses();

      when(repository.saveHorses(any)).thenAnswer((_) => Future.value(horses));
      expect(repository.saveHorses(horses), completes);
      verify(repository.saveHorses(horses));
    });
  });

  group('HorsesRepository with shared preferences', () {
    final store = MockSharedPreferences();
    final repository = LocalStorageRepository(store);
    List<HorseEntity> createHorses() {
      return [HorseEntity('Aris', "1", "Czarnykon", "")];
    }

    final horses = createHorses();
    final horsesJson =
        '{"horses":[{"name":"Aris","note":"Czarnykon","id":"1","imagePath":""}]}';

    test('Should save to shated preferences on "my_horses" key', () async {
      await repository.saveHorses(horses);
      verify(store.setString('my_horses', horsesJson));
    });

    test('Should load HorseEntity from disk', () async {
      when(store.getString('my_horses')).thenReturn(horsesJson);
      expect(await repository.loadHorses(), horses);
    });
  });
}
