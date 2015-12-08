<%@ page import="dbController.DatabaseController,java.util.*,java.lang.StringBuffer" %>
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

                <!--dropdown to select table to display-->
                <div class="mui-dropdown myDropdown">
                    <button class="mui-btn mui-btn--primary" data-mui-toggle="dropdown">
                        Pick a Table
                        <span class="mui-caret"></span>
                    </button>
                    <ul class="mui-dropdown__menu" style="top: 42px;">
                        <li><a href="index.jsp?tableName=employee">Employees</a></li>
                        <li><a href="index.jsp?tableName=client">Clients</a></li>
                        <li><a href="index.jsp?tableName=office">Offices</a></li>
                        <li><a href="index.jsp?tableName=car">Cars</a></li>
                        <li><a href="index.jsp?tableName=lesson">Lessons</a></li>
                        <li><a href="index.jsp?tableName=test">Tests</a></li>
                        <li><a href="index.jsp?tableName=interview">Interviews</a></li>
                    </ul>
                </div>
				
				<%
					String table = request.getParameter("tableName");
					
					
					ArrayList<String[]> results = null;
					DatabaseController dbcontroller = new DatabaseController();
					dbcontroller.Open();

					if(table == null){
						results = dbcontroller.DisplayTable("employee");
					}else{
						results = dbcontroller.DisplayTable(table);
					}
					
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
						out.write("</table>");
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
