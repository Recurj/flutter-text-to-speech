import 'rjtexttospeech_platform_interface.dart';
import 'package:rjbasic/library.dart';

class RjTextToSpeech {
  String engine = "";
  String voice = "";
  String language = "";

  Future<bool> speak(String txt) async {
    if (txt.isNotEmpty) {
      return await RjTextToSpeechPluginPlatform.instance.speak(txt);
    }
    return false;
  }

  Future<bool> stop() async {
    return await RjTextToSpeechPluginPlatform.instance.stop();
  }

  Future<List<RJLabelWithKey>> getEngines() =>
      RjTextToSpeechPluginPlatform.instance.getEngines();

  Future<List<RJLabelWithKey>> getLanguages(String lang) =>
      RjTextToSpeechPluginPlatform.instance.getLanguages(lang);

  Future<List<RJLabelWithKey>> getVoices() =>
      RjTextToSpeechPluginPlatform.instance.getVoices();

  Future<bool> setEngine(String v) async {
    if (engine == v) return true;
    if (await RjTextToSpeechPluginPlatform.instance.setEngine(v)) {
      engine = v;
      return true;
    }
    return false;
  }

  Future<bool> setLanguage(String v) async {
    if (language == v) return true;
    if (await RjTextToSpeechPluginPlatform.instance.setLanguage(v)) {
      language = v;
      return true;
    }
    return false;
  }

  Future<bool> setVoice(String v) async {
    if (voice == v) return true;
    if (await RjTextToSpeechPluginPlatform.instance.setVoice(v)) {
      voice = v;
      return true;
    }
    return false;
  }

  Future<bool> setPitch(double d) =>
      RjTextToSpeechPluginPlatform.instance.setPitch(d);

  Future<bool> setVolume(double d) =>
      RjTextToSpeechPluginPlatform.instance.setVolume(d);

  Future<bool> setRate(double d) =>
      RjTextToSpeechPluginPlatform.instance.setRate(d);
}
