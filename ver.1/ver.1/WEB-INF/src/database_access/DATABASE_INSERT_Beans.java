package database_access;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@SuppressWarnings("serial")
public class DATABASE_INSERT_Beans implements Serializable {
	public DATABASE_INSERT_Beans() {super();}

	private final String USER = "root";
	private final String PASS = "Yokoi1129";
	private final String Driver = "org.mariadb.jdbc.Driver";
	private String URL = "jdbc:mariadb://localhost/";
	
	private String DATABASE_NAME;
	private String[] SQL_DATA1;
	private String[] SQL_DATA2;
	private StringBuffer SQL;
	
	private String DATA;
	
	public void setDATAS(String DATABASE_NAME, String[] INSERT_DATA1, String[] INSERT_DATA2) {
		this.DATABASE_NAME = DATABASE_NAME;
		this.SQL_DATA1 = INSERT_DATA1;
		this.SQL_DATA2 = INSERT_DATA2;
		
		//this.DATA_INSERT();
	}
	public String getDATA() {return this.DATA;}
	
	public void DATA_INSERT() {
		String URL = this.URL + this.DATABASE_NAME;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet rs = null;
		StringBuffer ERMSG = null;
		
		SQL = new StringBuffer();
		
		try {
			Class.forName(this.Driver);
			
			connection = DriverManager.getConnection(URL, this.USER, this.PASS);
			statement = connection.createStatement();
			
			SQL.append("INSERT INTO " + this.SQL_DATA1[0] + "(");
			for(int i = 1; i < this.SQL_DATA1.length; i++) {
				if(i == (this.SQL_DATA1.length-1))
					SQL.append(this.SQL_DATA1[i] + ") VALUES (");
				else
					SQL.append(this.SQL_DATA1[i] + ",");
			}
			for(int i = 0; i < this.SQL_DATA2.length; i++) {
				if(i == (this.SQL_DATA2.length-1))
					SQL.append(this.SQL_DATA2[i] + ");");
				else
					SQL.append(this.SQL_DATA2[i] + ",");
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
