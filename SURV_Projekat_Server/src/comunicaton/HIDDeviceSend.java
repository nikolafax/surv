package comunicaton;

import java.io.IOException;

import com.codeminders.hidapi.HIDDevice;

import messages.MessageQeue;

public class HIDDeviceSend implements Runnable {

	HIDDevice dev = null;
	MessageQeue messageQeue;

	public HIDDeviceSend(HIDDevice device, MessageQeue messageQeue) {
		this.dev = device;
		this.messageQeue = messageQeue;
	}

	private static final int BUF_SIZE = 64;

	private void sendToAktuator(byte[] senzor) {

		byte[] writeBuf = new byte[BUF_SIZE];

		writeBuf[0] = 0;
		writeBuf[1] = senzor[1];
		writeBuf[2] = senzor[2];
		writeBuf[3] = senzor[3];

		try {
			dev.write(writeBuf);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void run() {
		while (true) {
			byte[] writeBuf = messageQeue.take();
			System.out.println("send" + System.currentTimeMillis());
			if (writeBuf != null) {
				sendToAktuator(writeBuf);
			}
		}

	}
}
