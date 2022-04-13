package saves;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Account_data_SAVE implements Serializable {
	private String User_ID;
	private String[] Login_Date;
	private boolean[] Warning_List;
	
	public Account_data_SAVE() {super();}
	
	public void setDATA_User_ID(String ID) {this.User_ID = ID;}
	public void setDATA_Login_Date(String[] Login_Date) {this.Login_Date = Login_Date;}
	public void setDATA_Warning_List(boolean[] Warning_List) {this.Warning_List = Warning_List;}
	
	public String getDATA_User_ID() {return this.User_ID;}
	public String[] getDATA_Login_Date() {return this.Login_Date;}
	public boolean[] getDATA_Warning_List() {return this.Warning_List;}
}
