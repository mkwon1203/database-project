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
			String tableName = "", link = "";
			String[] compositeKeys = new String[3];
			int keyCounter = 0;
			String primaryKey1 = "", primaryKey2 = "", primaryKey3 = "";

			//retrive all GET parameters
			tableName = request.getParameter("tableName");
		    primaryKey1 = request.getParameter("primaryKey1");
		    primaryKey2 = request.getParameter("primaryKey2");
		    primaryKey3 = request.getParameter("primaryKey3");
	    	link = "index.jsp?tableName=" + tableName + "&query=" + request.getParameter("query");

	    	compositeKeys[0] = request.getParameter("primaryKey1value");
	    	compositeKeys[1] = request.getParameter("primaryKey2value");
	    	compositeKeys[2] = request.getParameter("primaryKey3value");

		    

		    String[][] deleteParameters = new String[3][2];
		    deleteParameters[0][0] = primaryKey1;
		    deleteParameters[0][1] = compositeKeys[0];

		    if (compositeKeys[1] != null){
		    	deleteParameters[1][0] = primaryKey2;
		    	deleteParameters[1][1] = compositeKeys[1];
			
		    	deleteParameters[2][0] = primaryKey3;
		    	deleteParameters[2][1] = compositeKeys[2];
			}

			DatabaseController dbc = new DatabaseController();

			Boolean success = false;
			dbc.Open();
			out.write("about to remove from " + tableName);
			success = dbc.Remove(tableName, deleteParameters);
			dbc.Commit();
			dbc.Close();
			out.write("remove query executed, if successful will redirect <br>");
			if (success){
				response.sendRedirect(link);
				//out.write(tableName + "<br>" + deleteParameters[0][0] + " " + deleteParameters[0][1]);
			}else {
				response.sendRedirect(link);
			}
		%>

	</body>