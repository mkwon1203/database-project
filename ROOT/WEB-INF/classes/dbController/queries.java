
	//a) The names and the telephone numbers of the Managers of each office.
	private static ArrayList<String[]> queryA() {
		
		String sql_query = "select name, phone from rdmelzer.employee where employeeID in (select mgrID from rdmelzer.office)";
    	int templen = 2;
   		ResultSet rs = null;
    	ArrayList<String[]> result = null;

    	try {
			rs = statement_.executeQuery(sql_query);
     		result = new ArrayList<String[]>();
  	  	}
    	catch (SQLException ex) {
      		ex.printStackTrace();
      		return result;
   		 }

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for(int i=0; i<templen; i++) {
			header[i] = rsmd.getColumnName(i+1);
		}
		result.add(header);	

    	while (rs.next()) {
        	String[] temp = new String[templen]; // represents individual tuple in relation
        	temp[0] = rs.getString("name");
        	temp[1] = rs.getString("phone");
        	result.add(temp);

     	} // end of rs.next
    	return result;
	}

	//d) The total number of staff at each office. 
	private static ArrayList<String[]> queryD() {
		
		String sql_query = "select count(*), officeID from rdmelzer.employee group by officeID";
    	int templen = 2;
   		ResultSet rs = null;
    	ArrayList<String[]> result = null;

    	try {
			rs = statement_.executeQuery(sql_query);
     		result = new ArrayList<String[]>();
  	  	}
    	catch (SQLException ex) {
      		ex.printStackTrace();
      		return result;
   		}

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for(int i=0; i<templen; i++) {
			header[i] = rsmd.getColumnName(i+1);
		}
		result.add(header);	

    	while (rs.next()) {
        	String[] temp = new String[templen]; // represents individual tuple in relation
        	temp[0] = rs.getInt(1);
        	temp[1] = rs.getInt("officeID");
        	result.add(temp);

     	} // end of rs.next
    	return result;
	}

	//g) The details of interviews conducted by a given Instructor.
	private static ArrayList<String[]> queryG(int instructorID) {
		
		String sql_query = "select * from rdmelzer.interview where interview.employeeID = " + instructorID;
    	int templen = 3;
   		ResultSet rs = null;
    	ArrayList<String[]> result = null;

    	try {
			rs = statement_.executeQuery(sql_query);
     		result = new ArrayList<String[]>();
  	  	}
    	catch (SQLException ex) {
      		ex.printStackTrace();
      		return result;
   		}

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for(int i=0; i<templen; i++) {
			header[i] = rsmd.getColumnName(i+1);
		}
		result.add(header);	

    	while (rs.next()) {
        	String[] temp = new String[templen]; // represents individual tuple in relation
        	temp[0] = rs.getInt(1);
        	temp[1] = rs.getInt(2);
        	temp[2] = rs.getTimestamp(3).toString();
        	result.add(temp);

     	} // end of rs.next
    	return result;
	}

	//j) The reg number of cars that have had no faults found.	
	private static ArrayList<String[]> queryJ() {
		
		String sql_query = "select regNum from rdmelzer.car where faulted='N'"
    	int templen = 1;
   		ResultSet rs = null;
    	ArrayList<String[]> result = null;

    	try {
			rs = statement_.executeQuery(sql_query);
     		result = new ArrayList<String[]>();
  	  	}
    	catch (SQLException ex) {
      		ex.printStackTrace();
      		return result;
   		}

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for(int i=0; i<templen; i++) {
			header[i] = rsmd.getColumnName(i+1);
		}
		result.add(header);	

    	while (rs.next()) {
        	String[] temp = new String[templen]; // represents individual tuple in relation
        	temp[0] = rs.getInt(1);
        	result.add(temp);

     	} // end of rs.next
    	return result;
	}
	
	//o) The number of administrative staff located at each office.
	private static ArrayList<String[]> queryO() {

		String sql_query = "select count(*), officeID from rdmelzer.employee where jobTitle='Admistrative staff' group by officeID";
    	int templen = 2;
   		ResultSet rs = null;
    	ArrayList<String[]> result = null;

    	try {
			rs = statement_.executeQuery(sql_query);
     		result = new ArrayList<String[]>();
  	  	}
    	catch (SQLException ex) {
      		ex.printStackTrace();
      		return result;
   		}

		String[] header = new String[templen];
		ResultSetMetaData rsmd = rs.getMetaData();
		for(int i=0; i<templen; i++) {
			header[i] = rsmd.getColumnName(i+1);
		}
		result.add(header);	

    	while (rs.next()) {
        	String[] temp = new String[templen]; // represents individual tuple in relation
        	temp[0] = rs.getInt(1);
        	temp[1] = rs.getInt("officeID");
        	result.add(temp);

     	} // end of rs.next
    	return result;		

	}
