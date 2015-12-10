<%@ page import="dbController.DatabaseController,java.util.*,java.lang.StringBuffer"%>

<jsp:include page="header.jsp"></jsp:include>

<body>

<div class="mui-appbar topbar">
    <div class="mui-container centerTitle">
        <div class="mui--text-display1">EasyDrive School of Motoring</div>
    </div>
</div>

<div class="mui-container-fluid" id="main-wrapper">
    <div class="mui-row">
        <div class="mui-col-sm-10 mui-col-sm-offset-1">
            <!--Panel for info display-->
            <div class="mui-panel">
				<%
					String table = request.getParameter("tableName");
					if ( table == null){
						table = "employee";
					}
					//identify how many primary keys there are for this table
					//if not in the switch, then it's 1 primary key
					//if it is a table in the switch, there's 3 primary keys
					int primaryKeyCount = 1;
					if (table.toLowerCase().trim().equals("lesson") || table.toLowerCase().trim().equals("test") || table.toLowerCase().trim().equals("interview")){
							primaryKeyCount = 3;
					}
					String query = request.getParameter("query");
					String tableSelection = "";
					String querySelection = "";
					String insertParams = "";
					if(table == null){
						tableSelection += "tableName=employee";
					}else{
						tableSelection += "tableName=" + table;
					}
					if(query == null){
						querySelection += "query=1";
					}else{
						querySelection += "query=" + query;
					}
					insertParams = tableSelection+"&"+querySelection;
					
				%>
                <!--dropdown to select table to display-->
                <div class="mui-dropdown myDropdown">
                    <button class="mui-btn mui-btn--primary" data-mui-toggle="dropdown">
                        Pick a Table
                        <span class="mui-caret"></span>
                    </button>
                    <ul class="mui-dropdown__menu" style="top: 42px;">
                        <li><a href="index.jsp?tableName=employee&<%=querySelection%>">Employees</a></li>
                        <li><a href="index.jsp?tableName=client&<%=querySelection%>">Clients</a></li>
                        <li><a href="index.jsp?tableName=office&<%=querySelection%>">Offices</a></li>
                        <li><a href="index.jsp?tableName=car&<%=querySelection%>">Cars</a></li>
                        <li><a href="index.jsp?tableName=lesson&<%=querySelection%>">Lessons</a></li>
                        <li><a href="index.jsp?tableName=test&<%=querySelection%>">Tests</a></li>
                        <li><a href="index.jsp?tableName=interview&<%=querySelection%>">Interviews</a></li>
                    </ul>
                </div>
				
				<%
					ArrayList<String[]> results = null;
					DatabaseController dbcontroller = new DatabaseController();
					dbcontroller.Open();

					if(table == null){
						table = "employee";
					}
					if(table.equals("car")){
						out.write("<a href='edit.jsp?" + querySelection + "'><button class='mui-btn mui-btn--primary'>Edit Table</button></a>");
					}
					//Write out a header for the table with a capitolized name
					out.write("<h1 style='text-align:center;font-size:50px;padding-bottom:15px'>" + table.substring(0,1).toUpperCase() + table.substring(1) + "s</h1>");

					//Call display table from the java class
					String tName = table.substring(0,1).toUpperCase() + table.substring(1);
					
					//call the query to display the table from the java class
					results = dbcontroller.DisplayTable(table);

					
					
					//declare strings for the primary keys to pass to delete
					String primaryKey1 = "", primaryKey2 = "", primaryKey3 = "";

					//declare strings for primary key values to pass to delete
					String primaryKey1value = "", primaryKey2value = "", primaryKey3value = "";
					//if there are results
					if(results != null && results.size() > 0){
						out.write("<table class='mui-table myTable'>");	
						//loop through the loop of results
						for(int i=0; i<results.size(); i++){
							if(i==0){
								out.write("<thead>");
							}
							out.write("<tr>");

							//get the current tuple's attribute values
							String[] s = results.get(i);

							//delcare a string to store the get parameters for delete
							String primaryKeyParms = tableSelection + "&" + querySelection;
							String deleteParms = "", updateParms = "";
							//if printing headers, get the attribute name
							if (i == 0){
								primaryKey1 = s[0];
								if (primaryKeyCount == 3){
									primaryKey2 = s[1];
									primaryKey3 = s[2];
								}
							} else{
								primaryKey1value = s[0];
								
								//add the primary key values to the delete link
								primaryKeyParms += "&primaryKey1=" + primaryKey1 + "&primaryKey1value=" + primaryKey1value;

								if (primaryKeyCount > 1){
									primaryKey2value = s[1];
									primaryKey3value = s[2];

									primaryKeyParms += "&primaryKey2=" + primaryKey2 + "&primaryKey2value=" + primaryKey2value + "&primaryKey3=" + primaryKey3 + "&primaryKey3value=" + primaryKey3value;
								}
							}
							//loop through all the attribute values and print table cells
							deleteParms = "delete.jsp?" + primaryKeyParms;
							updateParms = "edit.jsp?" + primaryKeyParms;

							for(int j=0; j<s.length; j++){
								if(i==0){
									out.write("<th>" + s[j] + "</th>");
								}else{
									out.write("<td>" + s[j] + "</td>");
								}
							}
							
							if(i==0){
								out.write("<th></th>");
								out.write("</thead>");
							}else{
								out.write("<td><a href=\"" + deleteParms + "\"><button class=\"mui-btn mui-btn--primary\">Delete</button></a> </td>");
							}
							out.write("</tr>");
						}
						out.write("<tr><form action='insert.jsp' method='POST'>");
						out.write("<input type='text-field' name='link' style='display:none' value='index.jsp?" + insertParams+ "'>");
						out.write("<input type='text-field' name='table' style='display:none' value='" + table + "'>");
						String[] headers = results.get(0);
						for(int y=0; y<headers.length; y++){
							out.write("<td><input type='text-field' name='" + headers[y] +"' required></td>");
						}
						out.write("<td><input class='mui-btn mui-btn--primary' type='submit' value='Insert'></form></td>");
						out.write("</tr></table>");
					}else{
						out.write("<BR><BR>NULL<BR><BR>");
					}
					dbcontroller.Close();
				%>
				
				
            </div>
            <div class="mui-panel">

                <!--dropdown to select table to display-->
                <div class="mui-dropdown myDropdown">
                    <button class="mui-btn mui-btn--primary" data-mui-toggle="dropdown">
                        Select A Query
                        <span class="mui-caret"></span>
                    </button>
                    <div class="mui--text-title">The names and the telephone numbers of the Managers of each office.</div>
                    <ul class="mui-dropdown__menu" style="top: 42px;">
                        <li><a href="index.jsp?<%=tableSelection%>&query=1">Query #1</a></li>
                        <li><a href="index.jsp?<%=tableSelection%>&query=2">Query #2</a></li>
                        <li><a href="index.jsp?<%=tableSelection%>&query=3">Query #3</a></li>
                        <li><a href="index.jsp?<%=tableSelection%>&query=4">Query #4</a></li>
                        <li><a href="index.jsp?<%=tableSelection%>&query=5">Query #5</a></li>
                    </ul>
                </div>

			<% 
				//check that query is set
				if (query == null){
					query = "1";
				}
				
				dbcontroller = new DatabaseController();
				dbcontroller.Open();
				int queryInt = Integer.parseInt(query);
				String empid = request.getParameter("empid");

				// switch on the query to have the java class execute the right special query
				switch (queryInt){
					case 1:
						results = dbcontroller.query1();
						break;
					case 2:
						results = dbcontroller.query2();
						break;
					case 3:
						if(empid != null){
							results = dbcontroller.query3(Integer.parseInt(empid));
						}else{
							out.write("Please enter a employee ID to search for: <form action='index.jsp?query=3&" + insertParams + "'><input type='text' name='empid' required>" + 
							" <input type='hidden' name='tableName' value='employee'> <input type='hidden' name='query' value='3'> &nbsp&nbsp&nbsp<input type='submit' value='Query' class='mui-btn mui-btn--primary'>");
							results = null;
						}
						break;
					case 4:
						results = dbcontroller.query4();
						break;
					case 5:
						results = dbcontroller.query5();
						break;
				}

				//print a header for the table
				
				//print the query results
				//if there are results
				if(results != null && results.size() > 0){
					out.write("<table class='mui-table myTable'>");	
					//loop through the loop of results
					for(int i=0; i<results.size(); i++){
						if(i==0){
							out.write("<thead>");
						}
						out.write("<tr>");
						String[] s = results.get(i);
						//loop through all the attribute values and print table cells
						for(int j=0; j<s.length; j++){
							if(i==0){
								out.write("<th>" + s[j] + "</th>");
							}else{
								out.write("<td>" + s[j] + "</td>");
							}
						}
						if(i==0){
							out.write("</thead>");
						}
						out.write("</tr>");
					}
					
					out.write("</tr></table>");
					
				}else{
					out.write("<BR><BR>NO RESULTS<BR><BR>");
				}
				dbcontroller.Close();
			%>

            </div>
        </div>
    </div>
</div>

</body>

</html>
