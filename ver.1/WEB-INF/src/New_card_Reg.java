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
public class New_card_Reg extends HttpServlet {
	private final String DATABASE_NAME = "allfree";
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		PrintWriter OUT = res.getWriter();
		HttpSession session = req.getSession();
		saves.Account_data_SAVE User_ID_SAVE = new saves.Account_data_SAVE();
		database_access.DATABASE_ACCESS_Beans DATA_SELECT = new database_access.DATABASE_ACCESS_Beans();
		database_access.DATABASE_ACCESS_Beans DATA_INSERT = new database_access.DATABASE_ACCESS_Beans();
		encryption_and_decryption.Encryption_and_Decryption encrypt = new encryption_and_decryption.Encryption_and_Decryption();
		User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
		
		if(User_ID_SAVE.getDATA_User_ID() == null) {
			res.sendRedirect("../jsp/ALLFREE_index.jsp");
		} else {
			
			boolean Flag = true;
			
			String User_ID = User_ID_SAVE.getDATA_User_ID();
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
				
				StringBuffer SQL = new StringBuffer();
				SQL.append("SELECT card_name FROM card_datas WHERE User_ID = '" + User_ID + "' AND card_name = '" + card_name +"';");
				
				DATA_SELECT.setDATAS(this.DATABASE_NAME, SQL);
				DATA_SELECT.DATA_SELECT();
				Flag = DATA_SELECT.getDATA_boolean();
				
			} catch(Exception ex) {
				ex.printStackTrace();
			}
			
			if(Flag == true) {
				OUT.print(Flag);
			} else {
				
				try {
					
					StringBuffer SQL = new StringBuffer();
					SQL.append("INSERT INTO card_datas (");
					SQL.append("User_ID, card_name, card_number, card_limit_y, card_limit_m, card_owner, card_limit) VALUES ('");
					SQL.append(User_ID + "', '" + card_name + "', '" + card_number + "', '" + card_limit_y + "', '" + card_limit_m + "', '" + card_owner + "'," + result_str + ");");
					
					System.out.println(SQL.toString());
					
					DATA_INSERT.setDATAS(this.DATABASE_NAME, SQL);
					DATA_INSERT.DATA_INSERT();
					
					OUT.print(Flag);
					
				} catch(Exception ex) {
					ex.printStackTrace();
				}
				
			}
			
		}
	}
	
	public int MAX_DAY(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH , month - 1);
		
		return calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
}
