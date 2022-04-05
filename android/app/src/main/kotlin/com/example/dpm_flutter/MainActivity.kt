package com.example.dpm_flutter

import com.example.dpm.DpmManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(DpmManager(this))
        super.configureFlutterEngine(flutterEngine)
    }
}
