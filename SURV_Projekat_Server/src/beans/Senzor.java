package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Senzor extends Device implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8874727067191224935L;
	
	private List<Aktuatator> aktuatators;

	public Senzor() {
		setAktuatators(new ArrayList<>());
	}

	public void addAktuator(Aktuatator aktuatator) {
		if (!contains(aktuatator)) {
			getAktuatators().add(aktuatator);
		}
	}
	
	public void removeAktuator(Aktuatator aktuatator) {
		if (!contains(aktuatator)) {
			getAktuatators().remove(aktuatator);
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
			if (akt.getId().equals(aktuatator.getId())) {
				contains = true;
			}
		}
		return contains;
	}

}
