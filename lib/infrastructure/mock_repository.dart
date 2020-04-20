import 'package:injectable/injectable.dart';
import 'package:my_horses/domain/horse_entity.dart';
import 'package:my_horses/domain/horses_repository.dart';
import 'package:my_horses/models/horse_model.dart';

@injectable
@RegisterAs(HorsesRepository, env: 'test')
class MockRepository extends HorsesRepository {
  List<HorseEntity> entities;
  int saveCount = 0;

  MockRepository([@factoryParam List<Horse> horses = const []])
      : entities = horses.map((it) => it.toEntity()).toList();

  @override
  Future<List<HorseEntity>> loadHorses() async => entities;

  @override
  Future saveHorses(List<HorseEntity> horses) async {
    saveCount++;
    entities = horses;
  }
}
