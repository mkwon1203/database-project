/*
 * Group members:
 * Min Kwon
 * Ryan Melzer
 * Jarryd Goodman
 * Chris Stepanski
 * 
 * CSC 460
 * Program #4: Database-driven Web Application
 * Instructor: Dr. McCann
 * TA: Shuo Yang
 * Due date: 12/08/2015
 * 
 * This program provides connection to the oracle DBMS and contains
 * various methods for inserting into and removing from all the relations associated
 * with the assignment as well as updating one select relation. The methods are meant
 * to be used by a JSP program to allow for back-end functionality of interacting
 * with the oracle DBMS.
 * 
 * As far as I know, there's no bugs and all the features were implemented.
 */

package dbController;

import java.io.PrintWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.*;

/**
 * Servlet implementation class for Servlet: DatabaseController
 *
 */
public class DatabaseController
{
	static final long serialVersionUID = 1L;
	/**
	 * A handle to the connection to the DBMS.
	 */
	protected Connection connection_;
	/**
	 * A handle to the statement.
	 */
	protected Statement statement_;
	/**
	 * The connect string to specify the location of DBMS
	 */
	protected String connect_string_ = null;
	/**
	 * The password that is used to connect to the DBMS.
	 */
	protected String password = null;
	/**
	 * The username that is used to connect to the DBMS.
	 */
	protected String username = null;

	public DatabaseController()
	{
		// your cs login name
		username = "rdmelzer";
		// your Oracle password, NNNN is the last four digits of your CSID
		password = "a1767";
		connect_string_ = "jdbc:oracle:thin:@aloe.cs.arizona.edu:1521:oracle";
	}

