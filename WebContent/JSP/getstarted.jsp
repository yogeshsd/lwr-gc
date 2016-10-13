<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	$("#editmenu").hide();
	$("#savepersonalmenu").hide();
	$("#savepublicmenu").hide();
	$("#pdfmenu").hide();
	$("#csvmenu").hide();
	$("#htmlmenu").hide();
});
</script>
<section id="mainsection">
<br>
<h1>Getting Started With <%=DashboardConstants.PRODUCT_NAME %>!</h1>
<%=DashboardConstants.PRODUCT_NAME %> is a simple web based report/dashboard generation tool. It lets you create simple reports/dashboard very easily. The package consists of war file that you need to deploy on a application server like tomcat.<br>
<h3>Prerequisite</h3>
<ul>
	<li>Tomcat Application Server v8.0 and above</li>
	<li>Required JDBC Driver(s) to connect to database(s)</li>
</ul>
<h3>Installation</h3>

Copy the lwr.war file downloaded from sourceforge.net and place it under CATALINA_HOME/webapps/ directory. <%=DashboardConstants.PRODUCT_NAME %> uses JDBC to connect to database(s). The JDBC drivers for Postgres and MySQL are already bundled into the war file. To connect to any other database vendor, copy the required vendor specific JDBC jar file to CATALINA_HOME/webapps/lwr/WEB-INF/lib folder and restart the tomcate server<br>

<h3>Step 1</h3>
Access the application using below URL, <br>
<br>
<span style="font-weight:bold;color:blue">
	http://&lt;hostname&gt;:&lt;port&gt;/lwr
</span>
<br>
<br>
Where, port -> port on which tomcat is listening<br>

<h3>Step 2</h3>
Once you open this URL in your browsers you would be redirected to login page that asks you for username and password. The default username is <span style="font-weight:bold;">"admin"</span> and default password is <span style="font-weight:bold">"admin"</span>. It is highly recommended to change the password for "admin" user by navigating to Administration->User Management page. You can create more users.
<h3>Step 3</h3>
Create a database connection by going to <span style="font-weight:bold">Administrator -> Connection Management</span>. connection is created by providing 
<ul>
	<li>Username</li>
	<li>Password</li>
	<li>JDBC Driver Class</li>
	<li>JDBC Driver URL</li>
</ul>
Once these properties are keyed in, performn test connection to check if the connectivity is established using above mentioned properties. If test connection is successful, save the connection details.<br>
The application lets you define one or more such connections pointing to different databases and with in  a report we can pick data from different connections.<br>
<br>
<h3>Step 4</h3>
Building a report by going to <span style="font-weight:bold">File -> New Report</span> this involves multiple elements arranged in rows and columns. For each of the element you need to provide
<ul>
	<li>Title</li>
	<li>SQL Query</li>
	<li>Chart Type</li>
	<li>Database Connection</li>
</ul>
A single report having multiple elements can retrive data from one or more databases. Support Chart Types are
<ul>
	<li>Pie Chart</li>
	<li>Line Chart</li>
	<li>Bar Chart</li>
	<li>Bar Chart Stacked</li>
	<li>Column Chart</li>
	<li>Column Chart Stacked</li>
	<li>Table Chart</li>
	
</ul>
All these charts are google charts and you need to be connected to internet for it to render the HTML
</section>
<br>
<br>
<%@ include file="footer.jsp"%>