import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class SINGUP extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		
		PrintWriter OUT = res.getWriter();
		
		database_access.DATABASE_SELECT_Beans SELECT = new database_access.DATABASE_SELECT_Beans();
		database_access.DATABASE_INSERT_Beans INSERT = new database_access.DATABASE_INSERT_Beans();
		encryption_and_decryption.Encryption_and_Decryption encrypt = new encryption_and_decryption.Encryption_and_Decryption();
		saves.Account_data_SAVE User_ID_SAVE = new saves.Account_data_SAVE();
		
		HttpSession session = req.getSession();
		
		String User_ID = req.getParameter("User_ID");
		String User_PW = req.getParameter("User_PW");
		String NAME1 = req.getParameter("NAME1");
		String NAME2 = req.getParameter("NAME2");
		String NAME3 = req.getParameter("NAME3");
		String NAME4 = req.getParameter("NAME4");
		String mail = req.getParameter("mail");	
		int B_y = Integer.parseInt(req.getParameter("B_y"));
		int B_m = Integer.parseInt(req.getParameter("B_m"));
		int B_d = Integer.parseInt(req.getParameter("B_d"));
		String SEX = req.getParameter("SEX");
		String secret_Q = req.getParameter("secret_Q");
		String secret_A = req.getParameter("secret_A");
		
		//蜷�證怜捷蛹�
		encrypt.setMesseage(User_PW);
		encrypt.encrypt();
		User_PW = encrypt.getEncrypt_str();
		encrypt.setMesseage(mail);
		encrypt.encrypt();
		mail = encrypt.getEncrypt_str();
		encrypt.setMesseage(secret_Q);
		encrypt.encrypt();
		secret_Q = encrypt.getEncrypt_str();
		encrypt.setMesseage(secret_A);
		encrypt.encrypt();
		secret_A = encrypt.getEncrypt_str();
		
		try {
			//ID驥崎､�繝√ぉ繝�繧ｯ
			int flag = 0;
			
			String DATABASE_NAME = "allfree";
			String[] SQL_DATA = {"user_account", "User_ID"};
			String[] WHERE_DATA = {"User_ID = '" + User_ID + "'"};
			String[] GET_DATA = {"User_ID"};
			
			SELECT.setDATAS("String", DATABASE_NAME, SQL_DATA, WHERE_DATA, GET_DATA, "");
			SELECT.DATA_SELECT();
			String[] result = SELECT.getDATAString();
			
			//蟷ｴ鮨｢險育ｮ�
			Calendar calendar = Calendar.getInstance();
			int now_y = calendar.get(Calendar.YEAR);
			int now_m = calendar.get(Calendar.MONTH) + 1;
			int now_d = calendar.get(Calendar.DATE);
			
			int Age = now_y - B_y;
			if(now_m < B_m)	Age--;
			else if(now_m == B_m && now_d < B_d)	Age--;
			
			String Birth = B_y + "/" + B_m + "/" + B_m;
			
			String[] Table_Name = {"user_account", "user_account_data", "user_account_secret", "user_dates"};
			String[] INSERT_main1 = {Table_Name[0], "User_ID", "User_PW"};
			String[] INSERT_main2 = {"'"+User_ID+"'", "'"+User_PW+"'"};
			String[] INSERT_sub1_1 = {Table_Name[1], "User_ID", "Last_name", "Fast_name", "Last_name_K", "Fast_name_K", "Brith", "SEX", "Age"};
			String[] INSERT_sub1_2 = {"'"+User_ID+"'", "'"+NAME1+"'", "'"+NAME2+"'", "'"+NAME3+"'", "'"+NAME4+"'", "'"+Birth+"'", SEX, "'"+String.valueOf(Age)+"'"};
			String[] INSERT_sub2_1 = {Table_Name[2], "User_ID", "mail", "secret_Q", "secret_A"};
			String[] INSERT_sub2_2 = {"'"+User_ID+"'", "'"+mail+"'", "'"+secret_Q+"'", "'"+secret_A+"'"};
			String[] INSERT_sub3_1 = {Table_Name[3], "User_ID", "LOGIN_DATE1"};
			String[] INSERT_sub3_2 = {"'"+User_ID+"'", "now()"};
			
			if(result[0].equals(User_ID)) {
				flag = 1;
				OUT.print(flag);
			} else if(result[0] == null) {
				flag = 0;
				OUT.print(flag);
			} else if(result[0].equals("NO_DATA")) {
				INSERT.setDATAS(DATABASE_NAME, INSERT_main1, INSERT_main2);
				INSERT.DATA_INSERT();
				
				INSERT.setDATAS(DATABASE_NAME, INSERT_sub1_1, INSERT_sub1_2);
				INSERT.DATA_INSERT();
				
				INSERT.setDATAS(DATABASE_NAME, INSERT_sub2_1, INSERT_sub2_2);
				INSERT.DATA_INSERT();
				
				INSERT.setDATAS(DATABASE_NAME, INSERT_sub3_1, INSERT_sub3_2);
				INSERT.DATA_INSERT();
				
				User_ID_SAVE.setDATA_User_ID(User_ID);
				
				/*
				req.setAttribute("saves", saves);
				
				ServletContext sc = getServletContext();
				sc.getRequestDispatcher("/jsp/ALLFREE_toppage.jsp").forward(req, res);
				*/
				
				beans.Now_DATETIME now_date = new beans.Now_DATETIME();
				
				now_date.now_date();
				String[] Login_Date = new String[5];
				Login_Date[0] = now_date.getDATE();;
				
				User_ID_SAVE.setDATA_Login_Date(Login_Date);

				boolean[] Warning_List = new boolean[3];
				Warning_List[0] = false;
				Warning_List[1] = false;
				Warning_List[2] = false;
				
				User_ID_SAVE.setDATA_Warning_List(Warning_List);
				
				session.setAttribute("User_ID_SAVE", User_ID_SAVE);
				
				OUT.print(0);
			}
		} catch(Exception ex) {
			ex.printStackTrace(OUT);
		}
	}
}
