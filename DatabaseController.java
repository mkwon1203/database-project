package dbController;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.ResultSet;
import java.util.*;

/**
 * Servlet implementation class for Servlet: DatabaseController
 *
 */
public class DatabaseController {
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


  public DatabaseController() {
    // your cs login name
    username = "mkwon1203";
    // your Oracle password, NNNN is the last four digits of your CSID
    password = "password";
    connect_string_ = "jdbc:oracle:thin:@aloe.cs.arizona.edu:1521:oracle";
  }


  /**
   * Closes the DBMS connection that was opened by the open call.
   */
  public void Close() {
    try {
      statement_.close();
      connection_.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    connection_ = null;
  }


  /**
   * Commits all update operations made to the dbms.
   * If auto-commit is on, which is by default, it is not necessary to call
   * this method.
   */
  public void Commit() {
    try {
      if (connection_ != null && !connection_.isClosed())
        connection_.commit();
    } catch (SQLException e) {
      System.err.println("Commit failed");
      e.printStackTrace();
    }
  }


  public void Open() {
    boolean opened = false;
    while (!opened) {
      try {
        Class.forName("oracle.jdbc.OracleDriver");
        connection_ = DriverManager.getConnection(
            connect_string_, username, password);
        statement_ = connection_.createStatement();
        opened = true;
        return;
      } catch (SQLException sqlex) {
        sqlex.printStackTrace();
        opened  = false;
      } catch (ClassNotFoundException e) {
        e.printStackTrace();
        System.exit(1); //programemer/dbsm error
      } catch (Exception ex) {
        ex.printStackTrace();
        System.exit(2);
      }
    }
  }


  // public Vector<String> FindAllEmployees() {
  //   String sql_query = "SELECT * FROM mccann.employee";
  //   try {
  //     ResultSet rs  = statement_.executeQuery(sql_query);
  //     Vector<String> result_employees = new Vector<String>();
  //     while (rs.next()) {
  //        String temp_record = rs.getString("fname") + "##" + rs.getString("minit") +
  //            "##" + rs.getString("lname") + "##" + rs.getString("ssn") + "##" +
  //            rs.getString("bdate") + "##" + rs.getString("address") + "##" +
	 //     rs.getString("sex") + "##" + rs.getString("salary") +
	 //     "##" + rs.getString("superssn") + "##" + rs.getString("dno");
  //       result_employees.add(temp_record);
  //     }
  //     return result_employees;
  //   } catch (SQLException sqlex) {
  //     sqlex.printStackTrace();
  //   }
  //   return null;
  // }

  public ArrayList<String[]> DisplayTable(String tableName)
  {
    String sql_query;
    int templen;
    ResultSet rs = null;
    ArrayList<String[]> result = null;
    String user = "rdmelzer"; // change if need be

    switch (tableName)
    {
      case "employee":
        sql_query = "SELECT * FROM " + user + ".employee";
        templen = 9;
        break;
      case "client":
        sql_query = "SELECT * FROM " + user + ".client";
        templen = 6;
        break;
      case "office":
        sql_query = "SELECT * FROM " + user + ".office";
        templen = 4;
        break;
      case "car":
        sql_query = "SELECT * FROM " + user + ".car";
        templen = 3;
        break;
      case "lesson":
        sql_query = "SELECT * FROM " + user + ".lesson";
        templen = 4;
        break;
      case "test":
        sql_query = "SELECT * FROM " + user + ".test";
        templen = 5;
        break;
      case "interview":
        sql_query = "SELECT * FROM " + user + ".interview";
        templen = 3;
        break;
      default:
        sql_query = "THIS SHOULDN'T HAVE HAPPENED";
        templen = -1;
        break;
    }

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

    while (rs.next())
    {
      String[] temp = new String[templen]; // represents individual tuple in relation

      switch(tableName)
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

  public boolean InsertEmployee(String employeeID, String name, String DOB, String sex, String jobTitle, String officeID, String phone, String address, String cardID)
  {

  }


  /**
  * Function: Insert(tableName, attrValues)
  * Description:  Function will insert a row from the given table.  Function assumes
  *               valid name input for tableName and attrValues, and that the table exists.
  *               Function also assumes that attribute values are supplied in an order
  *               corresponding to the order of the attributes in the actual table.
  *               After the function is run, the specified row should be inserted into the relation.
  * @input:
  *         tableName (String) - the name of the table to insert the row into
  *         attrValues (String[]) - the values of the attributes to insert
  *
  * @return: Return True if successful, False otherwise
  **/
  public boolean Insert(String tableName, String[] attrValues){
    StringBuffer query = new StringBuffer();
    query.append("INSERT INTO ");
    query.append(tableName);
    query.append(" (");

    //loop through the array of attributes and add them to the query string
    for (int i = 0; i < attrValues.len; i++){
      query.append("'");
      query.append(attrValues[i]);
      query.append("'");

      //if not at the last attribute, add a comma seperator
      if (i+1 < attrValues.len){
        query.append(",");
      }

      query.append(")");

      //try to execute the query and return true on success
      //print stack trace and return false if unsuccessful
      try{
        ResultSet rs = statement_.executeQuery(query.toString());
        return true;
      } catch (SQLException sqlex){
        sqlex.printStackTrace;
        return false;
      }
      //execute the
    }
  }

  /**
  * Function: Remove(tableName, attrValues)
  * Description:  Function will remove a row from the given table.  Function assumes
  *               valid name input as tableName and attrValues, and that the table exists.
  *               After the function is run, the specified row should be removed from the relation.
  * @input:
  *         tableName (String) - the name of the table to remove the row from
  *         attrValues (String[][]) - the name of the attribute and the corresponding value for the given row to remove
  *
  * @return: Return True if successful, False otherwise
  **/
  public boolean Remove(String tableName, String[][] attrValues){
    StringBuffer query = new StringBuffer();
    query.append("DELETE FROM ");
    query.append(tableName);
    query.append(" WHERE ");

    //loop through the attributes and append them to the WHERE clause
    for (int i = 0; i < attrValues.len; i++){
      query.append(attrValues[i]);
      query.append(" = '");
      query.append(attrValues[i][0]);
      query.append("' ");

      //if not at the last attribue, add an AND clause
      if (i+1 < attrValues.len){
        query.append(" AND ");
      }

      //try to execute the query and return true on success
      //print stack trace and return false if unsuccessful
      try{
        statement_.executeQuery(query.toString());
        return true;
      } catch (SQLException sqlex){
        sqlex.printStackTrace();
        return false;
      }
    }
  }

  /**
  * Function: Update(tableName, attrValues, oldPrimaryKeys)
  * Description:  Function will modify a row from the given table.  Function assumes
  *               valid name input as tableName and attrValues, and that the table exists.
  *               After the function is run, the specified row should be modified to reflect specified data.
  * @input:
  *         tableName (String) - the name of the table to remove the row from
  *         attrValues (String[][]) - the name of the attribute and the corresponding value to update row with
  *         oldPrimaryKeys (String[][]) - the name of the PK's with old values to identify row to update
  *
  * @return: Return True if successful, False otherwise
  **/
  public boolean Update(String tableName, String[][] attrValues, String[][] oldPrimaryKeys){
        StringBuffer query = new StringBuffer();
    query.append("UPDATE ");
    query.append(tableName);
    query.append(" WHERE ");

    //loop through and identify the row by its old data
    for (int i = 0; i < oldPrimaryKeys.len; i++){
      query.append(oldPrimaryKeys[i])
      query.append(" = '");
      query.append(oldPrimaryKeys[i][0]);

      //if not at the last attribute, add an AND clause
      if (i+1 < oldPrimaryKeys.len){
        query.append(" AND ");
      }
    }

    query.append(" SET ");

    //loop through the new attrValues and set them
    for (int i = 0; i < attrValues.len; i++){
      query.append(attrValues[i]);
      query.append(" = ");
      query.append(attrValues[i][0]);

      //if not on the last iteration of the loop, add a comma seperator
      if (i+1 < attrValues.len){
        query.append(", ");
      }
    }

    //try to execute the query and return true on success
    //print stack trace and return false if unsuccessful
    try{
      statement_.executeQuery(query.toString());
      return true;
    } catch (SQLException sqlex){
      sqlex.printStackTrace();
      return false;
    }


  }
}
