package database_access;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

@SuppressWarnings("serial")
public class DATABASE_SELECT_Beans implements Serializable {
	
	private final String USER = "root";
	private final String PASS = "Yokoi1129";
	private final String Driver = "org.mariadb.jdbc.Driver";
	private String URL = "jdbc:mariadb://localhost/";
	
	public DATABASE_SELECT_Beans() {super();}
	
	private String DATABASE_NAME;
	private String[] SQL_DATA;
	private String[] WHERE_DATA;
	private String WHERE;
	private String COLMUN = "";
	private String Judg;
	/*
	 * Judg = Array		: ArrayList<Hashmap<String, String>>
	 * Judg = String	: String[]
	 */
	private String[] GET_DATA;
	private String Order;
	
	private String[] DATAS_Str;
	private ArrayList<HashMap<String, String>> DATAS_Array;
	
	public void setDATAS(String Judg, String DATABASE_NAME, String[] SQL_DATA,String[] WHERE_DATA , String[] GET_DATA, String Order) {
		this.DATABASE_NAME = DATABASE_NAME;
		this.SQL_DATA = SQL_DATA;
		this.WHERE_DATA = WHERE_DATA;
		this.Judg = Judg;
		this.GET_DATA = GET_DATA;
		this.Order = Order;
	}
	
	public ArrayList<HashMap<String, String>> getDATAArray() {return this.DATAS_Array;}
	public String[] getDATAString() {return this.DATAS_Str;}
	
	public void DATA_SELECT() {
		String URL = this.URL + this.DATABASE_NAME;
		
		this.DATAS_Str = new String[this.GET_DATA.length];
		
		Connection connection = null;
		Statement statement = null;
		ResultSet rs = null;
		StringBuffer ERMSG = null;
		
		try {
			Class.forName(this.Driver);
			
			connection = DriverManager.getConnection(URL, this.USER, this.PASS);
			statement = connection.createStatement();
			
			for(int i = 0; i < this.GET_DATA.length; i++) {
				if(i+1 == this.GET_DATA.length) {
					this.COLMUN += this.GET_DATA[i];
				} else {
					this.COLMUN += (this.GET_DATA[i] + ",");
				}
			}
			
			if(this.WHERE_DATA[0] != null) {
				this.WHERE = " WHERE ";
				for(int i = 0; i < WHERE_DATA.length; i++) {
					if(i == this.WHERE_DATA.length-1)
						this.WHERE += (this.WHERE_DATA[i]);
					else
						this.WHERE += (this.WHERE_DATA[i] + " AND ");
				}
			} else {
				this.WHERE = ";";
			}
			
			String Str = "SELECT " + this.COLMUN + " FROM " + this.SQL_DATA[0] + this.WHERE;
			
			if(this.Order != "") {
				Str += (" " + this.Order + ";");
			} else {
				Str += ";";
			}
			
			//System.out.println(Str);
			
			rs = statement.executeQuery(Str);
			
			if(this.Judg.equals("Array")) {
				this.DATAS_Array = new ArrayList<HashMap<String,String>>();
				while(rs.next()) {
					HashMap<String, String> map = new HashMap<String, String>();
					for(int i = 0; i < this.GET_DATA.length; i++) {
						map.put(this.GET_DATA[i], rs.getString(this.GET_DATA[i]));
					}
					
					this.DATAS_Array.add(map);
				}
			}
			
			if(rs.next()) {
				for(int i = 0; i < this.GET_DATA.length; i++) {
					this.DATAS_Str[i] = rs.getString(this.GET_DATA[i]);
				}
			}
			
			if(DATAS_Str[0] == null)	DATAS_Str[0] = "NO_DATA";
			
		} catch(ClassNotFoundException e) {
			ERMSG = new StringBuffer();
			ERMSG.append(e.getMessage());
		} catch(SQLException e) {
			ERMSG = new StringBuffer();
			ERMSG.append(e.getMessage());
		} catch(Exception e) {
			ERMSG = new StringBuffer();
			ERMSG.append(e.getMessage());
		} finally {
			try {
				if(rs != null) rs.close();
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			} catch(SQLException e) {
				ERMSG = new StringBuffer();
				ERMSG.append(e.getMessage());
			}
		}
	}
}
