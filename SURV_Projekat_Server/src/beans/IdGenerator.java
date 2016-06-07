package beans;

public class IdGenerator {

	private static short id = 2;
	static{
		
	}

	private IdGenerator() {
	}

	public static short getMaxId() {
		return id;
	}

	public static short getId() {
		return id++;
	}

}
