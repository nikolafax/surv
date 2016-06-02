package web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Aktuatator;
import beans.Senzor;
import comunicaton.Comunicator;

public class ServerHandler extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {

	private static final long serialVersionUID = -38738955644587451L;

	private Comunicator comunicator;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		comunicator = new Comunicator();
		Thread t = new Thread(comunicator);
		t.start();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		for (Senzor senzor : comunicator.getSenzors()) {
			String[] parameterValues = request.getParameterValues(senzor.getDeviceName());
			if (parameterValues != null) {
				for (String string : parameterValues) {
					Aktuatator a = new Aktuatator();
					a.setDeviceName(string);
					senzor.addAktuator(a);
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

			pout.print("senzor : " + senzor.getDeviceName() + "<br>");

			for (Aktuatator aktuatator : comunicator.getActuators()) {
				if (aktuatator == null) {
					continue;
				}

				pout.println("<input type=\"checkbox\" name=\"" + senzor.getDeviceName() + "\" value=\""
						+ aktuatator.getDeviceName() + "\"");

				if (senzor.contains(aktuatator)) {
					pout.println("checked");
				}

				pout.println("> " + aktuatator.getDeviceName() + "<br>");
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
