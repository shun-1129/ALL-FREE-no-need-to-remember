package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;

@SuppressWarnings("serial")
public class Verification implements Serializable {
	public Verification() {super();}

	private final String DATABASE_NAME = "allfree";
	private String User_ID;
	
	public void setDATA(String User_ID) {this.User_ID = User_ID;}
	
	public boolean Site_old_search() {
		database_access.DATABASE_ACCESS_Beans SELECT = new database_access.DATABASE_ACCESS_Beans();
		
		StringBuffer SQL = new StringBuffer();
		SQL.append("SELECT site_name FROM site_datas WHERE ");
		SQL.append("User_ID = '" + this.User_ID + "' AND ");
		SQL.append("DATEDIFF(NOW(), UPDATE_TIME) >= 90;");
		
		SELECT.setDATAS(DATABASE_NAME, SQL);
		SELECT.DATA_SELECT();
		
		return SELECT.getDATA_boolean();
	}
	
	@SuppressWarnings("unused")
	public boolean Site_Duplicate_search() {
		database_access.DATABASE_ACCESS_Beans SELECT = new database_access.DATABASE_ACCESS_Beans();
		
		StringBuffer SQL = new StringBuffer();
		SQL.append("SELECT COUNT(site_User_ID) FROM site_datas WHERE ");
		SQL.append("User_ID = '" + this.User_ID + "' ");
		SQL.append("GROUP BY site_User_PW;");
		
		SELECT.setDATAS(DATABASE_NAME, SQL);
		SELECT.DATA_SELECT();
		ArrayList<HashMap<String, String>> LIST = SELECT.getDATA_Array();
		for(int i = 0; i < LIST.size(); i++) {
			if(Integer.parseInt(LIST.get(i).get("1")) > 1) {
				return true;
			} else {
				return false;
			}
		}
		
		return false;
	}

	public boolean Card_update() {
		database_access.DATABASE_ACCESS_Beans SELECT = new database_access.DATABASE_ACCESS_Beans();
		
		StringBuffer SQL = new StringBuffer();
		SQL.append("SELECT COUNT(User_ID) AS 'COUNT' FROM card_datas WHERE ");
		SQL.append("User_ID = '" + this.User_ID + "' AND ");
		SQL.append("DATEDIFF(NOW(), card_limit) >= 1;");
		
		SELECT.setDATAS(DATABASE_NAME, SQL);
		SELECT.DATA_SELECT();
		
		return SELECT.getDATA_boolean();
	}
}
