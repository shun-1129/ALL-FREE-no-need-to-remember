import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import saves.Account_data_SAVE;

@SuppressWarnings("serial")
public class LOGIN extends HttpServlet{
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");

		PrintWriter OUT = res.getWriter();

		database_access.DATABASE_SELECT_Beans SELECT = new database_access.DATABASE_SELECT_Beans();
		database_access.DATABASE_UPDATE_Beans UPDATE = new database_access.DATABASE_UPDATE_Beans();
		encryption_and_decryption.Encryption_and_Decryption decryption = new encryption_and_decryption.Encryption_and_Decryption();
		
		String User_ID = req.getParameter("User_ID");
		String User_PW = req.getParameter("User_PW");

		Account_data_SAVE User_ID_SAVE = new Account_data_SAVE();
		User_ID_SAVE.setDATA_User_ID(User_ID);
		HttpSession session = req.getSession();
		
		int flag = 0;
		
		try {
			String DATABASE_NAME = "allfree";
			String[] SQL_DATA = {"user_account", "User_ID", "User_PW"};
			String[] WHERE_DATA = {"User_ID = '" + User_ID + "'"};
			String[] GET_DATA = {"User_ID", "User_PW"};
			
			SELECT.setDATAS("String", DATABASE_NAME, SQL_DATA, WHERE_DATA, GET_DATA, "");
			SELECT.DATA_SELECT();
			String[] result = SELECT.getDATAString();	
			
			decryption.setCryptText(result[1]);
			decryption.decrypt();
			
			result[1] = decryption.getDecrypt_str();
			
			if(result[1].equals(User_PW)) {
				flag = 1;
				
				database_access.DATABASE_SELECT_Beans SELECT2 = new database_access.DATABASE_SELECT_Beans();
				beans.Now_DATETIME now_date = new beans.Now_DATETIME();
				
				now_date.now_date();
				
				String[] SQL_DATA2 = {"user_dates"};
				//String[] GET_DATA2 = {"LOGIN_DATE1", "LOGIN_DATE2", "LOGIN_DATE3", "LOGIN_DATE4", "LOGIN_DATE5"};
				String[] GET_DATA2 = {"DATE_FORMAT(LOGIN_DATE1,'%Y/%m/%d %H:%i:%s')", "DATE_FORMAT(LOGIN_DATE2,'%Y/%m/%d %H:%i:%s')", "DATE_FORMAT(LOGIN_DATE3,'%Y/%m/%d %H:%i:%s')", "DATE_FORMAT(LOGIN_DATE4,'%Y/%m/%d %H:%i:%s')", "DATE_FORMAT(LOGIN_DATE5,'%Y/%m/%d %H:%i:%s')"};
				
				SELECT2.setDATAS("Steing", DATABASE_NAME, SQL_DATA2, WHERE_DATA, GET_DATA2, "");
				SELECT2.DATA_SELECT();
				String[] result_DATA = SELECT2.getDATAString();
				
				for(int i = 4; i > 0; i--) {
					result_DATA[i] = result_DATA[i-1];
				}
				result_DATA[0] = now_date.getDATE();
				
				boolean[] Warning_List = new boolean[3];
				Warning_List[0] = Site_old_search(User_ID);
				Warning_List[1] = Site_Duplicate_search(User_ID);
				
				//System.out.println(Warning_List[1]);
				
				User_ID_SAVE.setDATA_Login_Date(result_DATA);
				User_ID_SAVE.setDATA_Warning_List(Warning_List);
				
				int count = 0;
				for(int i = 0; i < result_DATA.length; i++) {
					if(result_DATA[i] != null) count++;
				}
				
				
				String[] SQL_DATA1 = new String[(count + 2)];
				for(int i = 0; i < (count + 2); i++) {
					if(i == 0)		SQL_DATA1[i] = "user_dates";
					else if(i == 1)	SQL_DATA1[i] = "User_ID";
					else			SQL_DATA1[i] = ("LOGIN_DATE") + (i-1);
				}
				
				String[] SQL_DATA3 = new String[SQL_DATA1.length];
				
				for(int i = 0; i < SQL_DATA1.length; i++) {
					if(i == 0) SQL_DATA3[i] = SQL_DATA1[i];
					else if(i == 1) SQL_DATA3[i] = User_ID;
					else {
						SQL_DATA3[i] = "STR_TO_DATE('" + result_DATA[i-2] + "', '%Y/%m/%d %H:%i:%s')";
					}
				}
				
				UPDATE.setDATAS(1, DATABASE_NAME, SQL_DATA1, SQL_DATA3);
				UPDATE.DATA_UPDATE();
				
				session.setAttribute("User_ID_SAVE", User_ID_SAVE);
				
			} else {
				flag = 0;
				session.removeAttribute("User_ID_SAVE");
			}
			
			OUT.print(flag);
		} catch(Exception ex) {
			ex.printStackTrace(OUT);
		}
	}
	
	public void Login_date() {
		
	}
	
	public boolean Site_old_search(String User_ID) {
		database_access.DATABASE_SELECT_Beans SELECT = new database_access.DATABASE_SELECT_Beans();
		
		String Judg = "String";
		String DATABASE_NAME = "allfree";
		String[] SQL_DATA = {"site_datas"};
		String[] WHERE_DATA = {"User_ID = '" + User_ID + "'", "DATEDIFF(NOW(), UPDATE_TIME) >= 90"};
		String[] GET_DATA = {"site_name"};
		
		SELECT.setDATAS(Judg, DATABASE_NAME, SQL_DATA, WHERE_DATA, GET_DATA, "");
		SELECT.DATA_SELECT();
		String[] result = SELECT.getDATAString();
		
		return !(result[0].equals("NO_DATA"));
	}
	
	public boolean Site_Duplicate_search(String User_ID) {
		database_access.DATABASE_SELECT_Beans SELECT = new database_access.DATABASE_SELECT_Beans();
		boolean flag = false;
		
		String Judg = "Array";
		String DATABASE_NAME = "allfree";
		String[] SQL_DATA = {"site_datas"};
		String[] WHERE_DATA = {"User_ID = '" + User_ID + "'"};
		String[] GET_DATA = {"COUNT(site_User_ID)"};
		String Order = "GROUP BY site_User_PW";

		ArrayList<HashMap<String, String>> DATAS_Array = new ArrayList<HashMap<String, String>>();
		
		SELECT.setDATAS(Judg, DATABASE_NAME, SQL_DATA, WHERE_DATA, GET_DATA, Order);
		SELECT.DATA_SELECT();
		DATAS_Array = SELECT.getDATAArray();
		
		for(int i = 0; i < DATAS_Array.size(); i++) {
			int judg = Integer.parseInt(DATAS_Array.get(i).get(GET_DATA[0]));
			if(judg > 1) {
				flag = true;
			}
		}
		
		return flag;
	}
}
