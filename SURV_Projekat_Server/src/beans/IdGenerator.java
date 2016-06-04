package beans;

import java.util.HashMap;
import java.util.Map;

public class IdGenerator {
	private static short id = 0;

	// public static final String SENZOR = "SENZOR";
	// public static final String AKTUATOR = "AKTUATOR";
	//
	// private static final Map<Short, String> map = new HashMap<>();

	private IdGenerator() {
	}

	public static short getId() {
		return id++;
	}

	// public synchronized static short getSenzorId() {
	// map.put(id, SENZOR);
	// return id++;
	// }
	//
	// public synchronized static short getAktuatorId() {
	// map.put(id, AKTUATOR);
	// return id++;
	// }
}
