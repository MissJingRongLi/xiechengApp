package com.example.xiecheng;

import io.flutter.app.FlutterActivity;
import android.os.Bundle;

import com.example.plugin.asr.AsrPlugin;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private AsrPlugin FirebaseMessagingPlugin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(this);
        PluginRegistry registry = null;
        FirebaseMessagingPlugin.registerWith(
                registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
        registerSelfPlugin();
    }

    //百度语音监听
    private void registerSelfPlugin() {
        AsrPlugin.registerWith(registrarFor("com.example.plugin.asr.AsrPlugin"));
    }
}