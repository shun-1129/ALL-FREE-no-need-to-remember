import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import saves.Account_data_SAVE;

@SuppressWarnings("serial")
public class New_site_Reg extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		
		encryption_and_decryption.Encryption_and_Decryption encrypt = new encryption_and_decryption.Encryption_and_Decryption();
		database_access.DATABASE_SELECT_Beans SELECT = new database_access.DATABASE_SELECT_Beans();
		database_access.DATABASE_INSERT_Beans INSERT = new database_access.DATABASE_INSERT_Beans();
		
		PrintWriter OUT = res.getWriter();
		boolean flag = false;
		
		String site_name = req.getParameter("site_name");
		String site_url = req.getParameter("site_url");
		String User_ID = req.getParameter("User_ID");
		String User_PW = req.getParameter("User_PW");
		
		encrypt.setMesseage(site_name);
		encrypt.encrypt();
		site_name = encrypt.getEncrypt_str();
		encrypt.setMesseage(site_url);
		encrypt.encrypt();
		site_url = encrypt.getEncrypt_str();
		encrypt.setMesseage(User_ID);
		encrypt.encrypt();
		User_ID = encrypt.getEncrypt_str();
		encrypt.setMesseage(User_PW);
		encrypt.encrypt();
		User_PW = encrypt.getEncrypt_str();
		
		HttpSession session = req.getSession();
		saves.Account_data_SAVE User_ID_SAVE = new saves.Account_data_SAVE();
		
		User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
		
		//System.out.println(User_ID);
		
		try {
			String Judg = "String";
			String DATABASE_NAME = "allfree";
			String[] SQL_DATA = {"site_datas"};
			String[] WHERE_DATA = {"User_ID = '" + User_ID_SAVE.getDATA_User_ID() + "'", "site_name = '" + site_name + "'"};
			String[] GET_DATA = {"User_ID", "site_name"};
			
			SELECT.setDATAS(Judg, DATABASE_NAME, SQL_DATA, WHERE_DATA, GET_DATA, "");
			SELECT.DATA_SELECT();
			String[] result = SELECT.getDATAString();
			
			flag = (!(result[0].equals("NO_DATA")));
			
			if(flag == false) {
				String[] INSERT_DATA1 = {"site_datas", "User_ID", "site_name", "site_url", "site_User_ID", "site_User_PW", "FAVO", "UPDATE_TIME"};
				String[] INSERT_DATA2 = {
						"'" + User_ID_SAVE.getDATA_User_ID() + "'",
						"'" + site_name + "'",
						"'" + site_url + "'",
						"'" + User_ID + "'",
						"'" + User_PW + "'",
						"0",
						"NOW()"};
				
				INSERT.setDATAS(DATABASE_NAME, INSERT_DATA1, INSERT_DATA2);
				INSERT.DATA_INSERT();
			}
			
			OUT.print(flag);
			
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}
