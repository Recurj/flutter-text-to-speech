import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:rjbasic/library.dart';
import 'rjtexttospeech_method_channel.dart';

abstract class RjTextToSpeechPluginPlatform extends PlatformInterface {
  /// Constructs a RjtexttospeechPlatform.
  RjTextToSpeechPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static RjTextToSpeechPluginPlatform _instance =
      MethodChannelRjTextToSpeechPlugin();

  /// The default instance of [RjtexttospeechPlatform] to use.
  ///
  /// Defaults to [MethodChannelRjTextToSpeechPlugin].
  static RjTextToSpeechPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RjtexttospeechPlatform] when
  /// they register themselves.
  static set instance(RjTextToSpeechPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<RJLabelWithKey>> getEngines() {
    throw UnimplementedError(RJManagerPlugin.notImplemented('getEngines'));
  }

  Future<List<RJLabelWithKey>> getLanguages(String lang) {
    throw UnimplementedError(RJManagerPlugin.notImplemented('getLanguages'));
  }

  Future<List<RJLabelWithKey>> getVoices() {
    throw UnimplementedError(RJManagerPlugin.notImplemented('getVoices'));
  }

  Future<bool> setEngine(String s) {
    throw UnimplementedError(RJManagerPlugin.notImplemented('setEngine'));
  }

  Future<bool> setLanguage(String s) {
    throw UnimplementedError(RJManagerPlugin.notImplemented('setLanguage'));
  }

  Future<bool> setVoice(String s) {
    throw UnimplementedError(RJManagerPlugin.notImplemented('setVoice'));
  }

  Future<bool> setVolume(double volume) {
    throw UnimplementedError(RJManagerPlugin.notImplemented('setVolume'));
  }

  Future<bool> setPitch(double pitch) {
    throw UnimplementedError(RJManagerPlugin.notImplemented('setPitch'));
  }

  Future<bool> setRate(double rate) {
    throw UnimplementedError(RJManagerPlugin.notImplemented('setRate'));
  }

  Future<bool> speak(String s) {
    throw UnimplementedError(RJManagerPlugin.notImplemented('speak'));
  }

  Future<bool> stop() {
    throw UnimplementedError(RJManagerPlugin.notImplemented('stop'));
  }
}
