import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;

/**
 * This class demonstrates how to connect to MySQL and run some basic commands.
 * 
 * In order to use this, you have to download the Connector/J driver and add
 * its .jar file to your build path.  You can find it here:
 * 
 * http://dev.mysql.com/downloads/connector/j/
 * 
 * You will see the following exception if it's not in your class path:
 * 
 * java.sql.SQLException: No suitable driver found for jdbc:mysql://localhost:3306/
 * 
 * To add it to your class path:
 * 1. Right click on your project
 * 2. Go to Build Path -> Add External Archives...
 * 3. Select the file mysql-connector-java-5.1.24-bin.jar
 *    NOTE: If you have a different version of the .jar file, the name may be
 *    a little different.
 *    
 * The user name and password are both "root", which should be correct if you followed
 * the advice in the MySQL tutorial. If you want to use different credentials, you can
 * change them below. 
 * 
 * You will get the following exception if the credentials are wrong:
 * 
 * java.sql.SQLException: Access denied for user 'userName'@'localhost' (using password: YES)
 * 
 * You will instead get the following exception if MySQL isn't installed, isn't
 * running, or if your serverName or portNumber are wrong:
 * 
 * java.net.ConnectException: Connection refused
 */
public class DBDemo {

	/** The name of the MySQL account to use (or empty for anonymous) */
	private final String userName = "root";

	/** The password for the MySQL account (or empty for anonymous) */
	private final String password = "sjsusql2!";

	/** The name of the computer running MySQL */
	private final String serverName = "localhost";

	/** The port of the MySQL server (default is 3306) */
	private final int portNumber = 3306;

	/** The name of the database we are testing with (this default is installed with MySQL) */
	private final String dbName = "academic_records";
	
	/** The name of the table we are testing with */
	private final String tableName = "JDBC_TEST";
	
	/**
	 * Get a new database connection
	 * 
	 * @return
	 * @throws SQLException
	 */
	public Connection getConnection() throws SQLException {
		Connection conn = null;
		Properties connectionProps = new Properties();
		connectionProps.put("user", this.userName);
		connectionProps.put("password", this.password);

		conn = DriverManager.getConnection("jdbc:mysql://"
				+ this.serverName + ":" + this.portNumber + "/" + this.dbName,
				connectionProps);

		return conn;
	}

	/**
	 * Run a SQL command which does not return a recordset:
	 * CREATE/INSERT/UPDATE/DELETE/DROP/etc.
	 * 
	 * @throws SQLException If something goes wrong
	 */
	public boolean executeUpdate(Connection conn, String command) throws SQLException {
	    Statement stmt = null;
	    try {
	        stmt = conn.createStatement();
	        stmt.executeUpdate(command); // This will throw a SQLException if it fails
	        return true;
	    } finally {

	    	// This will run whether we throw an exception or not
	        if (stmt != null) { stmt.close(); }
	    }
	}
	
	/**
	 * Connect to MySQL and do some stuff.
	 */
	
