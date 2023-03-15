package org.recurj.rjaudioplayer

import android.annotation.TargetApi
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.speech.tts.*
import android.util.Log
import java.util.*
import kotlin.collections.HashMap

const val defEngine = "com.google.android.tts"

class Player(val context: Context) : TextToSpeech.OnInitListener {
    private var tts: TextToSpeech? = null
    private var readyEngine = false;
    private var readyLang: Locale? = null;
    fun load() {
        setEngine(defEngine)
        setVolume(1.0f)
    }

    override fun onInit(status: Int) {
        readyEngine = (status == TextToSpeech.SUCCESS);
        if (readyEngine) configure();
    }

    private fun configure() {
        try {
            tts!!.setSpeechRate(1.0f)
            tts!!.setPitch(0.5f)
        } catch (e: Exception) {
            e.printStackTrace();
        }
    }

    fun getEngines(): HashMap<String, String>? {
        val engines = hashMapOf<String, String>()
        for (engineInfo in tts!!.engines) {
            engines[engineInfo.name] = engineInfo.label;
        }
        return engines;
    }

    fun getLanguages(filter: String): HashMap<String, String>? {
        if (readyEngine) {
            val locales = hashMapOf<String, String>()
            if (filter.isEmpty()) {
                for (locale in tts!!.availableLanguages) {
                    locales[locale.toLanguageTag()] = locale.displayName
                }
            } else {
                val loc = Locale(filter).language
                for (locale in tts!!.availableLanguages) {
                    if (locale.language.equals(loc)) {
                        locales[locale.toLanguageTag()] = locale.displayName
                    }
                }
            }
            return locales;
        }
        return null
    }

    fun getVoices(): HashMap<String, String>? {
        if (readyLang != null) {
            val voices = hashMapOf<String, String>()
            for (voice in tts!!.voices) {
                if (voice.locale == readyLang) {
                    voices[voice.name] = voice.name
                }
            }
            return voices;
        }
        return null;
    }

    fun setEngine(engine: String): Boolean {
        tts = TextToSpeech(context, this, engine)
        if (readyEngine) configure();
        return readyEngine;
    }

    fun setLanguage(lang: String): Boolean {
        if (readyEngine) {
            readyLang = null
            val locale: Locale = Locale.forLanguageTag(lang)
            val result = tts!!.setLanguage(locale)
            if (result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                return false;
            }
            readyLang = locale
            return true
        }
        return false;
    }

    fun setVoice(voice: String): Boolean {
        if (readyLang != null)
            for (ttsVoice in tts!!.voices) {
                if (ttsVoice.name == voice && ttsVoice.locale == readyLang) {
                    tts!!.voice = ttsVoice
                    return true
                }
            }
        return false;
    }

    fun setPitch(pitch: Float) : Boolean {
        if (readyLang != null) {
            tts!!.setPitch(pitch)
            return true
        }
        return false
    }

    fun setRate(rate: Float) : Boolean {
        if (readyLang != null) {
            tts!!.setSpeechRate(rate)
            return true
        }
        return false
    }

    fun setVolume(vol: Float) : Boolean {
        Bundle().putFloat(TextToSpeech.Engine.KEY_PARAM_VOLUME, vol)
        return  true
    }

    fun speak(text: String): Boolean {
        if (readyLang != null) {
            tts!!.speak(text, TextToSpeech.QUEUE_FLUSH, null, "")
            return true;
        }
        return false;
    }

    fun stop(): Boolean {
        if (readyEngine) {
            tts!!.stop()
            return true;
        }
        return false;
    }
}
