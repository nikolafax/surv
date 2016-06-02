package beans;

import java.util.ArrayList;
import java.util.List;

public class Senzor extends Device {

	private List<Aktuatator> aktuatators;

	public Senzor() {
		setAktuatators(new ArrayList<>());
	}

	public void addAktuator(Aktuatator aktuatator) {
		if (!contains(aktuatator)) {
			getAktuatators().add(aktuatator);
		}
	}

	public List<Aktuatator> getAktuatators() {
		return aktuatators;
	}

	public void setAktuatators(List<Aktuatator> aktuatators) {
		this.aktuatators = aktuatators;
	}

	public boolean contains(Aktuatator aktuatator) {
		boolean contains = false;
		for (Aktuatator akt : aktuatators) {
			if (akt.getDeviceName().equals(aktuatator.getDeviceName())) {
				contains = true;
			}
		}
		return contains;
	}

}
