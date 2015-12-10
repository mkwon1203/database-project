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
	
	<script>
		function back(){
			window.location="index.jsp?tableName=car&query=1";
		}
	</script>
	
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
			ArrayList<String[]> results = null;
			DatabaseController dbcontroller = new DatabaseController();
			dbcontroller.Open();
			
			out.write("<button class='mui-btn mui-btn--primary' onclick='back()'>Back</form>");
			out.write("<h1 style='text-align:center;font-size:50px;padding-bottom:15px'>Editing Cars</h1>");
			
			results = dbcontroller.DisplayTable("car");
			
			if(results != null && results.size() > 0){
				out.write("<table class='mui-table myTable'>");	
				//loop through the loop of results
				int total = 0;
				for(int i=0; i<results.size(); i++, total++){
					if(i==0){
						out.write("<thead>");
					}
					out.write("<tr>");

					//get the current tuple's attribute values
					String[] s = results.get(i);
					
					for(int j=0; j<s.length; j++){
						if(i==0){
							out.write("<th>" + s[j] + "</th>");
						}else{
							out.write("<td>");
							out.write(s[j]);
							out.write("</td>");
						}
					}
					
					if(i==0){
						out.write("<th></th>");
						out.write("</thead>");
					}else{
						out.write("<td><a href='update.jsp?regnum=" + s[0] + "'><button class='mui-btn mui-btn--primary'>TOGGLE FAULT</button></a> </td>");
					}
					out.write("</tr>");
				}
				//out.write("<tr><form action='insert.jsp' method='POST'>");
				//out.write("<input type='text' name='link' style='display:none' value='index.jsp?" + insertParams+ "'>");
				//out.write("<input type='text' name='table' style='display:none' value='" + table+ "'>");
				//String[] headers = results.get(0);
				//for(int y=0; y<headers.length; y++){
				//	out.write("<td><input type='text' name='" + headers[y] +"' required></td>");
				//}
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