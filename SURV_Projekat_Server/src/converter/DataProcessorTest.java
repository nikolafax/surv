package converter;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Ignore;
import org.junit.Test;

public class DataProcessorTest {
	DataProcessor processor = new DataProcessor(null, null);

	@Test
	public void testFromWhoToWho() {

		byte[] imputData = new byte[64];
		short data = 0b00000000;
		imputData[0] = (byte) data;
		FromTo fromWhoToWho = processor.fromWhoToWho(imputData);
		assertEquals(FromTo.SenzorToContorler, fromWhoToWho);

		data = 0b01000000;
		imputData[0] = (byte) data;
		processor.fromWhoToWho(imputData);
		fromWhoToWho = processor.fromWhoToWho(imputData);
		assertEquals(FromTo.ControlerToSenzor, fromWhoToWho);

		data = 0b10000000;
		imputData[0] = (byte) data;
		processor.fromWhoToWho(imputData);
		fromWhoToWho = processor.fromWhoToWho(imputData);
		assertEquals(FromTo.ControlerToActuator, fromWhoToWho);

		data = 0b11000000;
		imputData[0] = (byte) data;
		processor.fromWhoToWho(imputData);
		fromWhoToWho = processor.fromWhoToWho(imputData);
		assertEquals(FromTo.ActuatorToContorler, fromWhoToWho);

		fromWhoToWho = processor.fromWhoToWho(imputData);
		assertNotEquals(FromTo.SenzorToContorler, processor.fromWhoToWho(imputData));

	}
	@Ignore
	@Test
	public void testAddressIsSet() {
		short addresByre = 0;
		byte[] imputData = new byte[64];

		imputData[2] = (byte) addresByre;
		boolean isAddressSet = processor.isAddressSet(imputData);
		assertEquals(false, isAddressSet);

		addresByre = 1;
		imputData[2] = (byte) addresByre;
		isAddressSet = processor.isAddressSet(imputData);
		assertEquals(true, isAddressSet);

		addresByre = 0b1000_0000;
		;
		imputData[2] = (byte) addresByre;
		isAddressSet = processor.isAddressSet(imputData);
		assertEquals(true, isAddressSet);
	}

	@Test
	public void testSetForActuatorSignature() {
		// byte[] outputData = new byte[64];
		//
		// outputData = processor.setForActuatorSignature(outputData);
		//
		// byte signatureBits = (byte) (outputData[0] & -64);
		// assertEquals(FromTo.ControlerToActuator.id, signatureBits);
	}

	@Test
	public void testIsRepitedMessage() {
		
		byte[] imput = new byte[64];
		byte[] lastMessage = new byte[64];
		
		imput[0] = 0;
		imput[1] = 12;
		imput[2] = 16;
		
		lastMessage[0] = 0;
		lastMessage[1] = 12;
		lastMessage[2] = 16;
		
		DataProcessor dataProcessor = new DataProcessor(null, null);
		dataProcessor.lastMessageMap.put(new Integer(lastMessage[2]), lastMessage);
		
		assertTrue(dataProcessor.isRepitedMessage(imput));

	}

}
