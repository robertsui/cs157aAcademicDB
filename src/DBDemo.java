import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

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
	private final String password = "password";

	/** The name of the computer running MySQL */
	private final String serverName = "localhost";

	/** The port of the MySQL server (default is 3306) */
	private final int portNumber = 3306;

	/** The name of the database we are testing with (this default is installed with MySQL) */
	private final String dbName = "University";
	
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
			viewCourses(conn);
			System.out.println("-------------------------------------------------------");
			checkGrades(conn, 100017);
		} catch (SQLException e) {
//			System.out.println("ERROR: Could not connect to the database");
			e.printStackTrace();
//			return;
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	private static void viewCourses(Connection conn) {
		try {
			String viewCourses = 
					"SELECT d.name AS department, d.abbreviation, c.courseNo, c.courseName " + 
					"FROM Course c, Department d " + 
					"WHERE c.deptID=d.deptID " + 
					"ORDER BY d.name, c.courseNo ASC";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(viewCourses);
			
			// TODO: make result format pretty
			System.out.println("Department \t\t Course Number \t\t Course Name");
			while(rs.next()) {
				String dept = rs.getString("department");
				String abb = rs.getString("abbreviation");
				String courseNo = rs.getString("courseNo");
				String courseName = rs.getString("courseName");
				
				System.out.println(dept + "\t\t" + abb + " " + courseNo + "\t\t" + courseName);
			}

			rs.close();
		} catch(SQLException e) {
			System.out.println("ERROR: Could not view courses");
			e.printStackTrace();
		}
	}
	
	private static void checkGrades(Connection conn, int studentID) {
		try {
			String sql = "SELECT abbreviation, courseNo, courseName, grade\r\n" + 
					"FROM Grade\r\n" + 
					"JOIN Section ON Grade.sectionID=Section.sectionID\r\n" + 
					"JOIN Course ON Section.courseID=Course.courseID\r\n" + 
					"JOIN Department ON Course.deptID=Department.deptID\r\n" + 
					"WHERE studentID= ?;";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, studentID);
			ResultSet rs = pstmt.executeQuery();
			
			System.out.println("Course Number \t\t Course Name \t\t Grade");
			
			while(rs.next()) {
				String abb = rs.getString("abbreviation");
				String courseNo = rs.getString("courseNo");
				String courseName = rs.getString("courseName");
				String grade = rs.getString("grade");
				
				System.out.println(abb + " " + courseNo + "\t\t" + courseName + "\t\t" + grade);
			}
			
			rs.close();
		} catch(SQLException e) {
			System.out.println("ERROR: Could not check grades");
			e.printStackTrace();
		}
	}
	
	/**
	 * Connect to the DB and do some stuff
	 */
	public static void main(String[] args) {
		DBDemo app = new DBDemo();
		app.run();
	}

}
