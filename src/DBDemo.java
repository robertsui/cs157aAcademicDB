import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
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
	
	@SuppressWarnings("deprecation")
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
		
		//search(conn, "course", "courseName", "Introduction"); //*WORKS*

		
		//enroll(conn, 100004, 10004); //*WORKS*
		
		
		String pattern = "yyyy-MM-dd";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		Date cutOffDate = null;
		try {
			cutOffDate = simpleDateFormat.parse("2000-10-17");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//remove archived professors with cutoff date 10/17/2000
		//archiveProfessor(conn, cutOffDate); //ARCHIVING PART WORKS, NEED TO WORK ON RESTORING
		
		
		//searches for courses that contain either key1 or key2
		union(conn, "course", "courseName", "courseName", "Biology", "Chemistry"); //*WORKS*
		
	}
	
	
	
	public void archiveProfessor(Connection con, Date cutOffDate) {
		Statement stmt = null;
		Statement archive = null;
		//Statement delete = null;
		String query = "select * from professor";
		try {
			stmt = con.createStatement();
			
			archive = con.createStatement();
			
			//delete = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Date cutOff = rs.getDate("updatedAt");
				//System.out.println("this is cutoff: " + cutOff.toString());
				//System.out.println("this is lastUpdatedDate:  " + cutOffDate);
				if (cutOff.compareTo(cutOffDate) < 0) {
					String firstName = "\'" + rs.getString("firstName") + "\'";
					String lastName = "\'" + rs.getString("lastName") + "\'";
					int dept = rs.getInt("dept");
					String title = "\'" + rs.getString("title") + "\'";
					int yearHired = rs.getInt("yearHired");
					int professorID = rs.getInt("professorID");
					
					String add = "insert into archive values (" + professorID + "," + firstName + "," + lastName + "," + dept + "," + title + ","
								  + yearHired + ")";
					//System.out.println(add);
					//return;
					archive.executeUpdate(add);
					System.out.println("archived professor with ID : " + professorID);
					
					//next two lines undoes our insertion into archive so we can keep testing on archive table
					//comment the next two lines before submitting
					//String del = "delete from archive where " + professorID + "=" + professorID;
					//stmt.executeUpdate(del);
					
					//String delProfessor = "delete from professor where professorID = " + professorID;
					//delete.executeUpdate(delProfessor);
					
				}
				
			}
		} catch (SQLException e) {
			System.out.println("ERROR: Could not get table");
			e.printStackTrace();
		}
		
	}
	
	
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
				System.out.println("courseId: " + courseID + ", deptId: " + deptID + ", courseNo: "
						   + courseNo + ", courseName:" + courseName);
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
			
			rs = stmt.executeQuery(getSection);
			if (!rs.next()) {
				System.out.println("no course with that ID exists");
				return;
			}
			if (rs.getInt("capacity") <= rs.getInt("enrolled")) {
				System.out.println("course is full");
				return;
			}
			
			String add = "insert into enrolledIn values (" + sectionID + "," + studentID + ")";
			stmt.executeUpdate(add);
			System.out.println("Student : " + studentID + " successfully enrolled in course : " + sectionID);
			
			
		} catch (SQLException e) {
			System.out.println("Student does not exist");
			e.printStackTrace();
		}
				
	}
	public void union(Connection con, String table, String firstColumn, String secondColumn, String firstKey, String secondKey) {
		Statement s1 = null;
		final String UNION = "union";
		String q1 = "select * from " + table + " WHERE " + firstColumn + " LIKE " + "\'%"+ firstKey + "%\'";
		String q2 = "select * from " + table + " WHERE " + secondColumn + " LIKE " + "\'%"+ secondKey + "%\'";
		
		try {
			s1 = con.createStatement();
			//System.out.println(q1 + UNION + q2);
			ResultSet rs = s1.executeQuery(q1 + " " + UNION + " "+ q2);
			
			while (rs.next()) {
				int courseID = rs.getInt("courseID");
				int deptID = rs.getInt("deptID");
				String courseNo = rs.getString("courseNo");
				String courseName = rs.getString("courseName");
				System.out.println("courseId: " + courseID + ", deptId: " + deptID + ", courseNo: "
								   + courseNo + ", courseName:" + courseName);
			}
		} catch (SQLException e) {
			System.out.println("Failed to retrieve data");
			e.printStackTrace();
		}
	}
	/*
	public static void viewCoursesByProf(Connection conn, int profID) {
        try {
            String viewCoursesByProf =
                    "SELECT c.courseName, t.professorID, c.courseNo, s.sectionID, p.firstName, p.lastName," +
                            " d.abbreviation \r\n" +
                            "FROM Section s\r\n" +
                            "JOIN Professor p\r\n" +
                            "JOIN Department d\r\n" +
                            "JOIN Teaches t ON s.sectionID=t.sectionID\r\n" +
                            "JOIN Course c ON s.courseID=c.courseID\r\n" +
                            "WHERE t.professorID= ? AND p.professorID=? AND d.deptID=p.dept;";
            PreparedStatement pstmt = conn.prepareStatement(viewCoursesByProf);
            pstmt.setInt(1, profID);
            pstmt.setInt(2, profID);
            ResultSet rs = pstmt.executeQuery();

            // TODO: make result format pretty
            System.out.println("Retrieving all course offerings by Professor " + profID + "...");

            System.out.println("-----------------------------------------" +
                    "---------------------------------------------");
            System.out.format("%-8s %-14s %-14s %-14s %-14s %-14s",
                    "ID No.", "Last Name", "First Name", "Section ID", "Course", "Course Title");
            System.out.println();
            System.out.println("-----------------------------------------" +
                    "---------------------------------------------");
            while(rs.next()) {
                String profIDNo = rs.getString("professorID");
                String profFN = rs.getString("firstName");
                String profLN = rs.getString("lastName");
                String secIDNo = rs.getString("sectionID");
                String courseNo = rs.getString("courseNo");
                String courseName = rs.getString("courseName");
                String deptAbb = rs.getString("abbreviation");

                System.out.format("%-8s %-14s %-14s %-14s %-1s %-9s %-1s",
                        profIDNo, profLN, profFN, secIDNo, deptAbb, courseNo, courseName);
                System.out.println();
            }
            System.out.println("-----------------------------------------" +
                    "---------------------------------------------");
            System.out.println("Done.\n");
            rs.close();
        } catch(SQLException e) {
            System.out.println("ERROR: Could not view courses");
            e.printStackTrace();
        }
    }
    */
	
	
	/*
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
	*/

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