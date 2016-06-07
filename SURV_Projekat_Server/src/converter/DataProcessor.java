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

		outputData = setSignature(outputData, FromTo.ControlerToSenzor);
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

		if (senzor == null || senzor.getAktuatators() == null || !senzor.getAktuatators().isEmpty()) {
			return messageList;
		}

		for (Aktuatator aktuatator : senzor.getAktuatators()) {
			byte[] outputData = new byte[64];
			outputData = setSignature(outputData, FromTo.ControlerToActuator);

			outputData = setDeviceAddress(outputData, aktuatator.getId());

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

		outputData = setDeviceAddress(outputData, aktId);
		outputData[3] = (byte) 0xff;
		// outputData = setSignature(outputData, FromTo.ControlerToActuator);
		outputData[1] = 112; // set message id for reciver id message
		messages.add(outputData);
		return messages;
	}

	public byte[] setSignature(byte[] outputData, FromTo fromTo) {
		short byteWithSignature = outputData[0];
		int signature = fromTo.id;
		byteWithSignature = (short) (byteWithSignature & 0x3f); // resetuj from
																// fleg
		byteWithSignature = (short) (byteWithSignature ^ signature); // setuj
																		// from
																		// fleg
		outputData[1] = (byte) byteWithSignature;
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
