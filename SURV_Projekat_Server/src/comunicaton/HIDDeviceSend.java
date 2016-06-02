package comunicaton;

import java.io.IOException;

import com.codeminders.hidapi.HIDDevice;

public class HIDDeviceSend {

	HIDDevice dev = null;

	public HIDDeviceSend(HIDDevice device) {
		this.dev = device;
	}

	private static final int BUF_SIZE = 64;

	public void sendToAktuator(byte[] senzor) {

		byte[] writeBuf = new byte[BUF_SIZE];
		byte[] readBuf = new byte[BUF_SIZE];
		
		writeBuf[0] = 0;
		writeBuf[1] = senzor[1];
		writeBuf[2] = senzor[2];
		writeBuf[3] = senzor[3];
		writeBuf[4] = senzor[4];
		writeBuf[5] = senzor[5];

		try {
			dev.enableBlocking();
			dev.write(writeBuf);
			dev.read(readBuf);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
