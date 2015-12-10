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
			String tableName, link;
			String[] compositeKeys;
			int keyCounter = 0;
			String primaryKey1, primaryKey2, primaryKey3;

			java.util.Enumeration params = request.getParameterNames();
		    while(params.hasMoreElements()) {
		        String paramName = (String) params.nextElement();

		        if (paramName == "tableName"){
		        	tableName = request.getParameter(paramName);
		        }
		        if (paramName == "primaryKey1"){
		        	primaryKey1 = request.getParameter(paramName);
		        }
		        else if (paramName == "primaryKey2")
		        	primaryKey2 = request.getParameter(paramName);
		        else if (paramName == "primaryKey3")
		        	primaryKey3 = request.getParameter(paramName);

		        else if (paramName == "query")
		        	link = "index.jsp?tableName=" + request.getParameter("tableName") + "&query=" + request.getParameter("query");

		        //otherwise it's a primary key value
		        else{
		        	compositeKeys[keyCounter] = request.getParameter(paramName);
		        	keyCounter++;
		        }
		    }

		    String[][] deleteParameters;
		    deleteParameters[0][0] = primaryKey1;
		    deleteParameters[0][1] = compositeKeys[0];

		    if (keyCounter > 1){
		    	deleteParameters[1][0] = primaryKey2;
		    	deleteParameters[1][1] = compositeKeys[1];
			}

			if (keyCounter > 2) {
		    	deleteParameters[2][0] = primaryKey3;
		    	deleteParameters[2][1] = compositeKeys[2];
			}

			DatabaseController dbc = new DatabaseController();

			Boolean success = false;
			dbc.Open();
			success = dbc.Remove(tableName, deleteParameters);
			dbc.Commit();
			dbc.Close();

			if (success)
				response.sendRedirect(link);
		%>

	</body>