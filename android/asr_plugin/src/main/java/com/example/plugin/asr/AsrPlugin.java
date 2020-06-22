package com.example.plugin.asr;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AsrPlugin implements MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
    private final static String TAG = "AsrPlugin";
    private final Activity activity;
    private ResultStateful resultStateful;
    private AsrManager asrManager;
    static MethodChannel channel;
    private static final String CHANNEL_NAME = "flutter_asr_plugin";

    public AsrPlugin(PluginRegistry.Registrar registrar){
        this.activity = registrar.activity();
    }

//    public static void registerWith(PluginRegistry.Registrar registrar) {
//        if (registrar.activity() != null) {
//            channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
//            final AsrPlugin instance = new AsrPlugin(registrar);
//            registrar.addActivityResultListener(instance);
//            channel.setMethodCallHandler(instance);
//        }
//    }

    //    public static void registerWith(PluginRegistry.Registrar registrar) {
//        MethodChannel channel = new MethodChannel(registrar.messenger(), "asr_plugin");
//        AsrPlugin instance = new AsrPlugin(registrar);
//        channel.setMethodCallHandler(instance);
//    }
//    public static void registerWith(@NonNull FlutterEngine flutterEngine) {
//        ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
//
//        com.example.plugin.asr.AsrPlugin.registerWith((FlutterEngine) shimPluginRegistry.registrarFor("com.example.plugin.asr.AsrPlugin"));
//    }
    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result){
        initPermission();
        switch (methodCall.method){
            case "start":
                resultStateful = ResultStateful.of(result);
                start(methodCall, resultStateful);
                break;
            case "stop":
                stop(methodCall, result);
                break;
            case "cancel":
                cancel(methodCall, result);
                break;
            default:
                result.notImplemented();
        }
    }
    //开始
    private void start(MethodCall call, ResultStateful result) {
        if(activity == null ){
            Log.e(TAG, "ignored start, current activity is null");
            result.error("ignored start, current activity is null", null, null);
            return;
        }
        if(getAsrManager() != null){
            getAsrManager().start(call.arguments instanceof Map ? (Map)call.arguments : null);
        }else{
            Log.e(TAG, "ignored start, current activity is null");
            result.error("ignored start, current activity is null", null, null);
        }
    }
    //停止
    private void stop(MethodCall call, MethodChannel.Result result){
        if(asrManager != null){
            asrManager.stop();
        }
    }
    //取消
    private void cancel(MethodCall call, MethodChannel.Result result){
        if(asrManager != null){
            asrManager.cancel();
        }
    }

    @Nullable
    private AsrManager getAsrManager(){
        if(asrManager == null){
            if(activity != null && !activity.isFinishing()){
                asrManager = new AsrManager(activity, onAsrListener);
            }
        }
        return asrManager;
    }

    private OnAsrListener onAsrListener = new OnAsrListener(){
        @Override
        public void onAsrReady() {

        }

        @Override
        public void onAsrBegin() {

        }

        @Override
        public void onAsrEnd() {

        }

        @Override
        public void onAsrPartialResult(String[] results, RecogResult recogResult) {

        }

        @Override
        public void onAsrOnlineNluResult(String nluResult) {

        }

        @Override
        public void onAsrFinalResult(String[] results, RecogResult recogResult){
            if(resultStateful != null){
                resultStateful.success(results[0]);
            }
        }

        @Override
        public void onAsrFinish(RecogResult recogResult) {

        }

        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {
            if(resultStateful != null){
                resultStateful.error(descMessage, null, null);
            }
        }

        @Override
        public void onAsrLongFinish() {

        }

        @Override
        public void onAsrVolume(int volumePercent, int volume) {

        }

        @Override
        public void onAsrAudio(byte[] data, int offset, int length) {

        }

        @Override
        public void onAsrExit() {

        }

        @Override
        public void onOfflineLoaded() {

        }

        @Override
        public void onOfflineUnLoaded() {

        }
    };


    /**
     * android 6.0 以上需要动态申请权限
     */
    private void initPermission() {
        String permissions[] = {Manifest.permission.RECORD_AUDIO,
                Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.INTERNET,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
        };

        ArrayList<String> toApplyList = new ArrayList<String>();

        for (String perm :permissions){
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(activity, perm)) {
                toApplyList.add(perm);
                //进入到这里代表没有权限.

            }
        }
        String tmpList[] = new String[toApplyList.size()];
        if (!toApplyList.isEmpty()){
            ActivityCompat.requestPermissions(activity, toApplyList.toArray(tmpList), 123);
        }

    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        return false;
    }
}
