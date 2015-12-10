<!doctype html>
	<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="//cdn.muicss.com/mui-0.2.8/css/mui.min.css" rel="stylesheet" type="text/css" />
		<script src="//cdn.muicss.com/mui-0.2.8/js/mui.min.js"></script>
		<link rel="stylesheet" type="text/css" href="main.css">
	</head>
	
	<%@ page import="dbController.DatabaseController,java.util.*,java.lang.StringBuffer" %>
	
	
	<body>
		<%
			String link = request.getParameter("link");
			String table = request.getParameter("table");
			ArrayList<String> values = new ArrayList<String>();
			int templen = 0;
			if(table.equals("employee")){
				values.add(request.getParameter("EMPLOYEEID"));
				values.add(request.getParameter("NAME"));
				values.add(request.getParameter("DOB"));
				values.add(request.getParameter("SEX"));
				values.add(request.getParameter("JOBTITLE"));
				values.add(request.getParameter("OFFICEID"));
				values.add(request.getParameter("PHONE"));
				values.add(request.getParameter("ADDRESS"));
				values.add(request.getParameter("CARID"));
				templen = 9;
			}
			if(table.equals("client")){
					values.add(request.getParameter("CLIENTID"));
					values.add(request.getParameter("NAME"));
					values.add(request.getParameter("SEX"));
					values.add(request.getParameter("DOB"));
					values.add(request.getParameter("ADDRESS"));
					values.add(request.getParameter("INSTID"));
					templen = 6;
			}
			if(table.equals("office")){
					values.add(request.getParameter("OFFICEID"));
					values.add(request.getParameter("MGRID"));
					values.add(request.getParameter("CITY"));
					values.add(request.getParameter("ADDRESS"));
					templen = 4;
			}
			if(table.equals("car")){
					values.add(request.getParameter("REGNUM"));
					values.add(request.getParameter("MODEL"));
					values.add(request.getParameter("FAULTED"));
					templen = 3;
			}
			if(table.equals("lesson")){
					values.add(request.getParameter("EMPLOYEEID"));
					values.add(request.getParameter("CLIENTID"));
					values.add(request.getParameter("DATEANDTIME"));
					values.add(request.getParameter("MILES"));
					templen = 4;
			}
			if(table.equals("test")){
					values.add(request.getParameter("EMPLOYEEID"));
					values.add(request.getParameter("CLIENTID"));
					values.add(request.getParameter("DATEANDTIME"));
					values.add(request.getParameter("PASSED"));
					values.add(request.getParameter("REASON_FOR_FAILURE"));
					templen = 5;
			}
			if(table.equals("interview")){
					values.add(request.getParameter("EMPLOYEEID"));
					values.add(request.getParameter("CLIENTID"));
					values.add(request.getParameter("DATEANDTIME"));
					templen = 3;
			}
			boolean worked = false;
			if(templen!=0){
				String[] s = new String[templen];
				for(int i=0; i<templen; i++){
					s[i] = values.get(i);
					out.write(s[i]+"<br>");
				}
				DatabaseController dbcontroller = new DatabaseController();
				dbcontroller.Open();
				worked = dbcontroller.Insert(table, s);
				dbcontroller.Close();
				out.write("FINISHED");
			}
			if(worked){
				response.sendRedirect(link);
			}
		%>
	</body>