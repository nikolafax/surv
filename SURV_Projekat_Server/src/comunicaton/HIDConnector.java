package comunicaton;

import java.io.IOException;

import com.codeminders.hidapi.HIDDevice;
import com.codeminders.hidapi.HIDDeviceInfo;
import com.codeminders.hidapi.HIDManager;

public class HIDConnector {

	public HIDDevice connectToSenzor(HIDManager hidMgr, String deviceName) throws IOException {
		HIDDevice dev = null;
		System.out.println("trazim plocu");
		// dohvatamo listu svih HID USB uredjaja
		while (true) {
			HIDDeviceInfo[] infos = hidMgr.listDevices();

			for (HIDDeviceInfo info : infos) {
				// pronadjemo USB vezu sa mikrokontrolerom
				String product_string = info.getProduct_string() == null ? "" : info.getProduct_string();
				System.out.println("found dev : " + info.getProduct_string());
				if (product_string.compareTo(deviceName) == 0) {
					dev = info.open();
					dev.enableBlocking();
					break;
				}
			}
			if (dev != null)
				break;
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		System.out.println("nasao: " + deviceName);
		return dev;
	}
}
