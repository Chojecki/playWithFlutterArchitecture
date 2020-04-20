import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_horses/infrastructure/mock_repository.dart';
import 'package:my_horses/injectable.dart';
import 'package:my_horses/models/horse_model.dart';
import 'package:my_horses/state_models/horse_list_model.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection('dev');

  group('HorseListModel', () {
    test('should add new horse', () async {
      final repository = MockRepository();
      final horse = Horse("Sanid");
      final model = getIt<HorseListModel>();

      model.addHorse(horse);

      expect(model.horses, [horse]);
      expect(repository.saveCount, 1);
    });

    test('should remove horse', () async {
      final repository = MockRepository();
      final arisToRemove = Horse("Aris");
      final sandi = Horse("Sanid");
      final horses = [sandi, arisToRemove];
      final modelWithHorses =
          HorseListModel(repository: repository, horses: horses);

      modelWithHorses.removeHorse(arisToRemove);

      expect(modelWithHorses.horses, [sandi]);
    });

    test('should load horses from the repository', () async {
      final horses = [Horse("Aris"), Horse("Sandi")];
      final repository = MockRepository(horses);
      final model = HorseListModel(repository: repository);

      expect(model.isLoading, isFalse);
      expect(model.horses, []);

      final loading = model.loadHorses();

      expect(model.isLoading, isTrue);

      await loading;
      expect(model.isLoading, isFalse);
      expect(model.horses, horses);
    });

    test('should update horse', () async {
      final aris = Horse("Aris");
      final sandi = Horse("Sandi");
      final sandiCopy = sandi.copy(note: "Czarny");
      final repository = MockRepository();
      final model =
          HorseListModel(repository: repository, horses: [aris, sandi]);

      model.updateHorse(sandiCopy);

      expect(model.horses, [aris, sandiCopy]);
      expect(repository.saveCount, 1);
    });
  });
}
