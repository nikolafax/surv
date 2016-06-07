package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Aktuatator;
import beans.Senzor;
import comunicaton.Comunicator;

public class ServerHandler extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {

	private static final long serialVersionUID = -38738955644587451L;
	private static final String SENZORID = "SENZORID";
	private static final String AKTUATOR = "AKTUATORID";
	private Comunicator comunicator;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		comunicator = new Comunicator();		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		for (Senzor senzor : comunicator.getSenzors()) {
			String[] senzorParam = request.getParameterValues(SENZORID);
			if (senzorParam != null) {
				String senzorId = senzorParam[0];
				if (senzorId != null && senzorId.equals(senzor.getId().toString())) {

					String[] aktuatorParam = request.getParameterValues(AKTUATOR);

					List<Aktuatator> aktuatators = new ArrayList<>();
					if (aktuatorParam != null) {
						for (String string : aktuatorParam) {
							Aktuatator a = new Aktuatator();
							Integer aktuatorId = new Integer(string);
							a.setId(aktuatorId);
							aktuatators.add(a);
						}
					}

					senzor.setAktuatators(aktuatators);
				}
			}

		}

		PrintWriter pout = response.getWriter();
		pout.println("<html>");
		pout.println("<head>");
		pout.println("</head>");
		pout.println("<body>");

		pout.println("<h3>Sensor list:<h3><br><br>");

		for (Senzor senzor : comunicator.getSenzors()) {
			if (senzor == null) {
				continue;
			}

			pout.print("<form action=\"ServerHandler\" method=\"post\">");

			pout.print("senzor : " + senzor.getId() + "<br>");

			pout.print("<input type=\"hidden\" name=\"" + SENZORID + "\" value=\"" + senzor.getId() + "\" />");

			for (Aktuatator aktuatator : comunicator.getActuators()) {
				if (aktuatator == null) {
					continue;
				}

				pout.println("<input type=\"checkbox\" name=\"" + AKTUATOR + "\" value=\"" + aktuatator.getId() + "\"");

				if (senzor.contains(aktuatator)) {
					pout.println("checked");
				}

				pout.println("> " + aktuatator.getId() + "<br>");
			}

			pout.println("<input type=\"submit\" name=\"submit\" value=\"dodaj\"> <br>");

			pout.println("</form>");
		}

		pout.println("</body>");
		pout.println("</html>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
