import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import saves.Account_data_SAVE;

@SuppressWarnings("serial")
public class Card_update extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		PrintWriter OUT = res.getWriter();
		saves.Account_data_SAVE User_ID_SAVE = new saves.Account_data_SAVE();
		database_access.DATABASE_ACCESS_Beans DATABASE = new database_access.DATABASE_ACCESS_Beans();
		encryption_and_decryption.Encryption_and_Decryption encrypt = new encryption_and_decryption.Encryption_and_Decryption();
		HttpSession session = req.getSession();
		User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
		
		boolean flag = false;
		
		if(User_ID_SAVE.getDATA_User_ID() == null) {
			res.sendRedirect("../jsp/ALLFREE_index.jsp");
		} else {
			String User_ID = User_ID_SAVE.getDATA_User_ID();
			
			encrypt.setMesseage(req.getParameter("card_name_old"));
			encrypt.encrypt();
			String card_name_old = encrypt.getEncrypt_str();
			
			encrypt.setMesseage(req.getParameter("card_name"));
			encrypt.encrypt();
			String card_name = encrypt.getEncrypt_str();
	
			encrypt.setMesseage(req.getParameter("card_number"));
			encrypt.encrypt();
			String card_number = encrypt.getEncrypt_str();
	
			encrypt.setMesseage(req.getParameter("card_limit_y"));
			encrypt.encrypt();
			String card_limit_y = encrypt.getEncrypt_str();
	
			encrypt.setMesseage(req.getParameter("card_limit_m"));
			encrypt.encrypt();
			String card_limit_m = encrypt.getEncrypt_str();
	
			encrypt.setMesseage(req.getParameter("card_owner"));
			encrypt.encrypt();
			String card_owner = encrypt.getEncrypt_str();
			
			
			int year = 2000 + Integer.parseInt(req.getParameter("card_limit_y"));
			int month = Integer.parseInt(req.getParameter("card_limit_m"));
			int result = MAX_DAY(year, month);
			
			String result_str = "'" + year + "-" + month + "-" + result + " 23:59:59'";
			
			try {
				String DATABASE_NAME = "allfree";
				StringBuffer SQL = new StringBuffer();
				SQL.append("UPDATE card_datas SET card_name = '" + card_name + "', ");
				SQL.append("card_number = '" + card_number + "', ");
				SQL.append("card_limit_y = '" + card_limit_y + "', ");
				SQL.append("card_limit_m = '" + card_limit_m + "', ");
				SQL.append("card_owner = '" + card_owner + "', ");
				SQL.append("card_limit = " + result_str + " ");
				SQL.append("WHERE ");
				SQL.append("User_ID = '" + User_ID + "' AND ");
				SQL.append("card_name = '" + card_name_old + "';");
				
				//System.out.println(SQL.toString());
				
				DATABASE.setDATAS(DATABASE_NAME, SQL);
				DATABASE.DATA_UPDATE();
				
				flag = true;
				
			} catch(Exception ex) {
				ex.printStackTrace();
			}
			
			OUT.print(flag);
		}
	}
	
	public int MAX_DAY(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH , month - 1);
		
		return calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
}
