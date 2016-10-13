<%@page import="com.lwr.software.reporter.reportmgmt.RowElement"%>
<%@page import="com.lwr.software.reporter.reportmgmt.Element"%>
<%@page import="com.lwr.software.reporter.reportmgmt.ReportManager"%>
<%@page import="com.lwr.software.reporter.reportmgmt.Report"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page import="com.lwr.software.reporter.admin.usermgmt.User"%>
<%@page import="com.lwr.software.reporter.admin.usermgmt.UserManager"%>
<%@page import="com.lwr.software.reporter.security.UserSecurityContext"%>
<%@page import="com.lwr.software.reporter.DashboardConstants"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp" %>
<%
	String chartType = DashboardConstants.HTML_JFREE;
	if(user != null){
		chartType = user.getChartType();
	}
	String userName = request.getParameter("userName");
	request.getSession().setAttribute("userName", userName);
	Report report = ReportManager.getReportManager().getReport(name,userName);
	String html="";
	if(report == null){
		html="No Such Report "+name;		
	}
%>
<section id="mainsection">
	<div id="reporttitle_div">
		<ul class="list-group">
			<li class="list-group-item" style="padding:0px">
			<h4 style="padding-left:10px;"><%=report.getTitle()%></h4>
			<span class="reportdescr" style="color:blue;padding-left:10px"><%=report.getDescription()%></span>	
			</li>
		</ul>
	</div>
	<div id="reportmain_div">
	<%
		int rows = report.getmaxrows();
		int rowHeight = 85/rows;
		for(int i=0;i<rows;i++){
			RowElement row = report.getRows().get(i);
			%>
				<div id="divrow_<%=i%>" style="height:<%=rowHeight%>% !important;overflow:auto">
					<%
						List<Element> elements = row.getElements();
						int colIndex = 0;
						int rowIndex = 0;
						if(elements==null || elements.isEmpty())
							continue;
						int cols = elements.size();
						int colWidth = 99/cols;
						for (Element element : elements) {
							String position = i + "_" + rowIndex + "_" + colIndex + "_cell";
							element.setPosition(position);
								String divId = "pos_"+element.getPosition();
							%>
							<div class="divchart" id="<%=divId%>" style="float:left;height:90%;width:<%=colWidth%>%" onclick="refreshElement(this,'<%=report.getTitle()%>','<%=element.getTitle()%>',<%=user.getRefreshInterval()%>,'<%=userName%>','<%=element.getChartType() %>')">
								<script>
									$("+divId+").load(loadElement(<%=divId%>,'<%=report.getTitle()%>','<%=element.getTitle()%>','<%=userName%>','<%=element.getChartType() %>'));
								</script>
							</div>										
							<%
							colIndex++;
							element.clear();
						}
					%>
				</div>
				<%
				}
			%>
	</div>
</section>
<%@ include file="footer.jsp" %>