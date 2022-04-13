package database_access;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@SuppressWarnings("serial")
public class DATABASE_UPDATE_Beans implements Serializable {
	public DATABASE_UPDATE_Beans() {super();}

	private final String USER = "root";
	private final String PASS = "Yokoi1129";
	private final String Driver = "org.mariadb.jdbc.Driver";
	private String URL = "jdbc:mariadb://localhost/";
	
	private int Judg = 0;
	private String DATABASE_NAME;
	private String[] SQL_DATA1;
	private String[] SQL_DATA2;
	private StringBuffer SQL = new StringBuffer();
	
	private String DATA;
	
	public void setDATAS(int Judg, String DATABASE_NAME, String[] SQL_DATA1, String[] SQL_DATA2) {
		this.Judg = Judg;
		this.DATABASE_NAME = DATABASE_NAME;
		this.SQL_DATA1 = SQL_DATA1;
		this.SQL_DATA2 = SQL_DATA2;
		
		//this.DATA_INSERT();
	}
	public String getDATA() {return this.DATA;}
	
	public void DATA_UPDATE() {
		String URL = this.URL + this.DATABASE_NAME;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet rs = null;
		StringBuffer ERMSG = null;
		
		try {
			Class.forName(this.Driver);
			
			connection = DriverManager.getConnection(URL, this.USER, this.PASS);
			statement = connection.createStatement();
			
			SQL.append("UPDATE " + this.SQL_DATA1[0] + " SET ");
			for(int i = 2; i < this.SQL_DATA1.length; i++) {
				if(i == (this.SQL_DATA1.length-1))
					SQL.append(this.SQL_DATA1[i] + " = " + this.SQL_DATA2[i] + " WHERE ");
				else
					SQL.append(this.SQL_DATA1[i] + " = " + this.SQL_DATA2[i] + ", ");
			}
			
			if(Judg == 1) {
				SQL.append(this.SQL_DATA1[1] + " = '" + this.SQL_DATA2[1] + "';");
			} else {
				for(int i = 1; i <= this.Judg; i++) {
					if(i == this.Judg)	SQL.append(this.SQL_DATA1[i] + " = " + this.SQL_DATA2[i] + ";");
					else				SQL.append(this.SQL_DATA1[i] + " = " + this.SQL_DATA2[i] + " AND ");
				}
			}
			
			this.DATA = SQL.toString();
			
			//System.out.println(this.SQL.toString());
			rs = statement.executeQuery(this.SQL.toString());
		
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
