// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_horses/infrastructure/injectable_modules.dart';
import 'package:my_horses/infrastructure/firebase_user_mapper.dart';
import 'package:my_horses/infrastructure/mock_repository.dart';
import 'package:my_horses/domain/horses_repository.dart';
import 'package:my_horses/models/horse_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_horses/infrastructure/firebase_user_repository.dart';
import 'package:my_horses/domain/user_repository.dart';
import 'package:my_horses/state_models/auth_state_model.dart';
import 'package:my_horses/state_models/horse_list_model.dart';
import 'package:my_horses/infrastructure/repository.dart';
import 'package:my_horses/state_models/signin_state_model.dart';
import 'package:get_it/get_it.dart';

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final injectableModules = _$InjectableModules();
  g.registerLazySingleton<FirebaseAuth>(() => injectableModules.firebaseAuth);
  g.registerLazySingleton<FirebaseUserMapper>(() => FirebaseUserMapper());
  final sharedPreferences = await injectableModules.prefs;
  g.registerFactory<SharedPreferences>(() => sharedPreferences);
  g.registerFactory<AuthStateModel>(
      () => AuthStateModel(userRepo: g<UserRepository>()));
  g.registerFactoryParam<HorseListModel, List<Horse>, dynamic>((horses, _) =>
      HorseListModel(repository: g<HorsesRepository>(), horses: horses));
  g.registerFactory<SignInStateModel>(
      () => SignInStateModel(userRepo: g<UserRepository>()));

  //Register test Dependencies --------
  if (environment == 'test') {
    g.registerFactoryParam<HorsesRepository, List<Horse>, dynamic>(
        (horses, _) => MockRepository(horses));
  }

  //Register dev Dependencies --------
  if (environment == 'dev') {
    g.registerLazySingleton<UserRepository>(() =>
        FirebaseUserRepository(g<FirebaseAuth>(), g<FirebaseUserMapper>()));
    g.registerLazySingleton<HorsesRepository>(
        () => LocalStorageRepository(g<SharedPreferences>()));
  }
}

class _$InjectableModules extends InjectableModules {}
