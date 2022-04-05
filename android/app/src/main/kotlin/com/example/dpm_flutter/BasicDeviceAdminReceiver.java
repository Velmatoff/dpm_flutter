package com.example.dpm_flutter;

import android.app.admin.DeviceAdminReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

public class BasicDeviceAdminReceiver extends DeviceAdminReceiver {

    @Override
    public void onProfileProvisioningComplete(@NonNull Context context, @NonNull Intent intent) {
//        final PostProvisioningHelper helper = new PostProvisioningHelper(context);
//        if (!helper.isDone()) {
//            // EnableProfileActivity is launched with the newly set up profile.
//            Intent launch = new Intent(context, EnableProfileActivity.class);
//            launch.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            context.startActivity(launch);
//        }
    }

    public static ComponentName getComponentName(Context context) {
        return new ComponentName(context.getApplicationContext(), BasicDeviceAdminReceiver.class);
    }

}
