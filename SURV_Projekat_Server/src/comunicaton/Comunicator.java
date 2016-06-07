package comunicaton;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import com.codeminders.hidapi.HIDDevice;
import com.codeminders.hidapi.HIDManager;

import beans.Aktuatator;
import beans.Senzor;
import life.FailureDetector;
import messages.MessageQeue;

public class Comunicator implements Serializable, Runnable {

	static {
		System.load("D:\\native\\hidapi-jni.dll");
	}

	private static final long serialVersionUID = 6951379001754652085L;

	private HIDDevice dev = null;
	private HIDManager hidMgr = null;

	private Vector<Senzor> senzors;
	private Vector<Aktuatator> aktuators;

	private HIDDeviceSend deviceSend;
	private HIDDeviceRead deviceRead;

	private MessageQeue messageQeue;
	private FailureDetector failureDetector;

	public Comunicator() {
		aktuators = new Vector<Aktuatator>();
		senzors = new Vector<Senzor>();

		failureDetector = new FailureDetector(this, 5000);
		messageQeue = new MessageQeue(20);
		deviceSend = new HIDDeviceSend(dev, messageQeue);
		deviceRead = new HIDDeviceRead(dev, this, messageQeue, failureDetector);

		// setMockData();
	}

	@Override
	public void run() {
		connectHID();

		Thread t1 = new Thread(deviceRead);
		Thread t2 = new Thread(deviceSend);

		t1.start();
		t2.start();
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

	public void setMockData() {
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

	public void remove(int pid) {
		for (Iterator<Senzor> senzorIt = senzors.iterator(); senzorIt.hasNext();) {
			Senzor next = senzorIt.next();
			if (next.getId() == pid) {
				senzors.remove(next);
			}
		}
		for (Iterator<Aktuatator> aktuatorIt = aktuators.iterator(); aktuatorIt.hasNext();) {
			Aktuatator next = aktuatorIt.next();
			if (next.getId() == pid) {
				aktuators.remove(next);
			}
		}

	}

	public int getNumberOfDevices() {
		return senzors.size() + aktuators.size();
	}

	public List<Integer> getDevicesIds() {
		List<Integer> ids = new ArrayList<>();
		for (int i = 0; i < senzors.size(); i++) {
			ids.add(senzors.get(i).getId());
		}
		for (int i = 0; i < aktuators.size(); i++) {
			ids.add(aktuators.get(i).getId());
		}
		return ids;
	}

}
