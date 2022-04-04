import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import saves.Account_data_SAVE;

@SuppressWarnings("serial")
public class setting_Change extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		PrintWriter OUT = res.getWriter();
		HttpSession session = req.getSession();
		saves.Account_data_SAVE SAVE = new saves.Account_data_SAVE();
		SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
		database_access.DATABASE_ACCESS_Beans DATABASE = new database_access.DATABASE_ACCESS_Beans();
		encryption_and_decryption.Encryption_and_Decryption encrypt = new encryption_and_decryption.Encryption_and_Decryption();
		
		if(SAVE.getDATA_User_ID() == null) {
			res.sendRedirect("../jsp/ALLFREE_index.jsp");
		} else {
			
			String User_ID = SAVE.getDATA_User_ID();
			String DATABASE_NAME = "allfree";
			StringBuffer SQL = new StringBuffer();
			
			String mail_Old = req.getParameter("mail_Old");
			
			encrypt.setMesseage(req.getParameter("mail_new"));
			encrypt.encrypt();
			String mail_new = encrypt.getEncrypt_str();
			
			String pass_Old = req.getParameter("pass_Old");
			
			encrypt.setMesseage(req.getParameter("pass_new"));
			encrypt.encrypt();
			String pass_new = encrypt.getEncrypt_str();
			
			String secretQ_Old = req.getParameter("secretQ_Old");
			
			encrypt.setMesseage(req.getParameter("secretQ_new"));
			encrypt.encrypt();
			String secretQ_new = encrypt.getEncrypt_str();
			
			String secretA_Old = req.getParameter("secretA_Old");
			
			encrypt.setMesseage(req.getParameter("secretA_new"));
			encrypt.encrypt();
			String secretA_new = encrypt.getEncrypt_str();
			
			
			if(!(mail_Old.equals("NO_DATA"))) {
				SQL.append("UPDATE user_account_secret SET mail = '" + mail_new + "' WHERE User_ID = '" + User_ID + "';");
			}
			if(!(pass_Old.equals("0"))) {
				SQL.append("UPDATE user_account SET User_PW = '" + pass_new + "' WHERE User_ID = '" + User_ID + "';");
			}
			if(!(secretQ_Old.equals("NO_DATA")) && !(secretA_Old.equals("NO_DATA"))) {
				SQL.append("UPDATE user_account_secret SET secret_Q = '" + secretQ_new + "', secret_A = '" + secretA_new + "' WHERE User_ID = '" + User_ID + "';");
			}
			System.out.println(SQL.toString());
			
			DATABASE.setDATAS(DATABASE_NAME, SQL);
			DATABASE.DATA_UPDATE();
			
			OUT.print(true);
		}
	}
}
