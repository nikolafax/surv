package converter;

public enum FromTo {

	SenzorToContorler(0), // 00
	ControlerToSenzor(64), // 01
	ControlerToActuator(128), // 10
	ActuatorToContorler(192); // 11

	int id;

	private FromTo(int id) {
		this.id = id;
	}

	private int getId() {
		return id;
	}

	public static FromTo getById(int id) {
		for (FromTo fromTo : values()) {
			if (fromTo.getId() == id) {
				return fromTo;
			}
		}
		return null;
	}

}
