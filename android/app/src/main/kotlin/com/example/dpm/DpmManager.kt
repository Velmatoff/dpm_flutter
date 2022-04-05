package com.example.dpm

import android.annotation.SuppressLint
import android.app.Activity
import android.app.admin.DevicePolicyManager
import android.app.admin.DevicePolicyManager.ACTION_PROVISION_MANAGED_PROFILE
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import android.widget.Toast
import androidx.annotation.RequiresApi
import com.example.dpm_flutter.BasicDeviceAdminReceiver
import io.flutter.embedding.engine.plugins.FlutterPlugin

class DpmManager(private val activity: Activity) : FlutterPlugin, Dpm.DpmSender{

    private val manager =
        activity.getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
    private val component = ComponentName(activity, BasicDeviceAdminReceiver::class.java.name)

    private companion object {
        private const val TAG = "Dpm Manager"
        private var sink: Dpm.DpmReceiver? = null

    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        try {
            Dpm.DpmSender.setup(binding.binaryMessenger, this)
            sink = Dpm.DpmReceiver(binding.binaryMessenger)
        } catch (error: Throwable) {
            Log.e(TAG, "Ошибка подключения")
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        try {
            Dpm.DpmSender.setup(binding.binaryMessenger, null)
            sink = null
        } catch (error: Throwable) {
            Log.e(TAG, "Ошибка отключения")
        }
    }

    override fun isProfileOwnerApp(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            manager.isProfileOwnerApp(activity.applicationContext.packageName)
        } else {
            TODO("VERSION.SDK_INT < LOLLIPOP")
        }
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun createWorkProfile() {

        val intent = Intent(ACTION_PROVISION_MANAGED_PROFILE)

        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            Log.e(TAG, "Рабочий профиль не поддерживается")
        } else {
            intent.putExtra(
                DevicePolicyManager.EXTRA_PROVISIONING_DEVICE_ADMIN_COMPONENT_NAME,
                component
            )
        }

        if (intent.resolveActivity(activity.getPackageManager()) != null) {
            activity.startActivityForResult(intent, 1)
        } else {
        }
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun enableWorkProfile() {
        manager.setProfileName(component,"Work Profile")
        manager.setProfileEnabled(component)
    }

    override fun setSysApp(name: String) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                manager.enableSystemApp(
                    BasicDeviceAdminReceiver.getComponentName(activity), name
                )
            }
        } catch (error: Throwable) {
            Log.e(TAG, "Ошибка установки приложения $name")
        }




    }

    override fun screenCapturePolicy(enable: Boolean) : Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            manager.setScreenCaptureDisabled(component,enable)
            return enable
        } else {
            return !enable
        }

    }
}