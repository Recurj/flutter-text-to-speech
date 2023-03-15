package org.recurj.rjtexttospeech

import android.os.Bundle
import android.speech.tts.TextToSpeech
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.recurj.rjaudioplayer.Player
import java.io.File

class RjTextToSpeechPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var player: Player

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "rjtexttospeech")
        channel.setMethodCallHandler(this)
        player = Player(flutterPluginBinding.applicationContext)
        player.load()
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        try {
            when (call.method) {
                "getEngines" -> result.success(player.getEngines())
                "getLanguages" -> getLanguages(call, result);
                "getVoices" -> result.success(player.getVoices())
                "setEngine" -> setEngine(call, result);
                "setLanguage" -> setLanguage(call, result);
                "setVoice" -> setVoice(call, result);
                "setVolume" -> setVolume(call, result);
                "setPitch" -> setPitch(call, result);
                "setRate" -> setRate(call, result);
                "play" -> play(call, result);
                "stop" -> result.success(player.stop())
                else -> result.notImplemented()
            }
            return
        } catch (e: Exception) {
            e.printStackTrace();
        }
        result.error("Exception", null, null)


    }


    private fun getLanguages(@NonNull call: MethodCall, @NonNull result: Result) {
        val arg = call.argument<String>("arg")
        result.success(player.getLanguages(arg ?: ""))
    }

    private fun setEngine(@NonNull call: MethodCall, @NonNull result: Result) {
        val arg = call.argument<String>("arg")
        if (arg != null && arg.isNotEmpty()) result.success(player.setEngine((arg)))
        else result.success(false)
    }

    private fun setLanguage(@NonNull call: MethodCall, @NonNull result: Result) {
        val arg = call.argument<String>("arg")
        if (arg != null && arg.isNotEmpty()) result.success(player.setLanguage((arg)))
        else result.success(false)
    }

    private fun setVoice(@NonNull call: MethodCall, @NonNull result: Result) {
        val arg = call.argument<String>("arg")
        if (arg != null && arg.isNotEmpty()) result.success(player.setVoice((arg)))
        else result.success(false)
    }

    private fun setVolume(@NonNull call: MethodCall, @NonNull result: Result) {
        val volume = call.argument<Double>("arg")
        if (volume != null && volume in (0.0f..1.0f)) result.success(player.setVolume(volume.toFloat()))
        else result.success(false)
    }

    private fun setPitch(@NonNull call: MethodCall, @NonNull result: Result) {
        // 1.0 is the normal pitch,
        // lower values lower the tone of the synthesized voice,
        // greater values increase it.
        val pitch = call.argument<Double>("arg")
        if (pitch != null && pitch in (0.5f..2.0f)) result.success(player.setPitch(pitch.toFloat()))
        else result.success(false)
    }

    private fun setRate(@NonNull call: MethodCall, @NonNull result: Result) {
        // Speech rate. 1.0 is the normal speech rate,
        // lower values slow down the speech (0.5 is half the normal speech rate),
        // greater values accelerate it (2.0 is twice the normal speech rate).
        val rate = call.argument<Double>("arg")
        if (rate != null && rate in (0.0f..1.0f)) result.success(player.setRate(rate.toFloat() * 2.0f))
        else result.success(false)
    }

    private fun play(@NonNull call: MethodCall, @NonNull result: Result) {
        val arg = call.argument<String>("arg")
        if (arg != null && arg.isNotEmpty()) result.success(player.speak(arg))
        else result.success(false)
    }
}