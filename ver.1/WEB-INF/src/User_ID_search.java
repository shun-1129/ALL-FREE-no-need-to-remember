import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class User_ID_search extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		
		PrintWriter OUT = res.getWriter();
		
		database_access.DATABASE_SELECT_Beans SELECT = new database_access.DATABASE_SELECT_Beans();
		
		String User_ID = req.getParameter("User_ID");
		int flag = 0;
		
		String DATABASE_NAME = "allfree";
		String[] SQL_DATA = {"user_account", "User_ID"};
		String[] WHERE_DATA = {"User_ID = '" + User_ID + "'"};
		String[] GET_DATA = {"User_ID"};
		
		SELECT.setDATAS("String", DATABASE_NAME, SQL_DATA, WHERE_DATA, GET_DATA, "");
		SELECT.DATA_SELECT();
		String[] result = SELECT.getDATAString();
		
		if(result[0].equals(User_ID)) {
			flag = 1;
			OUT.print(flag);
		} else if(result[0] == null) {
			flag = 0;
			OUT.print(flag);
		}
		
		//System.out.println(flag);
	}
}
