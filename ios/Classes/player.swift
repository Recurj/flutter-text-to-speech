

import AVFoundation
import Flutter

class Player {
    let tts = AVSpeechSynthesizer()
    var readyLang: Locale?
    var voice: AVSpeechSynthesisVoice?
    var rate: Float = AVSpeechUtteranceDefaultSpeechRate
    var volume: Float = 1.0
    var pitch: Float = 1.0
    
    
    public func getEngines()-> [String: Any] {
        let engines: [String: Any]=["iOS":"iOS"]
        return engines;
    }
    
    public func getLanguages(_ filter: String)-> [String: Any] {
        var locales :[String: Any]=[:];
        let locale: Locale = .current
        
        if (filter.isEmpty) {
            for voice in AVSpeechSynthesisVoice.speechVoices() {
                if let name = displayName(locale, voice.language) {
                    locales[voice.language] = name
                }
            }
        } else {
            let sf=filter.lowercased();
            for voice in AVSpeechSynthesisVoice.speechVoices() {
                if (voice.language.lowercased().hasPrefix(sf)) {
                    if let name = displayName(locale, voice.language) {
                        locales[voice.language] = name
                    }
                }
            }
        }
        
        return locales;
    }
    
    public func getVoices()-> [String: Any] {
        var voices : [String: Any]=[:];
        if let lang = readyLang  {
            let s=lang.identifier;
            for voice in AVSpeechSynthesisVoice.speechVoices() {
                if (voice.language == s) {
                    voices[voice.identifier] = voice.name
                }
            }
        }
        return voices;
    }
    
    public func setEngine(_ engine: String)->Bool {
        return true;
    }
    
    public func setLanguage(_ lang: String)->Bool {
        readyLang=Locale(identifier: lang)
        return true;
    }
    
    public func setVoice(_ id: String)->Bool {
        if let voice =  AVSpeechSynthesisVoice.speechVoices().first(where: { $0.identifier==id }) {
            self.voice=voice
            return true
        }
        return false;
    }
    
    public func setPitch(_ pitch: Float) ->Bool {
        self.pitch=pitch
        return true
    }
    
    public func setRate(_ rate: Float) ->Bool {
        self.rate=rate
        return true
    }
    
    public func setVolume(_ vol: Float) ->Bool {
        self.volume=vol;
        return true
    }
    
    public func speak(_ text: String)->Bool {
        if let v = voice {
            let utterance=AVSpeechUtterance(string: text)
            utterance.voice=v
            utterance.rate=self.rate
            utterance.pitchMultiplier=self.pitch
            utterance.volume=self.volume
            tts.speak(utterance)
            return true;
        }
        return false;
    }
    
    public func stop()->Bool {
        tts.stopSpeaking(at: .immediate)
        return true;
    }
    private func displayName(_ loc:Locale, _ id:String)->String? {
        let locale = loc as NSLocale;
        return locale.displayName(forKey: NSLocale.Key.identifier, value:id)
    }
}
