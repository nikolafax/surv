package comunicaton;

import java.io.IOException;
import java.util.List;

import com.codeminders.hidapi.HIDDevice;

import converter.DataProcessor;
import life.FailureDetector;
import messages.MessageQeue;

public class HIDDeviceRead implements Runnable {
	private static final int BUF_SIZE = 64;

	private HIDDevice dev = null;
	private DataProcessor dataProcessor;
	private MessageQeue messageQeue;

	public HIDDeviceRead(HIDDevice device, Comunicator comunicator, MessageQeue messageQeue,
			FailureDetector failureDetector) {
		this.dev = device;
		dataProcessor = new DataProcessor(comunicator, failureDetector);
		this.messageQeue = messageQeue;

	}

	public byte[] readFromDevice() {
		byte[] readBuf = new byte[BUF_SIZE];
		byte[] writeBuf = new byte[BUF_SIZE];
		writeBuf[0] = 0;
		writeBuf[2] = 0;

		try {
			dev.write(writeBuf);
			dev.read(readBuf);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return readBuf;
	}

	@Override
	public void run() {
		while (true) {
			byte[] readFromDevice = readFromDevice();
			List<byte[]> datOutputData = dataProcessor.getDatOutputData(readFromDevice);
			
			if(datOutputData == null) 
				continue;
			for (byte[] procesedDataFromComunicator : datOutputData) {
				messageQeue.put(procesedDataFromComunicator);
			}
		}

	}

}
