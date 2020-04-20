import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_horses/injectable.iconfig.dart';

final getIt = GetIt.instance;

@injectableInit
void configureInjection(String environment) =>
    $initGetIt(getIt, environment: environment);

abstract class Env {
  static const test = 'test';
  static const dev = 'dev';
  static const prod = 'prod';
}