	public void run() {

		// Connect to MySQL
		Connection conn = null;
		try {
			conn = this.getConnection();
			System.out.println("Connected to database");
		} catch (SQLException e) {
			System.out.println("ERROR: Could not connect to the database");
			e.printStackTrace();
			return;
		}

		// Create a table
		/*
		try {
		    String createString =
			        "CREATE TABLE " + this.tableName + " ( " +
			        "ID INTEGER NOT NULL, " +
			        "NAME varchar(40) NOT NULL, " +
			        "STREET varchar(40) NOT NULL, " +
			        "CITY varchar(20) NOT NULL, " +
			        "STATE char(2) NOT NULL, " +
			        "ZIP char(5), " +
			        "PRIMARY KEY (ID))";
			this.executeUpdate(conn, createString);
			System.out.println("Created a table");
	    } catch (SQLException e) {
			System.out.println("ERROR: Could not create the table");
			e.printStackTrace();
			return;
		}
		
		// Drop the table
		try {
		    String dropString = "DROP TABLE " + this.tableName;
			this.executeUpdate(conn, dropString);
			System.out.println("Dropped the table");
	    } catch (SQLException e) {
			System.out.println("ERROR: Could not drop the table");
			e.printStackTrace();
			return;
		}
		*/
		
		
		//search for all Introduction courses
		//search(conn, "course", "courseName", "Introduction");
		
		//archiveProfessor(conn, "2000-10-17"); TO WORK ON LATER
		
		enroll(conn, 100004, 10004);
			
		
	}
	
	
	/*
	public void archiveProfessor(Connection con, String cutOffDate) {
		Statement stmt = null;
		String query = "select * from professor";
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Date cutOff = rs.getDate("updatedAt");
				
				if (cutOff.compareTo(cutOffDate) < 0) {
					String add = "insert into archive values (" + "'"+rs.getString(1)+"'" + "," + "'"+rs.getString(2)+"'" + "," + rs.getInt(3)
					+ "," + "'"+rs.getString(4)+"'" + "," + rs.getInt(5) + "," + rs.getInt(6) + ")";
					stmt.executeUpdate(add);
				}
				
				System.out.println(cutOff.getTime());
				//System.out.println("this is cutoff date " + cutOffDate\));
				return;
			}
		} catch (SQLException e) {
			System.out.println("ERROR: Could not get table");
			e.printStackTrace();
		}
		
	}
	*/
	
	//searches database for any course title containing keyWord
	public void search(Connection con, String table, String column, String keyWord) {
		
		Statement stmt = null;
		String query = "select * from " + table + " WHERE " + column + " LIKE " + "\'%"+ keyWord + "%\'"; 
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int courseID = rs.getInt("courseID");
				int deptID = rs.getInt("deptID");
				String courseNo = rs.getString("courseNo");
				String courseName = rs.getString("courseName");
				System.out.println("courseId : " + courseID + " deptId " + deptID + " courseNo : "
								   + courseNo + " courseName " + courseName);
			}
			
			rs.close();
		} catch (SQLException e) {
			System.out.println("Could not return courses");
			e.printStackTrace();
		}
	}
	
	public void enroll(Connection con, int studentID, int sectionID) {
		//first check to see if studentID is valid
		Statement stmt = null;
		String getStudents = "select * from student where studentID = " + studentID;
		String getSection = "select * from section where sectionID = " + sectionID;
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(getStudents);
			if (!rs.next()) {
				System.out.println("no student with that ID exists");
				return;
			}
			/*
			if (!exists(studentID, rs, "studentID")) {
				System.out.println("enrollment failed, student does not exist");
				return;
			}
			*/
			rs = stmt.executeQuery(getSection);
			if (!rs.next()) {
				System.out.println("no course with that ID exists");
				return;
			}
			if (rs.getInt("capacity") <= rs.getInt("enrolled")) {
				System.out.println("course is full");
				return;
			}
			/*
			if (!courseHasSpace(sectionID, rs, "sectionID")) {
				System.out.println("course full");
				return;
			}
			*/
			
			String add = "insert into enrolledIn values (" + studentID + "," + sectionID + ")";
			stmt.executeUpdate(add);
			System.out.println("Student : " + studentID + " successfully enrolled in course : " + sectionID);
			
			
		} catch (SQLException e) {
			System.out.println("Student does not exist");
			e.printStackTrace();
		}
				
	}
	
	private boolean courseHasSpace(int courseID, ResultSet rs, String string) {
		try {
			while (rs.next()) {
				if (rs.getInt("courseID") == courseID) {
					if (rs.getInt("capacity") > rs.getInt("enrolled")) {
						//System.out.println(courseID);
						//System.out.println("capacity : " + rs.getInt("capacity" ) + " enrolled :" + rs.getInt("enrolled"));
						return true;
					} else {
						System.out.println("Course does not exist or course is full");
						return false;
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean exists(int studentID, ResultSet rs, String column) {
		try {
			while (rs.next()) {
				if (rs.getInt(column) == studentID) {
					return true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	//public boolean isFull
	
	
	
	
	/**
	 * Connect to the DB and do some stuff
	 */
	public static void main(String[] args) {
		DBDemo app = new DBDemo();
		app.run();
	}
}