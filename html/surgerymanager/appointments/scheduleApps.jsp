<%@page import="com.liferay.portal.service.UserLocalServiceUtil" %>
<%@page import="com.rxtro.core.util.enums.AppointmentStatus" %>

<%@ include file="/html/surgerymanager/init.jsp" %>
<%@include file="/html/territorymanager/config.jsp" %>


<portlet:resourceURL id="cancelApp" var="cancelAppURL2" />
<portlet:resourceURL id="removeBlockOutDate" var="removeBlockOutDateURL" />


<c:set value="${fn:length(scheduleAppsResults)}" var="scheduleAppsTotal" />
<c:set value="<%= AppointmentStatus.APP_STATE_BLOQUED.getLabel() %>" var="blocked" />
<table class="table table-bordered table-hover table-striped" >
	<thead class="table-columns">
		<tr>
			<th class="table-first-header">Drug Representative</th>
			<th>With</th>
			<th>First Line Products</th>
			<th>Date Time</th>
			<th>Status</th>
			<%
			if (permissionChecker.isOmniadmin() || isTestEnv) {
			%>
				<th>App. Time Id</th>
				<th>Time Left</th>
			<% } %>
			<th class="table-last-header"></th>
		</tr>
	</thead>
	<tbody class="table-data">
		<c:forEach items="${scheduleAppsResults}" var="r" varStatus="s">		
			<%
				String colorRow = "";
			%>
			<c:if test="${r.status eq blocked}">
			<%
				colorRow = "rowTextItalicColorGrey";
			%>
			</c:if>
		
			<tr id="appSchRowId${s.index}">
				<td title="Drug Representative" class="<%=colorRow %>">${r.withDrugRep}</td>
				<td title="With" class="<%=colorRow %>">${r.withSurgery}</td>
				<td title="First Line Products" class="<%=colorRow %>">${r.firstLineProducts}</td>
				<td title="Date Time" class="<%=colorRow %>">${r.when}</td>
				<td title="Status" id="appSatus${s.index}" class="<%=colorRow %>">${r.status}</td>
				<%
				if (permissionChecker.isOmniadmin() || isTestEnv) {
				%>
					<td title="App. Time Id" class="<%=colorRow %>">
						${r.appTimeId}
					</td>
					<td title="Time Left" class="<%=colorRow %>">
						${r.timeLeft}
					</td>
				<% } %>
				<td title="actions" class="table-cell last">
					<liferay-ui:icon-menu>
						<c:set value="<%=permissionChecker.isOmniadmin() || UserLocalServiceUtil.hasRoleUser(12802, realUser.getUserId()) %>" var="isManageSomeFunctionRole" />
						<c:if test="${r.showResendBPNotification && isManageSomeFunctionRole}">
							<liferay-ui:icon image="refresh" src="/drugrep-portlet/html/icons/refresh.png" message="Resend BP Notification" onClick="resendBPNotification('${resendBPNotificationURL}', ${r.id}, 'scheduleAppsBoxId')" url="javascript:;" />
						</c:if>
						
						<c:if test="${r.showViewInfo}">
							<liferay-ui:icon image="coworker" src="/drugrep-portlet/html/icons/coworker.png" message="View Info" onClick="showDrugRepresentativeInfo(${r.drugRepId}, '${showDrugRepresentativeInfoURL}', '${r.drugRepFullName}')" url="javascript:;" />
						</c:if>
				
						<c:if test="${r.showCancel}">
							<liferay-ui:icon image="delete" message="Cancel Appointment" onClick="showCancelAppForm('${showCancelAppFormURL}', '${cancelAppURL}', ${r.id}, ${r.surgeryId},'scheduleAppsBoxId', 'reloadPaginatorscheduleAppsBoxId')" url="javascript:;" />
						</c:if>
						
						<c:if test="${r.showCancelAndNotify}">
							<liferay-ui:icon image="delete" message="Cancel and Notify other Reps" onClick="showCancelAppForm('${showCancelAppFormURL}', '${cancelAppAndNotifyURL}', ${r.id}, ${r.surgeryId},'scheduleAppsBoxId', 'reloadPaginatorscheduleAppsBoxId')" url="javascript:;" />
						</c:if>
						
						<c:if test="${r.showConfirm}">
							<liferay-ui:icon id="confirmIcon${r.id}" image="checked" message="Confirm Appointment" onClick="confirmAppointmentWithoutDoctors('${confirmAppointmentWithoutDoctorsURL}', ${r.id}, 'reloadPaginatorscheduleAppsBoxId')" url="javascript:;"  />
				
							<c:if test="${r.showConfirmWithDoctor}">
								<liferay-ui:icon id="confirmDocsIcon${r.id}" image="team_icon" message="Confirm Appointment and Doctors" onClick="showEditAttendantsForm(${r.scheduleId}, ${r.surgeryId}, '${showEditAttendantsURL}', '${editAttendantsAndConfirmAppURL}', ${r.id}, 'reloadPaginatorscheduleAppsBoxId')" url="javascript:;"  />
							</c:if>
						</c:if>

						<c:if test="${r.showBlock}">
							<liferay-ui:icon image="" message="Click here if you wish to block this date" onClick="showBlockForm('${showBlockFormURL}', '${submitBlockFormURL}', ${r.appTime}, ${r.surgeryId}, ${r.individualId}, 'reloadPaginatorscheduleAppsBoxId')" url="javascript:;" />
						</c:if>
						
						<c:if test="${r.showUnblock}">
							<liferay-ui:icon image="" message="Click here if you wish to unblock this date" onClick="removeBlockOutDateFromFutureAppsView('${removeBlockOutDateURL}', '${r.blockOutDateId}', ${r.individualId}, 'reloadPaginatorscheduleAppsBoxId')" url="javascript:;" />
						</c:if>
					</liferay-ui:icon-menu>
					
				</td>
			</tr>
		</c:forEach>
		
		<c:if test="${scheduleAppsTotal < 10}">
			<c:forEach begin="${scheduleAppsTotal}" end="9" >
				<tr>
					<td class="table-cell">${' '}</td>
					<td class="table-cell">${' '}</td>
					<td class="table-cell">${' '}</td>
					<td class="table-cell">${' '}</td>
					<td class="table-cell">${' '}</td>
					<%
					if (permissionChecker.isOmniadmin() || isTestEnv) {
					%>
						<td class="table-cell">${' '}</td>
						<td class="table-cell">${' '}</td>
					<% } %>
					<td class="table-cell last">${'-'}</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>

<liferay-portlet:resourceURL id="filterScheduleApps" var="nextFilterScheduleAppsURL">
	<liferay-portlet:param name="appFilterId" value="${appFilterId}"/>
</liferay-portlet:resourceURL>
<liferay-util:include page="/html/surgerymanager/appointments/paginator.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="total" value="${resultTotal}" />
	<liferay-util:param name="baseUrl" value="<%=nextFilterScheduleAppsURL.toString() %>" />
	<liferay-util:param name="boxId" value="scheduleAppsBoxId" />
</liferay-util:include>

<style>
.rowTextItalicColorGrey {
    color: #aaa;
    font-style: italic;
}
</style>