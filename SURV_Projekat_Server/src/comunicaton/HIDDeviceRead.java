package comunicaton;

import java.io.IOException;

import com.codeminders.hidapi.HIDDevice;

public class HIDDeviceRead {
	private static final int BUF_SIZE = 64;

	private HIDDevice dev = null;

	public HIDDeviceRead(HIDDevice device) {
		this.dev = device;
	}

	public byte[] readFromDevice() {
		byte[] readBuf = new byte[BUF_SIZE];
		try {
			dev.enableBlocking();
			byte[] writeBuf = new byte[BUF_SIZE];
			writeBuf[0] = 0;
			dev.write(writeBuf);
			dev.read(readBuf);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return readBuf;
	}

	public void printFromSeznor(byte[] readBuf) {
		byte btn1 = readBuf[1];
		byte btn2 = readBuf[2];
		int anb = (readBuf[4] & 0xff) * 256 + (readBuf[3] & 0xff);
		System.out.println("led1 : " + btn1);
		System.out.println("led2 : " + btn2);
		System.out.println("buzz : " + anb);
		System.out.println("buzB : " + readBuf[5]);
		System.out.println("==============");
	}

}
