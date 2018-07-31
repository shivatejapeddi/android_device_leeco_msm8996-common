/*
 *  LeEco Extras Settings Module
 *  Made by @andr68rus 2017
 */

package com.lineageos.settings.lepref;

import android.app.ActionBar;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.Intent;
import android.os.Bundle;
import android.preference.Preference;
import android.preference.Preference.OnPreferenceChangeListener;
import android.preference.PreferenceActivity;
import android.preference.PreferenceScreen;
import android.preference.SwitchPreference;
import android.preference.Preference.OnPreferenceClickListener;
import android.preference.PreferenceScreen;
import android.provider.Settings;
import android.view.Menu;
import android.view.MenuItem;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Date;

import android.util.Log;
import android.os.SystemProperties;
import java.io.*;
import android.widget.Toast;
import android.preference.ListPreference;

import com.lineageos.settings.lepref.R;

public class LePrefSettings extends PreferenceActivity implements OnPreferenceChangeListener {
	private static final boolean DEBUG = false;
	private static final String TAG = "LePref";

	private static final String QC_SYSTEM_PROPERTY = "persist.sys.le_fast_chrg_enable";

    private static final String SYSTEM_PROPERTY_CAMERA_FOCUS_FIX = "persist.camera.focus_fix";

    private static final String SYSTEM_PROPERTY_PM_KRNL_WL_BLOCK = "persist.pm.krnl_wl_block";
    private static final String SYSTEM_PROPERTY_PM_KRNL_WL_QCOM_RX = "persist.pm.krnl_wl_qcom_rx";

        private Preference mKcalPref;
	private SwitchPreference mEnableQC;
	private SwitchPreference mCameraFocusFix;

	private SwitchPreference mKrnlWlBlock;
	private SwitchPreference mKrnlWlQcomRX;

    private Preference mSaveLog;

    private Context mContext;
    private SharedPreferences mPreferences;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.le_settings);
        mKcalPref = findPreference("kcal");
                mKcalPref.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
                     @Override
                     public boolean onPreferenceClick(Preference preference) {
                         Intent intent = new Intent(getApplicationContext(), DisplayCalibration.class);
                         startActivity(intent);
                         return true;
                     }
                });
        mContext = getApplicationContext();
 
        mEnableQC = (SwitchPreference) findPreference(QC_SYSTEM_PROPERTY);
        if( mEnableQC != null ) {
            mEnableQC.setChecked(SystemProperties.getBoolean(QC_SYSTEM_PROPERTY, false));
            mEnableQC.setOnPreferenceChangeListener(this);
        }

        mCameraFocusFix = (SwitchPreference) findPreference(SYSTEM_PROPERTY_CAMERA_FOCUS_FIX);
        if( mCameraFocusFix != null ) {
            mCameraFocusFix.setChecked(SystemProperties.getBoolean(SYSTEM_PROPERTY_CAMERA_FOCUS_FIX, false));
            mCameraFocusFix.setOnPreferenceChangeListener(this);
        }

        mKrnlWlBlock = (SwitchPreference) findPreference(SYSTEM_PROPERTY_PM_KRNL_WL_BLOCK);
        if( mKrnlWlBlock != null ) {
            mKrnlWlBlock.setChecked(SystemProperties.getBoolean(SYSTEM_PROPERTY_PM_KRNL_WL_BLOCK, false));
            mKrnlWlBlock.setOnPreferenceChangeListener(this);
        }

        mKrnlWlQcomRX = (SwitchPreference) findPreference(SYSTEM_PROPERTY_PM_KRNL_WL_QCOM_RX);
        if( mKrnlWlQcomRX != null ) {
            mKrnlWlQcomRX.setChecked(SystemProperties.getBoolean(SYSTEM_PROPERTY_PM_KRNL_WL_QCOM_RX, false));
            mKrnlWlQcomRX.setOnPreferenceChangeListener(this);
        }

}

    private void setEnable(String key, boolean value) {
	    if(value) {
		    SystemProperties.set(key, "1");
    	} else {
    		SystemProperties.set(key, "0");
    	}
    	if (DEBUG) Log.d(TAG, key + " setting changed");
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
            return true;
        }
        return false;
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {
        final String key = preference.getKey();
        boolean value;
        String strvalue;
        if (DEBUG) Log.d(TAG, "Preference changed.");

    	value = (Boolean) newValue;
    	((SwitchPreference)preference).setChecked(value);
    	setEnable(key,value);
    	return true;
    }
}
