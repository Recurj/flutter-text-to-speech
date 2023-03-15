import Flutter
import UIKit

public class SwiftRjTextToSpeechPlugin: NSObject, FlutterPlugin {
    let player=Player()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "rjtexttospeech", binaryMessenger: registrar.messenger())
        let instance = SwiftRjTextToSpeechPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        do {
            switch (call.method) {
            case "getEngines":result(player.getEngines())
            case "getLanguages" :getLanguages(call, result);
            case "getVoices" : result(player.getVoices())
            case "setEngine" : setEngine(call, result);
            case "setLanguage" : setLanguage(call, result);
            case "setVoice" : setVoice(call, result);
            case "setVolume" : setVolume(call, result);
            case "setPitch" : setPitch(call, result);
            case "setRate" : setRate(call, result);
            case "play" :play(call, result);
            case "stop" :result(player.stop())
            default:
                result(FlutterMethodNotImplemented)
            }
            
        }
    }
    
    private func getLanguages(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        if let myArgs = call.arguments as? [String: Any],
           let arg = myArgs["arg"] as? String {
            result(player.getLanguages(arg));
            return
        }
        result(false)
    }
    private func setEngine(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        if let myArgs = call.arguments as? [String: Any],
           let arg = myArgs["arg"] as? String {
            if (!arg.isEmpty) {
                result(player.setEngine((arg)))
                return
            }
        }
        result(false)
    }
    
    private func setLanguage(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        if let myArgs = call.arguments as? [String: Any],
           let arg = myArgs["arg"] as? String {
            if (!arg.isEmpty) {
                result(player.setLanguage((arg)))
                return
            }
        }
        result(false)
    }
    
    private func setVoice(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        if let myArgs = call.arguments as? [String: Any],
           let arg = myArgs["arg"] as? String {
            if (!arg.isEmpty) {
                result(player.setVoice((arg)))
                return
            }
        }
        result(false)
    }
    
    private func setVolume(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    // the range of 0.0 for silent to 1.0 for loudest volume.
    // The default value is 1.0.
        if let myArgs = call.arguments as? [String: Any],
           let volume = myArgs["arg"] as? Double {
            if (volume >= 0.0 && volume <= 1.0) {
                result(player.setVolume(Float(volume)))
                return
            }
        }
        result(player.setVolume(1.0f)
    }
    
    private func setPitch(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    // within the range of 0.5 for lower pitch to 2.0 for higher pitch.
    // The default value is 1.0.
        if let myArgs = call.arguments as? [String: Any],
           let pitch = myArgs["arg"] as? Double {
            if (pitch >= 0.5 && pitch <= 2.0) {
                result(player.setPitch(Float(pitch)))
                return
            }
        }
       result(player.setPitch(1.0f);
    }
    
    private func setRate(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        if let myArgs = call.arguments as? [String: Any],
           let rate = myArgs["arg"] as? Double {
            if (rate >= 0.0 && rate <= 1.0) {
                result(player.setRate(Float(rate)*(AVSpeechUtteranceMaximunSpeechRate-AVSpeechUtteranceMinimumSpeechRate)+AVSpeechUtteranceMinimumSpeechRate))
                return
            }
        }
        result(player.setRate(AVSpeechUtteranceDefaultSpeechRate)
    }
    
    private func play(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        if let myArgs = call.arguments as? [String: Any],
           let arg = myArgs["arg"] as? String {
            if (!arg.isEmpty) {
                result(player.speak(arg))
                return
            }
        }
        result(false)
    }
}
