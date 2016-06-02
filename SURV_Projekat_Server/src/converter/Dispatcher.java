package converter;

import java.util.Map;

import names.InputName;
import names.OutputName;

public class Dispatcher {

	public static byte[] dispatch(byte[] read, Map<InputName, OutputName> connections) {
		byte[] write = new byte[64];
		write[0] = 0;
		OutputName o = connections.get(InputName.BTN1);
		switch (o) {
		case LED2:
			write[2] = read[1];
			break;
		case BUZZER:
			write[5] = read[1];
			break;
		default:
			write[1] = read[1];
			break;
		}
		o = connections.get(InputName.BTN2);
		switch (o) {
		case LED1:
			write[1] = read[2];
			break;
		case BUZZER:
			write[5] = read[2];
			break;
		default:
			write[2] = read[2];
			break;
		}
		o = connections.get(InputName.ANALOG);
		int anb = (read[4] & 0xff) * 256 + (read[3] & 0xff);
		switch (o) {
		case LED1:
			write[1] = (byte) (anb >= 2000 ? 1 : 0);
			break;
		case LED2:
			write[2] = (byte) (anb >= 2000 ? 1 : 0);
			break;
		default:
			write[3] = read[3];
			write[4] = read[4];
			break;
		}
		return write;
	}

}
