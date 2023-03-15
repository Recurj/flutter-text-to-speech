import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rjbasic/library.dart';
import 'rjtexttospeech_platform_interface.dart';

/// An implementation of [RjTextToSpeechPluginPlatform] that uses method channels.
class MethodChannelRjTextToSpeechPlugin extends RjTextToSpeechPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rjtexttospeech');

  @override
  Future<List<RJLabelWithKey>> getEngines() async {
    return _map(await methodChannel.invokeMethod<Map>('getEngines'));
  }

  @override
  Future<List<RJLabelWithKey>> getLanguages(String lang) async {
    return _map(await methodChannel
        .invokeMethod<Map>('getLanguages', <String, Object>{'arg': lang}));
  }

  @override
  Future<List<RJLabelWithKey>> getVoices() async {
    return _map(await methodChannel.invokeMethod<Map>('getVoices'));
  }

  @override
  Future<bool> setEngine(String s) async {
    final rc = await methodChannel
        .invokeMethod<bool>('setEngine', <String, Object>{'arg': s});
    return rc ?? false;
  }

  @override
  Future<bool> setLanguage(String s) async {
    final rc = await methodChannel
        .invokeMethod<bool>('setLanguage', <String, Object>{'arg': s});
    return rc ?? false;
  }

  @override
  Future<bool> setVoice(String s) async {
    final rc = await methodChannel
        .invokeMethod<bool>('setVoice', <String, Object>{'arg': s});
    return rc ?? false;
  }

  @override
  Future<bool> setVolume(double volume) async {
    final rc = await methodChannel
        .invokeMethod<bool>('setVolume', <String, Object>{'arg': volume});
    return rc ?? false;
  }

  @override
  Future<bool> setPitch(double pitch) async {
    final rc = await methodChannel
        .invokeMethod<bool>('setPitch', <String, Object>{'arg': pitch});
    return rc ?? false;
  }

  @override
  Future<bool> setRate(double rate) async {
    final rc = await methodChannel
        .invokeMethod<bool>('setRate', <String, Object>{'arg': rate});
    return rc ?? false;
  }

  @override
  Future<bool> speak(String s) async {
    final rc = await methodChannel.invokeMethod<bool>('play', <String, Object>{
      'arg': s,
    });
    return rc ?? false;
  }

  @override
  Future<bool> stop() async {
    final rc = await methodChannel.invokeMethod<bool>('stop');
    return rc ?? false;
  }

  List<RJLabelWithKey> _map(Map? v) {
    final List<RJLabelWithKey> rc = [];
    if (v != null) {
      v.forEach((key, label) {
        String v = label as String;
        rc.add(RJLabelWithKey(key, v));
      });
    }
    return rc;
  }
}
