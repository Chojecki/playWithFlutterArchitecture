// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:my_horses/infrastructure/mock_repository.dart';
import 'package:my_horses/domain/horses_repository.dart';
import 'package:my_horses/models/horse_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_horses/infrastructure/shared_preferences_injectable_module.dart';
import 'package:my_horses/state_models/horse_list_model.dart';
import 'package:my_horses/infrastructure/repository.dart';
import 'package:get_it/get_it.dart';

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final sharedPreferencesInjectableModule =
      _$SharedPreferencesInjectableModule();
  final sharedPreferences = await sharedPreferencesInjectableModule.prefs;
  g.registerFactory<SharedPreferences>(() => sharedPreferences);
  g.registerFactoryParam<HorseListModel, List<Horse>, dynamic>((horses, _) =>
      HorseListModel(repository: g<HorsesRepository>(), horses: horses));

  //Register test Dependencies --------
  if (environment == 'test') {
    g.registerFactoryParam<HorsesRepository, List<Horse>, dynamic>(
        (horses, _) => MockRepository(horses));
  }

  //Register dev Dependencies --------
  if (environment == 'dev') {
    g.registerLazySingleton<HorsesRepository>(
        () => LocalStorageRepository(g<SharedPreferences>()));
  }
}

class _$SharedPreferencesInjectableModule
    extends SharedPreferencesInjectableModule {}
