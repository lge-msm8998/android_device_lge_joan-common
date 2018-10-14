package org.lineageos.settings.device.dac;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.media.AudioManager;
import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;
import android.util.Log;

import org.lineageos.settings.device.dac.utils.QuadDAC;

public class QuadDACTileService extends TileService {

    private final static String TAG = "QuadDACTileService";

    private String QDAC_ON = getString(R.string.quad_dac_on);
    private String QDAC_OFF = getString(R.string.quad_dac_off);
    private String QDAC_UNAVAIL = getString(R.string.quad_dac_unavail);

    private HeadsetPluggedTileReceiver headsetPluggedTileReceiver = new HeadsetPluggedTileReceiver();

    @Override
    public void onClick() {
        super.onClick();

        if(QuadDAC.isEnabled())
        {
            QuadDAC.disable();
            setTileInactive();
        } else {
            QuadDAC.enable();
            setTileActive();
        }
    }

    @Override
    public void onStartListening() {
        super.onStartListening();

        IntentFilter filter = new IntentFilter(Intent.ACTION_HEADSET_PLUG);
        registerReceiver(headsetPluggedTileReceiver, filter);

        AudioManager am = getSystemService(AudioManager.class);

        if(!am.isWiredHeadsetOn())
        {
            setTileUnavailable();
	    return;
        }
	
	if(QuadDAC.isEnabled())
	{
	    setTileActive();
	} else {
	    setTileInactive();
	}
    }

    @Override
    public void onStopListening() {
        super.onStopListening();

        unregisterReceiver(headsetPluggedTileReceiver);

    }

    private void setTileActive()
    {
        Tile quaddactile = getQsTile();
        quaddactile.setState(Tile.STATE_ACTIVE);
        quaddactile.setLabel(QDAC_ON);
	quaddactile.updateTile();
    }

    private void setTileInactive()
    {
        Tile quaddactile = getQsTile();
        quaddactile.setState(Tile.STATE_INACTIVE);
        quaddactile.setLabel(QDAC_OFF);
	quaddactile.updateTile();
    }

    private void setTileUnavailable()
    {
        Tile quaddactile = getQsTile();
        quaddactile.setState(Tile.STATE_UNAVAILABLE);
        quaddactile.setLabel(QDAC_UNAVAIL);
	quaddactile.updateTile();
    }

    private class HeadsetPluggedTileReceiver extends BroadcastReceiver {

        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals(Intent.ACTION_HEADSET_PLUG)) {
                int state = intent.getIntExtra("state", -1);
                switch(state)
                {
                    case 1: // Headset plugged in
                        if(QuadDAC.isEnabled())
                        {
                            setTileActive();
                        } else {
                            setTileInactive();
                        }
                        break;
                    case 0: // Headset unplugged
                        setTileUnavailable();
                        break;
                    default: break;
                }
            }
        }
    }

}
