`<%@ page import="dbController.DatabaseController,java.util.*,java.lang.StringBuffer" 

	
%>
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

					//Write out a header for the table with a capitolized name
					out.write("<h1 style='text-align:center;font-size:50px;padding-bottom:15px'>" + table.substring(0,1).toUpperCase() + table.substring(1) + "s</h1>");

					//Call display table from the java class
					String tName = table.substring(0,1).toUpperCase() + table.substring(1);
					results = dbcontroller.DisplayTable(table);
					
					
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
						out.write("<tr><form action='index.jsp?" + insertParams + "' method='POST'>");
						String[] headers = results.get(0);
						for(int y=0; y<headers.length; y++){
							out.write("<td><input type='text-field' name='" + headers[y] +"'></td>");
						}
						out.write("</tr></table>");
						out.write("<input type='submit' value='Insert'></form>");
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

				//switch on the query to have the java class execute the right special query
				switch (queryInt){
					case 1:
						results = dbcontroller.query1();
						break;
					case 2:
						results = dbcontroller.query2();
						break;
					case 3:
						results = dbcontroller.query3();
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
						out.write("<BR><BR>NULL<BR><BR>");
					}
					dbcontroller.Close();
			%>

            </div>
        </div>
    </div>
</div>

</body>

</html>
