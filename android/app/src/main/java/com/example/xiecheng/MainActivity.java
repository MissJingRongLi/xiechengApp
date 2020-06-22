package com.example.xiecheng;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import androidx.annotation.NonNull;

import com.example.plugin.asr.AsrPlugin;
import com.flutter_webview_plugin.FlutterWebviewPlugin;

public class MainActivity extends FlutterActivity {


//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(this);
//        registerSelfPlugin();
//    }

    //channel的名称，由于app中可能会有多个channel，这个名称需要在app内是唯一的。
    private static final String CHANNEL = "flutter_asr_plugin";
    private MethodChannel mothodChannel;
    private static String TAG = "MainActivity";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        mothodChannel = new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL);
        Log.i(TAG, "start");

        ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
        FlutterWebviewPlugin.registerWith(shimPluginRegistry.registrarFor("com.flutter_webview_plugin.FlutterWebviewPlugin"));

        mothodChannel.setMethodCallHandler((methodCall, result) -> {
            Log.i(TAG, "{$methodCall.method}");
            //call.method是获取调用的方法名字
            if("start".equals(methodCall.method)){
                Log.i(TAG, "$methodCall=}");
                methodCall.argument("com.flutter_webview_plugin.FlutterWebviewPlugin");
            }

            //call.arguments 是获取参数
        });
    }

    //百度语音监听
//    private void registerSelfPlugin(@NonNull FlutterEngine flutterEngine) {
//        ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
//        AsrPlugin.registerWith(shimPluginRegistry.registrarFor("com.example.plugin.asr.AsrPlugin"));
//    }
}