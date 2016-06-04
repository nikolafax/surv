package comunicaton;

import java.io.IOException;
import java.io.Serializable;
import java.util.List;
import java.util.Vector;

import com.codeminders.hidapi.HIDDevice;
import com.codeminders.hidapi.HIDManager;

import beans.Aktuatator;
import beans.Senzor;
import converter.DataProcessor;

public class Comunicator implements Serializable, Runnable {

	static {
		System.load("D:\\native\\hidapi-jni.dll");
	}

	private static final long serialVersionUID = 6951379001754652085L;
	private static final int BUF_SIZE = 64;

	private HIDDevice dev = null;
	private HIDManager hidMgr = null;

	private Vector<Senzor> senzors;
	private Vector<Aktuatator> aktuators;

	private HIDDeviceSend deviceSend;
	private HIDDeviceRead deviceRead;

	private DataProcessor processor;

	public Comunicator() {
		aktuators = new Vector<Aktuatator>();
		senzors = new Vector<Senzor>();

		deviceSend = new HIDDeviceSend(dev);
		deviceRead = new HIDDeviceRead(dev);

		processor = new DataProcessor(this);
		// setMockData();
	}

	public void connectHID() {
		try {
			hidMgr = HIDManager.getInstance();
			HIDConnector connector = new HIDConnector();
			dev = connector.connectToSenzor(hidMgr, "USB COMUNIC");
		} catch (IOException e) {
			e.printStackTrace();
			closeConnecton();
		}

	}

	public void closeConnecton() {
		try {
			dev.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		hidMgr.release();
	}

	@Override
	public void run() {
		connectHID();

		while (true) {
			if (deviceRead != null && deviceSend != null) {
				final byte[] readFromDevice = deviceRead.readFromDevice();
				procesDataFromComunicator(readFromDevice);
			}

		}

	}

	private void procesDataFromComunicator(byte[] readFromDevice) {
		final List<byte[]> datOutputData = processor.getDatOutputData(readFromDevice);
		for (byte[] procesedDataFromComunicator : datOutputData) {
			deviceSend.sendToAktuator(procesedDataFromComunicator);
		}
	}

	public Vector<Senzor> getSenzors() {
		return senzors;
	}

	public void setSenzors(Vector<Senzor> senzors) {
		this.senzors = senzors;
	}

	public Vector<Aktuatator> getActuators() {
		return aktuators;
	}

	public void setActuators(Vector<Aktuatator> actuators) {
		this.aktuators = actuators;
	}

	private void setMockData() {
		Aktuatator a = new Aktuatator();
		a.setId(1);
		aktuators.add(a);
		a = new Aktuatator();
		a.setId(2);
		aktuators.add(a);
		a = new Aktuatator();
		a.setId(3);
		aktuators.add(a);
		a = new Aktuatator();
		a.setId(4);
		aktuators.add(a);

		Senzor s = new Senzor();
		s.addAktuator(a);
		s.setId(5);
		senzors.add(s);
		s = new Senzor();
		s.setId(6);
		senzors.add(s);
	}
}
