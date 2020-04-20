import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

class LoadedModel extends ChangeNotifier {
  final RemoteConfigService remoteConfigService;
  bool _loaded = false;
  LoadedModel({
    this.remoteConfigService,
  });

  bool get loaded => _loaded;

  bool get color => remoteConfigService.color;

  void finishLoading() {
    _loaded = true;
    notifyListeners();
  }
}

class RemoteConfigService {
  final RemoteConfig _remoteConfig;

  static RemoteConfigService _instance;
  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: await RemoteConfig.instance,
      );
    }

    return _instance;
  }

  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  bool get color => _remoteConfig.getBool('black_protest');

  final defaults = <String, dynamic>{'black_protest': false};

  Future initialise() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print('Remote config fetch throttled: $exception');
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch(expiration: Duration(seconds: 0));
    await _remoteConfig.activateFetched();
  }
}
