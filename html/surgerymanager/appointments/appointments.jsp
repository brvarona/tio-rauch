
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@ include file="/html/surgerymanager/init.jsp" %>


<liferay-util:include page="/html/surgerymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="40" />
</liferay-util:include>

<%
SurgeryModel surgery = SurgeryUtil.buildByUser(themeDisplay.getUserId());
%>

<div class="messagesContainer">
	<liferay-ui:success key="Appoiment-canceled-successfully" message="Appointment cancelled" />
	<liferay-ui:success key="notification-sent-key" message="notification-sent-msg" />
	<liferay-ui:error key="unexpected-error" message="unexpected-error-msg" />
</div>


<span style="display: none;" class="loadingPopup" id="loadingAttendantsContent"> Loading...</span>

<%@ include file="/html/surgerymanager/appointments/appToBeReviewed.jsp" %>

<%-- <%@ include file="/html/surgerymanager/appointments/nextAppointments.jsp" %> --%>

<h3>Future Appointments</h3>
<portlet:resourceURL id="filterScheduleApps" var="filterScheduleAppsURL" />
<form action="#" method="post" name="appBySurgeryFilterFm" id="appBySurgeryFilterFm" class="form-search" onsubmit="javascript:return filterScheduleApps('<%= filterScheduleAppsURL.toString() %>', 'scheduleAppsBoxId');">
	<select name="<portlet:namespace/>appFilterId">
		<option value="-1">All</option>
		<option value="0">Clinic Only</option>
		<optgroup label="Individuals">
			<c:forEach items="<%=surgery.getIndividualsAttendants() %>" var="individual">
				<option "${sessionScope.appFilterId eq individual.id ? 'selected=selected' : ''}" value="${individual.id}">${individual.fullName}</option>
			</c:forEach>
		</optgroup>
	</select>
	<button name="filterAppsButton" type="submit" class="btn btn-default">Filter</button>
</form>

<div class="loading-text-container">
	<div class="" id="scheduleAppsBoxId-loading-box">
		<div class="loading-text">Loading...</div>
	</div>
</div>
	<liferay-portlet:resourceURL id="showBlockForm" var="showBlockFormURL" />
	<c:set value="<%=showBlockFormURL.toString() %>" var="showBlockFormURL" scope="session" />

	<portlet:resourceURL id="submitBlockForm" var="submitBlockFormURL" />
	<c:set value="<%=submitBlockFormURL.toString() %>" var="submitBlockFormURL" scope="session" />

	<portlet:resourceURL id="showEditAttendants" var="showEditAttendantsURL" />
	<c:set value="<%=showEditAttendantsURL.toString() %>" var="showEditAttendantsURL" scope="session" />

	<portlet:resourceURL id="confirmAppointmentWithoutDoctors" var="confirmAppointmentWithoutDoctorsURL" />
	<c:set value="<%=confirmAppointmentWithoutDoctorsURL.toString() %>" var="confirmAppointmentWithoutDoctorsURL" scope="session" />

	<portlet:resourceURL id="editAttendantsAndConfirmApp" var="editAttendantsAndConfirmAppURL" />
	<c:set value="<%=editAttendantsAndConfirmAppURL.toString() %>" var="editAttendantsAndConfirmAppURL" scope="session" />

	<portlet:resourceURL id="showDrugRepresentativeInfo" var="showDrugRepresentativeInfoURL" />
	<c:set value="<%=showDrugRepresentativeInfoURL.toString() %>" var="showDrugRepresentativeInfoURL" scope="session" />

	<portlet:resourceURL id="cancelApp" var="cancelAppURL" />
	<c:set value="<%=cancelAppURL.toString() %>" var="cancelAppURL" scope="session" />
	
	<portlet:resourceURL id="cancelAppAndNotify" var="cancelAppAndNotifyURL" />
	<c:set value="<%=cancelAppAndNotifyURL.toString() %>" var="cancelAppAndNotifyURL" scope="session" />
	
	<portlet:resourceURL id="showCancelAppForm" var="showCancelAppFormURL" />
	<c:set value="<%=showCancelAppFormURL.toString() %>" var="showCancelAppFormURL" scope="session" />

	<portlet:resourceURL id="resendBPNotification" var="resendBPNotificationURL" />
	<c:set value="<%=resendBPNotificationURL.toString() %>" var="resendBPNotificationURL" scope="session" />
<div id="scheduleAppsBoxId">
	<%@ include file="/html/surgerymanager/appointments/scheduleApps.jsp" %>
</div>

<div class="yui3-skin-sam">
    <div id="modal"></div>
</div>

<div id="bb">
	<div id="cb">
	</div>
</div>

<liferay-portlet:resourceURL id="filterScheduleApps" var="initScheduleAppsURL" />
<liferay-portlet:resourceURL id="showReloadScheduleForm" var="showReloadScheduleFormURL" />
<script>
YUI().ready('aui-io-request', function(A) {
	selectPage(1, 0, 10, '<%=initScheduleAppsURL.toString() %>', 'scheduleAppsBoxId');
	setTimeout(function() {
		showReloadScheduleForm('<%=showReloadScheduleFormURL.toString() %>');
	}, 10000);
	
	
});
</script>