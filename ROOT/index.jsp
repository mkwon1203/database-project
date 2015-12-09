`<%@ page import="dbController.DatabaseController,java.util.*,java.lang.StringBuffer" %>
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
					String tableParams = "";
					String queryParams = "";
					String insertParams = "";
					if(table == null){
						insertParams += "tableName=employee";
						queryParams = "tableName=employee&query=";
					}else{
						insertParams += "tableName=" + table;
						queryParams = "tableName=" + table + "&query=";
					}
					if(query == null){
						insertParams += "&query=1";
						tableParams = "query=1&tableName=";
					}else{
						insertParams += "&query=" + query;
						tableParams = "query=" + query + "&tableName=";
					}
					
				%>
                <!--dropdown to select table to display-->
                <div class="mui-dropdown myDropdown">
                    <button class="mui-btn mui-btn--primary" data-mui-toggle="dropdown">
                        Pick a Table
                        <span class="mui-caret"></span>
                    </button>
                    <ul class="mui-dropdown__menu" style="top: 42px;">
                        <li><a href="index.jsp?<%=tableParams%>employee">Employees</a></li>
                        <li><a href="index.jsp?<%=tableParams%>client">Clients</a></li>
                        <li><a href="index.jsp?<%=tableParams%>office">Offices</a></li>
                        <li><a href="index.jsp?<%=tableParams%>car">Cars</a></li>
                        <li><a href="index.jsp?<%=tableParams%>lesson">Lessons</a></li>
                        <li><a href="index.jsp?<%=tableParams%>test">Tests</a></li>
                        <li><a href="index.jsp?<%=tableParams%>interview">Interviews</a></li>
                    </ul>
                </div>
				
				<%
					ArrayList<String[]> results = null;
					DatabaseController dbcontroller = new DatabaseController();
					dbcontroller.Open();

					if(table == null){
						table = "employee";
					}
					out.write("<h1 style='text-align:center;font-size:50px;padding-bottom:15px'>" + table.substring(0,1).toUpperCase() + table.substring(1) + "s</h1>");
					String tName = table.substring(0,1).toUpperCase() + table.substring(1);
					results = dbcontroller.DisplayTable(table);
					
					
					if(results != null && results.size() > 0){
						out.write("<table class='mui-table myTable'>");	
						for(int i=0; i<results.size(); i++){
							if(i==0){
								out.write("<thead>");
							}
							out.write("<tr>");
							String[] s = results.get(i);
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
                        <li><a href="index.jsp?tableName=Employee">Query #1</a></li>
                        <li><a href="index.jsp?tableName=Client">Query #2</a></li>
                        <li><a href="index.jsp?tableName=Office">Query #3</a></li>
                        <li><a href="index.jsp?tableName=Car">Query #4</a></li>
                        <li><a href="index.jsp?tableName=Lesson">Query #5</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

</body>

</html>
