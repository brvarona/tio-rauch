
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<%@include file="/html/territorymanager/config.jsp" %>

<portlet:renderURL var="viewMyMedicalStaffURL">
	<portlet:param name="jspPage" value="/html/surgerymanager/medicalstaff/myMedicalStaff.jsp" />
</portlet:renderURL>
<portlet:actionURL name="viewAddMedicalStaff" var="viewAddMedicalStaffURL" />
<portlet:actionURL name="viewSchedule" var="viewMyScheduleURL" />
<portlet:renderURL var="viewFutureAppsURL">
	<portlet:param name="jspPage" value="/html/surgerymanager/appointments/appointments.jsp" />
</portlet:renderURL>
<portlet:renderURL var="viewHistoryURL">
	<portlet:param name="jspPage" value="/html/surgerymanager/appointments/history.jsp" />
</portlet:renderURL>


<c:choose>
	<c:when test="${param.menuId == 10}">
		<c:set var="active10" value="active" />
	</c:when>
	<c:when test="${param.menuId == 20}">
		<c:set var="active20" value="active" />
	</c:when>
	<c:when test="${param.menuId == 30}">
		<c:set var="active30" value="active" />
	</c:when>
	<c:when test="${param.menuId == 40}">
		<c:set var="active40" value="active" />
	</c:when>
	<c:when test="${param.menuId == 50}">
		<c:set var="active50" value="active" />
	</c:when>
</c:choose>

<ul class="nav nav-pills">
	<li role="presentation" class="${active10}">
		<a href="<%= viewMyMedicalStaffURL.toString() %>" id="menuSelectedA">My Medical Staff</a>
	</li>
<%-- 	<li role="presentation" class="${active20}"> --%>
<%-- 		<a href="<%= viewAddMedicalStaffURL.toString() %>" id="menuSelectedB">Add Medical Staff</a> --%>
<!-- 	</li> -->
	<li role="presentation" class="${active30}">
		<a href="<%= viewMyScheduleURL.toString() %>" id="menuSelectedC">Clinic Appointment Times</a>
	</li>
	<li role="presentation" class="${active40}">
		<a href="<%= viewFutureAppsURL.toString() %>" id="menuSelectedD">Future Appointments</a>
	</li>
	<li role="presentation" class="${active50}">
		<a href="<%= viewHistoryURL.toString() %>" id="menuSelectedE">Previous Appointments</a>
	</li>
</ul>


<div id="surgeryInfoId"></div>


<portlet:resourceURL id="refreshSurgeryInfo" var="refreshSurgeryInfoURL" />
<script>
YUI().ready('aui-io-request', function(A) {
	setInterval(function(){
		refreshSurgeryInfo('surgeryInfoId','<%=refreshSurgeryInfoURL.toString() %>');
	}, 90000);
	refreshSurgeryInfo('surgeryInfoId','<%=refreshSurgeryInfoURL.toString() %>');
});
</script>
