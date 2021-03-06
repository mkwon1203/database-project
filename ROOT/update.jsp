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
			//retrive all GET parameters
			String regnum = request.getParameter("regnum");
			String queryParam = request.getParameter("query");
		    
			DatabaseController dbc = new DatabaseController();
			
			boolean worked = false;
			dbc.Open();
			out.write("If page does not redirect then something went wrong!<br>Go back and try again!");
			worked = dbc.Update(regnum);
			dbc.Commit();
			dbc.Close();
			
			response.sendRedirect("edit.jsp?query=" + queryParam);

		%>

	</body>