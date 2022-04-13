import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class LOGOUT extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		
		PrintWriter OUT = res.getWriter();
		boolean flag = false;
		
		String logout = req.getParameter("logout");
		System.out.println(logout);

		HttpSession session = req.getSession();
		session.removeAttribute("User_ID_SAVE");
		
		flag = true;
		
		res.sendRedirect("../jsp/ALLFREE_index.jsp");
		
		OUT.print(flag);
	}
}
