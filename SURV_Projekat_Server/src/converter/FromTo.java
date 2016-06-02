package converter;

public enum FromTo {
	
	SenzorToContorler(00),
	ControlerToSenzor(01),
	ControlerToActuator(10),
	ActuatorToContorler(11);
	
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
