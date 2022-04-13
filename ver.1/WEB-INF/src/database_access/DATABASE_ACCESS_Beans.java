package database_access;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

@SuppressWarnings("serial")
public class DATABASE_ACCESS_Beans implements Serializable {
	public DATABASE_ACCESS_Beans() {super();}
	
	private final String USER = "root";
	private final String PASS = "Yokoi1129";
	private final String Driver = "org.mariadb.jdbc.Driver";
	private String URL = "jdbc:mariadb://localhost/";
	
	private String DATABASE_NAME;
	private StringBuffer SQL;
	
	private boolean Flag;
	private ArrayList<HashMap<String, String>> DATA;
	
	public void setDATAS(String DATABASE_NAME,StringBuffer SQL) {
		this.DATABASE_NAME = DATABASE_NAME;
		this.SQL = SQL;
	}
	
	public ArrayList<HashMap<String, String>> getDATA_Array() {return this.DATA;}
	public boolean getDATA_boolean() {return Flag;}
	
	public void DATA_SELECT() {
		this.URL += this.DATABASE_NAME;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet rs = null;
		StringBuffer ERMSG = null;
		
		Flag = false;
		
		this.DATA = new ArrayList<HashMap<String,String>>();
		
		try {
			
			Class.forName(this.Driver);
			
			connection = DriverManager.getConnection(this.URL, this.USER, this.PASS);
			statement = connection.createStatement();
			
			rs = statement.executeQuery(this.SQL.toString());
			ResultSetMetaData rsmd = rs.getMetaData();

			HashMap<String, String> map = null;
			
			while(rs.next()) {
				map = new HashMap<String, String>();
				for(int i = 1; i <= rsmd.getColumnCount(); i++) {
					map.put(String.valueOf(i), rs.getString(i));
				}
				this.DATA.add(map);
				Flag = true;
			}
			
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

	public void DATA_INSERT() {
		this.URL += this.DATABASE_NAME;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet rs = null;
		StringBuffer ERMSG = null;
		
		Flag = false;
		
		this.DATA = new ArrayList<HashMap<String,String>>();
		
		try {
			
			Class.forName(this.Driver);
			
			connection = DriverManager.getConnection(this.URL, this.USER, this.PASS);
			statement = connection.createStatement();
			
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

	public void DATA_UPDATE() {
		this.URL += this.DATABASE_NAME;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet rs = null;
		StringBuffer ERMSG = null;
		
		Flag = false;
		
		this.DATA = new ArrayList<HashMap<String,String>>();
		
		try {
			
			Class.forName(this.Driver);
			
			connection = DriverManager.getConnection(this.URL, this.USER, this.PASS);
			statement = connection.createStatement();
			
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

	public void DATA_DELETE() {
		this.URL += this.DATABASE_NAME;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet rs = null;
		StringBuffer ERMSG = null;
		
		Flag = false;
		
		this.DATA = new ArrayList<HashMap<String,String>>();
		
		try {
			
			Class.forName(this.Driver);
			
			connection = DriverManager.getConnection(this.URL, this.USER, this.PASS);
			statement = connection.createStatement();
			
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
