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
                        <li><a href="index.jsp?tableName=Employee">Employees</a></li>
                        <li><a href="index.jsp?tableName=Client">Clients</a></li>
                        <li><a href="index.jsp?tableName=Office">Offices</a></li>
                        <li><a href="index.jsp?tableName=Car">Cars</a></li>
                        <li><a href="index.jsp?tableName=Lesson">Lessons</a></li>
                        <li><a href="index.jsp?tableName=Test">Tests</a></li>
                        <li><a href="index.jsp?tableName=Interview">Interviews</a></li>
                    </ul>
                </div>
				
				<%
					String table = request.getParameter("tableName");
					out.write("Name of Table = " + table);
					
					DatabaseController dbcontroller = new DatabaseController();
					
					
					
				%>
				

                    <table class="mui-table myTable">
                        <thead>
                            <tr>
                                <th>Car</th>
                                <th>Bike</th>
                                <th>Tire</th>
                                <th>Poop</th>
                                <th>Guns</th>
                                <th>BIG ASS FREAK</th>
                            </tr>
                        </thead>
                    </table>

            </div>
        </div>
    </div>
</div>

</body>

</html>