	/**
	 * Closes the DBMS connection that was opened by the open call.
	 */
	public void Close()
	{
		try
		{
			statement_.close();
			connection_.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		connection_ = null;
	}

	/**
	 * Commits all update operations made to the dbms. If auto-commit is on,
	 * which is by default, it is not necessary to call this method.
	 */
	public void Commit()
	{
		try
		{
			if (connection_ != null && !connection_.isClosed())
				connection_.commit();
		}
		catch (SQLException e)
		{
			System.err.println("Commit failed");
			e.printStackTrace();
		}
	}

	/**
	 * Opens the DBMS connection using the username and password fields
	 */
	public void Open()
	{
		boolean opened = false;
		while (!opened)
		{
			try
			{
				Class.forName("oracle.jdbc.OracleDriver");
				connection_ = DriverManager.getConnection(connect_string_,
						username, password);
				statement_ = connection_.createStatement();
				opened = true;
				return;
			}
			catch (SQLException sqlex)
			{
				sqlex.printStackTrace();
				opened = false;
			}
			catch (ClassNotFoundException e)
			{
				e.printStackTrace();
				System.exit(1); // programemer/dbsm error
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
				System.exit(2);
			}
		}
	}

	
	/**
	 * Function: DisplayTable(tableName) 
	 * Description: This function will query for the contents of table with the
	 * given tablename. Then, it will parse through the result of the query and build 
	 * an ArrayList object containing String arrays, where each array corresponds to
	 * an individual tuple in the result table. The ArrayList object is then returned.
	 * 
	 * @input: tableName (String) - the name of table whose contents need to be returned
	 *
	 * @return: Return ArrayList containing contents of table where each element is a
	 * String array containing fields of a given tuple
	 **/
	public ArrayList<String[]> DisplayTable(String tableName)
			throws SQLException
	{
		String sql_query; // the select * query to execute
		int templen; // number of columns for given table
		ResultSet rs = null; // storing the result of sql query
		ArrayList<String[]> result = null;

		// sets the query and templen according to tablename
		switch (tableName)
		{
			case "employee":
				sql_query = "SELECT * FROM " + username + ".employee";
				templen = 9;
				break;
			case "client":
				sql_query = "SELECT * FROM " + username + ".client";
				templen = 6;
				break;
			case "office":
				sql_query = "SELECT * FROM " + username + ".office";
				templen = 4;
				break;
			case "car":
				sql_query = "SELECT * FROM " + username + ".car";
				templen = 3;
				break;
			case "lesson":
				sql_query = "SELECT * FROM " + username + ".lesson";
				templen = 4;
				break;
			case "test":
				sql_query = "SELECT * FROM " + username + ".test";
				templen = 5;
				break;
			case "interview":
				sql_query = "SELECT * FROM " + username + ".interview";
				templen = 3;
				break;
			default:
				sql_query = "THIS SHOULDN'T HAVE HAPPENED";
				templen = -1;
				break;
		}

		// execute the query and instantiate the ArrayList to return
		try
		{
			rs = statement_.executeQuery(sql_query);
			result = new ArrayList<String[]>();
		}
		catch (SQLException ex)
		{
			ex.printStackTrace();
			return result; // returns null if query was unsuccessful
		}

		// gathers the names of each column and adds it as first element of result
		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for (int i = 0; i < templen; i++)
		{
			header[i] = rsmd.getColumnName(i + 1);
		}
		result.add(header);

		// grabs all the tuple fields and puts them into result
		while (rs.next())
		{
			String[] temp = new String[templen]; // represents individual tuple in relation
			
			switch (tableName)
			{
				case "employee":
					temp[0] = rs.getInt("employeeID") + "";
					temp[1] = rs.getString("name");
					temp[2] = rs.getDate("DOB").toString();
					temp[3] = rs.getString("sex");
					temp[4] = rs.getString("jobTitle");
					temp[5] = rs.getInt("officeID") + "";
					temp[6] = rs.getString("phone") + "";
					temp[7] = rs.getString("address");
					temp[8] = rs.getInt("carID") + "";
					break;
				case "client":
					temp[0] = rs.getInt("clientID") + "";
					temp[1] = rs.getString("name");
					temp[2] = rs.getString("sex");
					temp[3] = rs.getDate("DOB").toString();
					temp[4] = rs.getString("address");
					temp[5] = rs.getInt("instID") + "";
					break;
				case "office":
					temp[0] = rs.getInt("officeID") + "";
					temp[1] = rs.getInt("mgrID") + "";
					temp[2] = rs.getString("city");
					temp[3] = rs.getString("address");
					break;
				case "car":
					temp[0] = rs.getInt("regNum") + "";
					temp[1] = rs.getString("model");
					temp[2] = rs.getString("faulted");
					break;
				case "lesson":
					temp[0] = rs.getInt("employeeID") + "";
					temp[1] = rs.getInt("clientID") + "";
					temp[2] = rs.getTimestamp("dateAndTime").toString();
					temp[3] = rs.getInt("miles") + "";
					break;
				case "test":
					temp[0] = rs.getInt("employeeID") + "";
					temp[1] = rs.getInt("clientID") + "";
					temp[2] = rs.getTimestamp("dateAndTime").toString();
					temp[3] = rs.getString("passed");
					temp[4] = rs.getString("reason_for_failure");
					break;
				case "interview":
					temp[0] = rs.getInt("employeeID") + "";
					temp[1] = rs.getInt("clientID") + "";
					temp[2] = rs.getTimestamp("dateAndTime").toString();
					break;
				default:
					// shouldn't ever happen here
					break;
			} // end of switch

			result.add(temp);
		} // end of rs.next()

		return result;
	}

	/**
	 * Function: Insert(tableName, attrValues) Description: Function will insert
	 * a row from the given table. Function assumes valid name input for
	 * tableName and attrValues, and that the table exists. Function also
	 * assumes that attribute values are supplied in an order corresponding to
	 * the order of the attributes in the actual table. After the function is
	 * run, the specified row should be inserted into the relation.
	 * 
	 * @input: tableName (String) - the name of the table to insert the row into
	 *         attrValues (String[]) - the values of the attributes to insert
	 *
	 * @return: Return True if successful, False otherwise
	 **/
	public boolean Insert(String tableName, String[] attrValues)
	{
		// insert query to execute
		StringBuffer query = new StringBuffer();
		
		query.append("INSERT INTO ");
		query.append(username);
		query.append(".");
		query.append(tableName);
		query.append(" VALUES (");

		// loop through the array of attributes and add them to the query string
		for (int i = 0; i < attrValues.length; i++)
		{
			if (tableName.equalsIgnoreCase("employee") && i == 2)
			{
				query.append("TO_DATE('");
				query.append(attrValues[i]);
				query.append("', 'YYYY-MM-DD')");
			}
			else if (tableName.equalsIgnoreCase("client") && i == 3)
			{
				query.append("TO_DATE('");
				query.append(attrValues[i]);
				query.append("', 'YYYY-MM-DD')");
			}
			else if ((tableName.equalsIgnoreCase("lesson")
					|| tableName.equalsIgnoreCase("test")
					|| tableName.equalsIgnoreCase("interview")) && i == 2)
			{
				query.append("TO_TIMESTAMP('");
				query.append(attrValues[i]);
				query.append("', 'YYYY-MM-DD HH24:MI:SS')");
			}
			else
			{
				query.append("'");
				query.append(attrValues[i]);
				query.append("'");
			}

			// if not at the last attribute, add a comma seperator
			if (i != attrValues.length - 1)
			{
				query.append(",");
			}
		}
		query.append(")");
		
		// try to execute the query and return true on success
		// print stack trace and return false if unsuccessful
		try
		{
			statement_.executeUpdate(query.toString());
			return true;
		}
		catch (SQLException sqlex)
		{
			sqlex.printStackTrace();
			return false;
		}
	}

	/**
	 * Function: Remove(tableName, attrValues) Description: Function will remove
	 * a row from the given table. Function assumes valid name input as
	 * tableName and attrValues, and that the table exists. After the function
	 * is run, the specified row should be removed from the relation.
	 * 
	 * @input: tableName (String) - the name of the table to remove the row from
	 *         attrValues (String[][]) - the name of the attribute and the
	 *         corresponding value for the given row to remove
	 *
	 * @return: Return True if successful, False otherwise
	 **/
	public boolean Remove(String tableName, String[][] attrValues)
	{
		// remove query to execute
		StringBuffer query = new StringBuffer();

		query.append("DELETE FROM ");
		query.append(username);
		query.append(".");
		query.append(tableName);
		query.append(" WHERE ");
		
		// loop through the attributes and append them to the WHERE clause
		for (int i = 0; i < attrValues.length; i++)
		{
			// ensures we don't grab null field name/value combination
			if (attrValues[i][0] == null)
				break;
			
			// converting timestamp into SQL timestamp
			if (i == 2)
			{
				query.append(attrValues[i][0]);
				query.append("=");
				query.append("TO_TIMESTAMP('");
				String s = attrValues[i][1];
				s = s.substring(0, s.length() - 2); // chop off the .00 second
				query.append(s);
				query.append("', 'YYYY-MM-DD HH24:MI:SS')");
			}
			else
			{
				query.append(attrValues[i][0]);
				query.append("='");
				query.append(attrValues[i][1]);
				query.append("'");
			}

			// if not at the last attribue, add an AND
			if (i != attrValues.length - 1 && attrValues[2][0] != null)
			{
				query.append(" AND ");
			}
		}

		// try to execute the query and return true on success
		// print stack trace and return false if unsuccessful
		try
		{
			statement_.executeQuery(query.toString());
			return true;
		}
		catch (SQLException sqlex)
		{
			sqlex.printStackTrace();
			return false;
		}
	}

	/**
	 * Function: Update(regNum) Description:
	 * Function will modify a row with the given regNum from the car relation.
	 * The car's faulted value will be flipped. I.e., Y -> N and vice versa.
	 * 
	 * @input: regNum (String) - regNum of the car whose faulted value is to be updated
	 *
	 * @return: Return True if successful, False otherwise
	 **/
	public boolean Update(String regNum) throws SQLException
	{
		// update query to execute
		StringBuffer query = new StringBuffer();
		
		query.append("UPDATE ");
		query.append(username);
		// we only update the car table
		query.append(".car SET ");
		
		// find the car's faulted value
		ResultSet rs = null; // storing the result of sql query
		String subquery = "select * from rdmelzer.car where regNum='";
		subquery += regNum;
		subquery += "'";
		// try to execute the query and return true on success
		// print stack trace and return false if unsuccessful
		try
		{
			rs = statement_.executeQuery(subquery);
		}
		catch (SQLException sqlex)
		{
			sqlex.printStackTrace();
			return false;
		}
		rs.next();
		String faulted = rs.getString(3);

		// the new fault value to set to
		String newFault = "";
		// we want to flip the given faulted value
		if (faulted.equalsIgnoreCase("Y"))
			newFault = "N";
		else if (faulted.equalsIgnoreCase("N"))
			newFault = "Y";
		else
			newFault = "Z"; // shouldn't happen

		// only value to be updated is the faulted field
		query.append("faulted");
		query.append("='");
		query.append(newFault);
		query.append("'");

		query.append(" WHERE ");

		// the PK of car table is regNum
		query.append("regNum");
		query.append("='");
		query.append(regNum);
		query.append("'");

		// try to execute the query and return true on success
		// print stack trace and return false if unsuccessful
		try
		{
			statement_.executeQuery(query.toString());
			Commit();
			return true;
		}
		catch (SQLException sqlex)
		{
			sqlex.printStackTrace();
			return false;
		}
	}

	/**
	 * Function: query1()
	 * Description: This function will execute the query
	 * The names and the telephone numbers of the Managers of each office.
	 * Then, it will parse through the result of the query and build 
	 * an ArrayList object containing String arrays, where each array corresponds to
	 * an individual tuple in the result table. The ArrayList object is then returned.
	 * 
	 * @input: none
	 *
	 * @return: Return ArrayList containing contents of table where each element is a
	 * String array containing fields of a given tuple and the table contains the result
	 * of the query
	 **/
	public ArrayList<String[]> query1() throws SQLException
	{

		String sql_query = "select name, phone from rdmelzer.employee" 
				+ " where employeeID in (select mgrID from rdmelzer.office)";
		int templen = 2;
		ResultSet rs = null;
		ArrayList<String[]> result = null;

		try
		{
			rs = statement_.executeQuery(sql_query);
			result = new ArrayList<String[]>();
		}
		catch (SQLException ex)
		{
			ex.printStackTrace();
			return result;
		}

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for (int i = 0; i < templen; i++)
		{
			header[i] = rsmd.getColumnName(i + 1);
		}
		result.add(header);

		while (rs.next())
		{
			String[] temp = new String[templen]; // represents individual tuple
													// in relation
			temp[0] = rs.getString("name");
			temp[1] = rs.getString("phone");
			result.add(temp);

		} // end of rs.next
		return result;
	}

	/**
	 * Function: query2()
	 * Description: This function will execute the query
	 * The total number of staff at each office. 
	 * Then, it will parse through the result of the query and build 
	 * an ArrayList object containing String arrays, where each array corresponds to
	 * an individual tuple in the result table. The ArrayList object is then returned.
	 * 
	 * @input: none
	 *
	 * @return: Return ArrayList containing contents of table where each element is a
	 * String array containing fields of a given tuple and the table contains the result
	 * of the query
	 **/
	public ArrayList<String[]> query2() throws SQLException
	{

		String sql_query = "select count(*), officeID from rdmelzer.employee group by officeID";
		int templen = 2;
		ResultSet rs = null;
		ArrayList<String[]> result = null;

		try
		{
			rs = statement_.executeQuery(sql_query);
			result = new ArrayList<String[]>();
		}
		catch (SQLException ex)
		{
			ex.printStackTrace();
			return result;
		}

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for (int i = 0; i < templen; i++)
		{
			header[i] = rsmd.getColumnName(i + 1);
		}
		result.add(header);

		while (rs.next())
		{
			String[] temp = new String[templen]; // represents individual tuple
													// in relation
			temp[0] = rs.getInt(1) + "";
			temp[1] = rs.getInt("officeID") + "";
			result.add(temp);

		} // end of rs.next
		return result;
	}

	/**
	 * Function: query3(instructorID)
	 * Description: This function will execute the query
	 * The total number of staff at each office. 
	 * Then, it will parse through the result of the query and build 
	 * an ArrayList object containing String arrays, where each array corresponds to
	 * an individual tuple in the result table. The ArrayList object is then returned.
	 * 
	 * @input: CHANGE THIS THING
	 *
	 * @return: Return ArrayList containing contents of table where each element is a
	 * String array containing fields of a given tuple and the table contains the result
	 * of the query
	 **/
	public ArrayList<String[]> query3(int instructorID) throws SQLException
	{

		String sql_query = "select * from rdmelzer.interview where interview.employeeID = "
				+ instructorID;
		int templen = 3;
		ResultSet rs = null;
		ArrayList<String[]> result = null;

		try
		{
			rs = statement_.executeQuery(sql_query);
			result = new ArrayList<String[]>();
		}
		catch (SQLException ex)
		{
			ex.printStackTrace();
			return result;
		}

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for (int i = 0; i < templen; i++)
		{
			header[i] = rsmd.getColumnName(i + 1);
		}
		result.add(header);

		while (rs.next())
		{
			String[] temp = new String[templen]; // represents individual tuple
													// in relation
			temp[0] = rs.getInt(1) + "";
			temp[1] = rs.getInt(2) + "";
			temp[2] = rs.getTimestamp(3).toString();
			result.add(temp);

		} // end of rs.next
		return result;
	}

	/**
	 * Function: query4()
	 * Description: This function will execute the query
	 * The reg number of cars that have had no faults found.
	 * Then, it will parse through the result of the query and build 
	 * an ArrayList object containing String arrays, where each array corresponds to
	 * an individual tuple in the result table. The ArrayList object is then returned.
	 * 
	 * @input: none
	 *
	 * @return: Return ArrayList containing contents of table where each element is a
	 * String array containing fields of a given tuple and the table contains the result
	 * of the query
	 **/
	public ArrayList<String[]> query4() throws SQLException
	{

		String sql_query = "select regNum from rdmelzer.car where faulted='N'";
		int templen = 1;
		ResultSet rs = null;
		ArrayList<String[]> result = null;

		try
		{
			rs = statement_.executeQuery(sql_query);
			result = new ArrayList<String[]>();
		}
		catch (SQLException ex)
		{
			ex.printStackTrace();
			return result;
		}

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for (int i = 0; i < templen; i++)
		{
			header[i] = rsmd.getColumnName(i + 1);
		}
		result.add(header);

		while (rs.next())
		{
			String[] temp = new String[templen]; // represents individual tuple
													// in relation
			temp[0] = rs.getInt(1) + "";
			result.add(temp);

		} // end of rs.next
		return result;
	}

	/**
	 * Function: query5()
	 * Description: This function will execute the query
	 * The number of administrative staff located at each office. 
	 * Then, it will parse through the result of the query and build 
	 * an ArrayList object containing String arrays, where each array corresponds to
	 * an individual tuple in the result table. The ArrayList object is then returned.
	 * 
	 * @input: none
	 *
	 * @return: Return ArrayList containing contents of table where each element is a
	 * String array containing fields of a given tuple and the table contains the result
	 * of the query
	 **/
	public ArrayList<String[]> query5() throws SQLException
	{

		String sql_query = "select count(*), officeID from rdmelzer.employee where jobTitle='Admistrative staff' group by officeID";
		int templen = 2;
		ResultSet rs = null;
		ArrayList<String[]> result = null;

		try
		{
			rs = statement_.executeQuery(sql_query);
			result = new ArrayList<String[]>();
		}
		catch (SQLException ex)
		{
			ex.printStackTrace();
			return result;
		}

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for (int i = 0; i < templen; i++)
		{
			header[i] = rsmd.getColumnName(i + 1);
		}
		result.add(header);

		while (rs.next())
		{
			String[] temp = new String[templen]; // represents individual tuple
													// in relation
			temp[0] = rs.getInt(1) + "";
			temp[1] = rs.getInt("officeID") + "";
			result.add(temp);

		} // end of rs.next
		return result;
	}
}
