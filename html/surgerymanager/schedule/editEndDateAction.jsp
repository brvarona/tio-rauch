
<%@page import="com.rxtro.core.model.view.ScheduleView"%>
<%@ include file="/html/surgerymanager/init.jsp" %>
<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	ScheduleView schedule = (ScheduleView) row.getObject();
	String endDateLinkId = "endDateId" + row.getRowId();
	String limitDate = (String) row.getParameter("limitDate");
	String endDate = schedule.getEndDate() != null ? schedule.getEndDate() : "";
	
%>

<liferay-ui:icon-menu showWhenSingleIcon="true">
	<%if (schedule.getEndDate() != null) { %>
		<a href="javascript:void(0);" id="<%=endDateLinkId %>" title="Edit the end date"><%=schedule.getEndDate()%></a>
	<%} else { %>
		<a href="javascript:void(0);" id="<%=endDateLinkId %>" title="Edit the end date">Set</a>
	<%} %>
</liferay-ui:icon-menu>


<portlet:resourceURL id="showEditEndDateForm" var="showEditEndDateFormURL" />
<portlet:resourceURL id="editEndDate" var="editEndDateURL" />
<script type="text/javascript" charset="utf-8">
var editEndDateButton = document.getElementById('<%=endDateLinkId %>');
addEvent('click', editEndDateButton, function() {
	showEditEndDateForm('<%= showEditEndDateFormURL.toString() %>', '<%= editEndDateURL.toString() %>', '<%=schedule.getScheduleId() %>', '<%=limitDate %>', '<%=endDateLinkId %>');
});
</script>