<%@page import="com.liferay.portal.service.UserLocalServiceUtil"%>
<%@page import="com.rxtro.core.util.enums.AppointmentStatus"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	AppModel appointment = (AppModel) row.getObject();
	
	String showEditAttendantsLinkId = "editAttendants" + String.valueOf(appointment.getAppDate().getTime());
	String menuEditAttendants = "menu" + showEditAttendantsLinkId;
	String showDrugRepresentativeInfoId = "showDrugRepresentativeInfoId" + String.valueOf(appointment.getDrugRepId());
	String showBlockFormId = "showBlockForm" + String.valueOf(row.getRowId());
	boolean showViewInfo = false;
	boolean showCancel = false;
	boolean showConfirm = false;
	boolean showConfirmWithDoctor = false;
	boolean showBlock = false;
	
	if (AppointmentStatus.APP_STATE_VACANT.equals(appointment.getStatus())) {
		showBlock = true;
	}
	
	if (!AppointmentStatus.APP_STATE_VACANT.equals(appointment.getStatus()) && !AppointmentStatus.APP_STATE_BLOQUED.equals(appointment.getStatus())) {
		showViewInfo = true;
	}
	
	if (AppointmentStatus.APP_STATE_PENDING_CONFIRMATION.equals(appointment.getStatus()) || AppointmentStatus.APP_STATE_NOTIFIED.equals(appointment.getStatus())) {
		showCancel = true;
	}
	
	if ((AppointmentStatus.APP_STATE_PENDING_CONFIRMATION.equals(appointment.getStatus()) || AppointmentStatus.APP_STATE_NOTIFIED.equals(appointment.getStatus()))
		&& (appointment.isOnSurgeryManualConfirmationTime())){
		showConfirm = true;
	}
	
	if (!appointment.isIndividual()) {
		showConfirmWithDoctor = true;
	}
	
	
	boolean showResendBPNotification = appointment.getId() != null && appointment.getId() > 0 && (permissionChecker.isOmniadmin() || UserLocalServiceUtil.hasRoleUser(12802, realUser.getUserId()));
	
	%>

	<span id="<%= menuEditAttendants %>"></span>
	<liferay-ui:icon-menu>
		<c:if test="<%= showResendBPNotification %>">
			<portlet:actionURL name="resendBPNotification" var="resendBPNotificationURL">
					<portlet:param name="appId" value="<%= appointment.getId().toString() %>"></portlet:param>
			</portlet:actionURL>
			<liferay-ui:icon image="message" message="Resend BP Notification" url="<%= resendBPNotificationURL.toString() %>" />
		</c:if>
		
		<c:if test="<%=showViewInfo %>">
			<liferay-ui:icon id="<%= showDrugRepresentativeInfoId %>" image="page" message="View Info" url="javascript:;" />
		</c:if>

		<c:if test="<%= showCancel %>">
			<portlet:actionURL name="cancelAppoiment" var="cancelAppoimentURL">
				<portlet:param name="resourcePrimKey" value="<%= appointment.getId().toString() %>"></portlet:param>
			</portlet:actionURL>
			<liferay-ui:icon image="delete" message="Cancel Appointment" url="<%= cancelAppoimentURL.toString() %>" />
		</c:if>

		<c:if test="<%= showConfirm %>">
			<portlet:actionURL name="confirmAppointmentWithoutDoctors" var="confirmAppoimtentURL">
				<portlet:param name="appointment" value="<%= appointment.getId().toString() %>"></portlet:param>
			</portlet:actionURL>
			<liferay-ui:icon image="checked" message="Confirm Appointment" url="<%= confirmAppoimtentURL.toString() %>"  />

			<c:if test="<%=showConfirmWithDoctor %>">
				<liferay-ui:icon id="<%= showEditAttendantsLinkId %>" image="team_icon" message="Confirm Appointment and Doctors" url="javascript:;"  />
			</c:if>
		</c:if>
		<c:if test="<%= showBlock %>">
			<liferay-ui:icon id="<%= showBlockFormId %>" image="view" message="Block" url="javascript:;" />
		</c:if>
</liferay-ui:icon-menu>

<%if (showConfirmWithDoctor) { %>
	<portlet:resourceURL id="showEditAttendants" var="showEditAttendantsURL" />
	<portlet:resourceURL id="editAttendantsAndClose" var="editAttendantsAndCloseURL" />
	<script>
		var showEditAttendantsButton = document.getElementById('<portlet:namespace /><%= showEditAttendantsLinkId %>');
		if (showEditAttendantsButton != null) {
			addEvent('click', showEditAttendantsButton, function() {
				showEditAttendantsForm('<%= appointment.getSchedule().getId() %>', '<%= appointment.getSurgeryId() %>', 
						'<%= showEditAttendantsURL.toString() %>', '<%= editAttendantsAndCloseURL.toString() %>', '<%= appointment.getId() %>');
			});
		}
	</script>
<%} %>

<c:if test="<%=showViewInfo %>">
	<portlet:resourceURL id="showDrugRepresentativeInfo" var="showDrugRepresentativeInfoURL" />
	<script>
	var showDrugRepresentativeInfoButton = document.getElementById('<portlet:namespace /><%= showDrugRepresentativeInfoId %>');
	if (showDrugRepresentativeInfoButton != null) {
		addEvent('click', showDrugRepresentativeInfoButton, function() {
			showDrugRepresentativeInfo('<%=appointment.getDrugRepId() %>', '<%= showDrugRepresentativeInfoURL.toString() %>', "<%=appointment.getDrugRep().getFullName() %>");
		});
	}
	</script>
</c:if>

<c:if test="<%= showBlock %>">
	<portlet:resourceURL id="showBlockForm" var="showBlockFormURL" />
	<portlet:resourceURL id="submitBlockForm" var="submitBlockFormURL" />
	<script>
	var showBlockFormButton = document.getElementById('<portlet:namespace /><%= showBlockFormId %>');
	if (showBlockFormButton != null) {
		addEvent('click', showBlockFormButton, function() {
			showBlockForm('<%= showBlockFormURL.toString() %>', '<%= submitBlockFormURL.toString() %>', '<%=String.valueOf(appointment.getAppDate().getTime()) %>', '<%=showBlockFormId %>');
		});
	}
	</script>
</c:if>