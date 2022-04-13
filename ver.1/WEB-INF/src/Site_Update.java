import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import saves.Account_data_SAVE;

@SuppressWarnings("serial")
public class Site_Update extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		
		PrintWriter OUT = res.getWriter();
		
		encryption_and_decryption.Encryption_and_Decryption encrypt = new encryption_and_decryption.Encryption_and_Decryption();
		
		saves.Account_data_SAVE User_ID_SAVE = new saves.Account_data_SAVE();
		HttpSession session = req.getSession();
		User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
		
		String User_ID = User_ID_SAVE.getDATA_User_ID();
		
		encrypt.setMesseage(req.getParameter("site_name"));
		encrypt.encrypt();
		String site_name = encrypt.getEncrypt_str();
		
		encrypt.setMesseage(req.getParameter("site_name_old"));
		encrypt.encrypt();
		String site_name_old = encrypt.getEncrypt_str();
		
		encrypt.setMesseage(req.getParameter("site_url"));
		encrypt.encrypt();
		String site_url = encrypt.getEncrypt_str();// = ;
		
		encrypt.setMesseage(req.getParameter("site_User_ID"));
		encrypt.encrypt();
		String site_User_ID = encrypt.getEncrypt_str();
		
		encrypt.setMesseage(req.getParameter("site_User_PW"));
		encrypt.encrypt();
		String site_User_PW = encrypt.getEncrypt_str();
		
		try {
			String DATABASE_NAME = "allfree";
			StringBuffer SQL = new StringBuffer();
			SQL.append("UPDATE site_datas SET site_name = '" + site_name + "', ");
			SQL.append("site_url = '" + site_url + "', ");
			SQL.append("site_User_ID = '" + site_User_ID + "', ");
			SQL.append("site_User_PW = '" + site_User_PW + "', ");
			SQL.append("UPDATE_TIME = NOW() ");
			SQL.append("WHERE User_ID = '" + User_ID + "' AND site_name = '" + site_name_old + "';");
			
			//System.out.println(SQL.toString());
			
			database_access.DATABASE_ACCESS_Beans DATABASE = new database_access.DATABASE_ACCESS_Beans();
			DATABASE.setDATAS(DATABASE_NAME, SQL);
			DATABASE.DATA_UPDATE();
			
			boolean flag = true;
			
			OUT.print(flag);
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}
