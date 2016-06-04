package converter;

import static org.junit.Assert.*;

import org.junit.Test;

public class FromToTest {

	@Test
	public void test() {
		int id = 00;
		final FromTo byId = FromTo.getById(id);
		
		assertEquals(FromTo.SenzorToContorler, byId);
		
	}

}
