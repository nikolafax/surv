package converter;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import beans.Aktuatator;
import beans.IdGenerator;
import beans.Senzor;
import comunicaton.Comunicator;
import life.FailureDetector;

public class DataProcessor {

	private Comunicator comunicator;
	FailureDetector failureDetector;
	ConcurrentMap<Integer, byte[]> lastMessageMap;

	public DataProcessor(Comunicator comunicator, FailureDetector failureDetector) {
		this.comunicator = comunicator;
		this.failureDetector = failureDetector;
		lastMessageMap = new ConcurrentHashMap<>();
	}

	public List<byte[]> getDatOutputData(byte[] imputData) {

		FromTo fromTo = fromWhoToWho(imputData);
		final boolean addressSet = isAddressSet(imputData);
		if (addressSet) {
			if (isRepitedMessage(imputData)) {
				return new ArrayList<>();
			}
		}
		switch (fromTo) {
		case ActuatorToContorler:
			if (!addressSet) {
				return getIdMessageForActuator();
			}
			break;
		case SenzorToContorler:
			if (addressSet) {
				return createMessagesForActuatorFromSenzor(imputData);
			} else {
				return createIdMessageForSenzor();
			}

		default:
			break;
		}

		return null;
	}

	public boolean isRepitedMessage(byte[] imputData) {
		final byte[] bs = lastMessageMap.get(new Integer(imputData[2]));
		if (bs != null && bs[0] == imputData[0] && bs[1] == imputData[1]) {
			return true;
		}
		return false;
	}

	public List<byte[]> createIdMessageForSenzor() {
		List<byte[]> messages = new ArrayList<>();
		byte[] outputData = new byte[64];
		int senzId = IdGenerator.getId();
		Senzor senzor = new Senzor();
		senzor.setId(senzId);
		outputData = setDeviceAddress(outputData, senzId);
		failureDetector.messageRecived(senzId);
		comunicator.getSenzors().add(senzor);

		outputData[1] = setSignature(outputData[1], FromTo.ControlerToSenzor);
		messages.add(outputData);
		return messages;
	}

	public List<byte[]> createMessagesForActuatorFromSenzor(byte[] imputData) {
		List<byte[]> messageList = new ArrayList<>();
		int senzorID = imputData[2];
		final Vector<Senzor> senzors = comunicator.getSenzors();
		Senzor senzor = null;
		for (Senzor tmp : senzors) {
			if (tmp.getId().equals(senzorID)) {
				senzor = tmp;
				break;
			}
		}

		if (senzor == null || senzor.getAktuatators() == null || senzor.getAktuatators().isEmpty()) {
			return messageList;
		}

		for (Aktuatator aktuatator : senzor.getAktuatators()) {
			byte[] outputData = new byte[64];
			outputData[1] = imputData[0];
			outputData[1] = setSignature(outputData[1], FromTo.ControlerToActuator);
			outputData[2] = imputData[1];
			outputData = setDeviceAddress(outputData, aktuatator.getId());
			System.out.println(
					"senzor " + senzorID + " to actuator " + outputData[1] + " " + outputData[2] + " " + outputData[3]);
			messageList.add(outputData);

		}

		return messageList;
	}

	public List<byte[]> getIdMessageForActuator() {
		byte[] outputData = new byte[64];
		List<byte[]> messages = new ArrayList<>();

		int aktId = IdGenerator.getId();
		Aktuatator aktuatator = new Aktuatator();
		aktuatator.setId(aktId);
		comunicator.getActuators().add(aktuatator);
		failureDetector.messageRecived(aktId);
		outputData = setDeviceAddress(outputData, aktId);

		// outputData[3] = (byte) 0xff;
		// outputData = setSignature(outputData, FromTo.ControlerToActuator);
		outputData[1] = 0x70; // set message id for reciver id message
		messages.add(outputData);
		return messages;
	}

	public byte setSignature(byte outputData, FromTo fromTo) {
		short byteWithSignature = outputData;
		int signature = fromTo.id;
		byteWithSignature = (short) (byteWithSignature & 0x3f); // resetuj from
																// fleg
		byteWithSignature = (short) (byteWithSignature | signature); // setuj
																		// from
																		// fleg
		outputData = (byte) byteWithSignature;
		return outputData;
	}

	private byte[] setDeviceAddress(byte[] outputData, int id) {
		outputData[3] = (byte) id;
		return outputData;
	}

	public boolean isAddressSet(byte[] imputData) {
		short address = imputData[2];
		if (address != 0) {
			failureDetector.messageRecived(address);
			return true;
		}
		return false;
	}

	public FromTo fromWhoToWho(byte[] imputData) {

		short byteOne = (short) (imputData[0] & 0xC0);
		FromTo fromTo = FromTo.getById(byteOne);

		return fromTo;
	}

}
