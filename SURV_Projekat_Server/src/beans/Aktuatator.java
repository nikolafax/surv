package beans;

import java.io.Serializable;

public class Aktuatator extends Device implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4780350559942044298L;

	@Override
	public boolean equals(Object obj) {
		if (obj == null) return false;
	    if (obj == this) return true;
	    if (!(obj instanceof Aktuatator))return false;
	    Aktuatator otherMyClass = (Aktuatator)obj;
		return getId().equals(otherMyClass.getId());
	}
	
	

}
