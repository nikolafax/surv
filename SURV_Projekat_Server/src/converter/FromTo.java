package converter;

public enum FromTo {
	
	SenzorToContorler(0),
	ControlerToSenzor(64),
	ControlerToActuator(-128),
	ActuatorToContorler(-64);
	
	int id;
	
	private FromTo(int id) {
		this.id = id;
	}
	
	private int getId(){
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
