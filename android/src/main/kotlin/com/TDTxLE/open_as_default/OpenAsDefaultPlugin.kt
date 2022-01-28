package com.TDTxLE.open_as_default

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result





/** OpenAsDefaultPlugin */
class OpenAsDefaultPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  var uriToUse: String? = ""
  private var binding: ActivityPluginBinding? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {





    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "open_as_default")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getFileIntent") {

      val batteryLevel = uriToUse
      if (batteryLevel != null || batteryLevel!="") {
        result.success(batteryLevel)
      } else {
        result.error("UNAVAILABLE", "Battery level not available.", null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.binding = binding
    //binding.addOnNewIntentListener(this)



    // ::::::::::::: validar si es que llego algun archivo :::::::::::::::::::
    val parameters = binding.activity.intent.extras
    if (parameters != null) uriToUse = parameters.getString("uri", "")

    try {
      val intent = binding.activity.intent
      if (intent != null && intent.data != null && intent.data.toString()
                      .contains("content://")
      ) {
        uriToUse = intent.data.toString()
        //println(uriToUse)
      }
    } catch (e: Exception) {
      uriToUse = ""
    }
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }


}
