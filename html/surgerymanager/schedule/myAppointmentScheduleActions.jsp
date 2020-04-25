
<%@page import="com.rxtro.core.model.view.ScheduleView"%>
<%@page import="com.liferay.portal.service.UserLocalServiceUtil"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	ScheduleView schedule = (ScheduleView) row.getObject();

	String showEditAttendantsLinkId = "editAttendants" + String.valueOf(schedule.getScheduleId());
	String deleteScheduleLinkId = "deleteSchedule" + row.getRowId();
	String changeScheduleLinkId = "changeSchedule" + String.valueOf(schedule.getScheduleId());
	String rowId = "schRowId"+row.getRowId();
%>

<liferay-ui:icon-menu showWhenSingleIcon="true" id="<%=rowId %>">

	<liferay-ui:icon id="<%= deleteScheduleLinkId %>" image="delete" message="Delete Appointment Time" url="javascript:void(0);" />
	
	<%if (!schedule.isIndividual()) { %>
		<liferay-ui:icon id="<%= showEditAttendantsLinkId %>" image="edit" message="Edit Attendants" url="javascript:void(0);"  />
	<%} %>

	<liferay-ui:icon id="<%= changeScheduleLinkId %>" image="edit" message="Change Appointment Time" url="javascript:void(0);" />

</liferay-ui:icon-menu>
<%if (!schedule.isIndividual()) { %>
	<portlet:resourceURL id="showEditAttendants" var="showEditAttendantsURL" />
	<portlet:resourceURL id="editAttendants" var="editAttendantsURL" />
	<script>
		var showEditAttendantsButton = document.getElementById('<portlet:namespace /><%= showEditAttendantsLinkId %>');
		addEvent('click', showEditAttendantsButton, function() {
			showEditAttendantsForm('<%= schedule.getScheduleId() %>', '<%= schedule.getSurgeryId() %>', '<%= showEditAttendantsURL.toString() %>', '<%= editAttendantsURL.toString() %>', null);
		});
	</script>
<%} %>
<portlet:resourceURL id="deleteSchedule" var="deleteScheduleURL" />
<portlet:resourceURL id="showChangeScheduleForm" var="showChangeScheduleFormURL" />
<portlet:resourceURL id="changeSchedule" var="changeScheduleURL" />
<script type="text/javascript">
var deleteScheduleButton = document.getElementById('<portlet:namespace /><%=deleteScheduleLinkId%>');
if (deleteScheduleButton != null) {
	addEvent('click', deleteScheduleButton, function() {
		deleteSchedule('<%=deleteScheduleURL.toString() %>', '<%= String.valueOf(schedule.getScheduleId()) %>', '<portlet:namespace /><%=rowId %>');
	});
}

var changeScheduleButton = document.getElementById('<portlet:namespace /><%=changeScheduleLinkId%>');
if (changeScheduleButton != null) {
	addEvent('click', changeScheduleButton, function() {
		showChangeScheduleForm('<%=showChangeScheduleFormURL.toString() %>', '<%=changeScheduleURL.toString() %>', '<%= String.valueOf(schedule.getScheduleId()) %>', '<portlet:namespace /><%=rowId %>');
	});
}
</script>
