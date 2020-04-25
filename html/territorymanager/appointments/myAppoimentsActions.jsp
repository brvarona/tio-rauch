<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.liferay.portal.service.OrganizationLocalServiceUtil"%>
<%@page import="com.rxtro.core.util.TeamUtil"%>
<%@page import="com.rxtro.core.util.enums.AppointmentStatus"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>

<%@ page import="java.util.concurrent.TimeUnit" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	AppModel app = (AppModel) row.getObject();
	//Long idAppoiment = app.getId_appoiment();
	//Long surgeryId = app.getId_surgery();

	boolean showConfirm = false;
	//si fue confirmado habilito el boton de confirmacion por drug rep
	if (app.getStatus().equals(AppointmentStatus.APP_STATE_CONFIRMED_BY_PM) || app.getStatus().equals(AppointmentStatus.APP_STATE_AUTO_CONFIRMED)) {
		showConfirm = true;
	}

	long diff = app.getAppDate().getTime() - app.getSurgery().getCurrentTime().getTime();
	long diffHours = TimeUnit.MILLISECONDS.toSeconds(diff);

	boolean showCancelAndSwap = true;
	if (app.getStatus().equals(AppointmentStatus.APP_STATE_CONFIRM_DR) || diffHours <= AppUtil.LIMIT_TIME_FOR_REP_CANCELATION) {
		showCancelAndSwap = false;
	}
	
	String showSelectDrugRepListLinkId = "showSelectDrugRepList" + app.getId();
	String showTransferAppToColleagueLinkId = "showTransferAppToColleague" + row.getRowId();
	String transferAppToManagerLinkId = "transferAppToManagerLinkId" + row.getRowId();
	String cancelAppLinkId = "cancelAppLinkId" + row.getRowId();
	
	String myAppsRowId = "myAppsRowId" + row.getRowId();
	
	boolean showTransferToColleague = app.getStatus().equals(AppointmentStatus.APP_STATE_PENDING_CONFIRMATION) && (app.getDrugRep().isPharmaRepCompany() || app.getDrugRep().isSpecialtyOrganisations()) && !app.getDrugRep().isManagerOfTeam();
	
%>

<liferay-ui:icon-menu id="<%=myAppsRowId %>" >
	<c:if test="<%= showConfirm %>">
		<portlet:actionURL name="confirmApp" var="confirmAppURL">
			<portlet:param name="appId" value="<%= String.valueOf(app.getId()) %>"></portlet:param>
		</portlet:actionURL>
		<liferay-ui:icon image="recent_changes" message="Confirm Appointment" url="<%= confirmAppURL.toString() %>" />
	</c:if>

	<portlet:actionURL name="viewMoreInfo" var="viewMoreInfoURL">
		<portlet:param name="idAppoiment" value="<%= String.valueOf(app.getId()) %>"></portlet:param>
		<portlet:param name="idSurgery" value="<%= String.valueOf(app.getSurgery().getId()) %>"></portlet:param>
	</portlet:actionURL>
	<liferay-ui:icon image="page" message="View more info" url="<%= viewMoreInfoURL.toString() %>" />

	<c:if test="<%= showCancelAndSwap %>">
		<liferay-ui:icon id="<%=cancelAppLinkId %>" image="delete" message="Cancel Appointment" url="javascript:;" />
	</c:if>
	
	<c:if test="<%=app.getStatus().equals(AppointmentStatus.APP_STATE_PENDING_CONFIRMATION) && app.getDrugRep().getTeam().isPremium() && app.getDrugRep().getManager() != null && app.getDrugRep().isTerritoryTarget(app.getTerritory().getTerritoryKey()) %>">
		<liferay-ui:icon id="<%=transferAppToManagerLinkId %>" image="post" message="Transfer to Manager" url="javascrpt:;" />
	</c:if>
	
	<c:if test="<%=showTransferToColleague %>">
		<liferay-ui:icon id="<%=showTransferAppToColleagueLinkId %>" image="post" message="Transfer to Colleague" url="javascript:;" />
	</c:if>
	
	<c:if test="<%=app.getDrugRep().isManagerOfTeam() %>">
		<liferay-ui:icon id="<%= showSelectDrugRepListLinkId %>" image="post" message="Transfer to Rep" url="javascript:;" />
	</c:if>
	
	<c:if test="<%= showCancelAndSwap %>">
		<portlet:actionURL var="showSwapAppScheduleURL" name="showSwapAppSchedule">
			<portlet:param name="appId" value="<%= String.valueOf(app.getId()) %>"></portlet:param>
		</portlet:actionURL>
		<liferay-ui:icon image="calendar" message="Swap Appointment" url="<%= showSwapAppScheduleURL.toString() %>" />
	</c:if>
	
	
</liferay-ui:icon-menu>

<portlet:resourceURL id="transferAppToRep" var="transferAppToRepURL" />
<portlet:resourceURL id="showMyTeamList" var="showMyTeamListURL" />
<portlet:resourceURL id="showTransferAppToColleagueForm" var="showTransferAppToColleagueFormURL" />
<portlet:resourceURL id="transferAppToColleague" var="transferAppToColleagueURL" />
<portlet:resourceURL id="cancelApp" var="cancelAppURL" />
<portlet:resourceURL id="transferAppToManager" var="transferAppToManagerURL" />

<script type="text/javascript">
var showSelectDrugRepListButton = document.getElementById('<portlet:namespace /><%= showSelectDrugRepListLinkId %>');
if (showSelectDrugRepListButton != null) {
	addEvent('click', showSelectDrugRepListButton, function() {
		showSelectDrugRepToTransferForm('<%= showMyTeamListURL.toString() %>', '<%=app.getId()%>', '<%= transferAppToRepURL.toString() %>', '<portlet:namespace /><%=myAppsRowId %>');
	});
}

var showTransferAppToColleagueButton = document.getElementById('<portlet:namespace /><%= showTransferAppToColleagueLinkId %>');
if (showTransferAppToColleagueButton != null) {
	addEvent('click', showTransferAppToColleagueButton, function() {
		showTransferAppToColleagueForm('<%=showTransferAppToColleagueFormURL.toString() %>', '<%=app.getId() %>', '<%=app.getDrugRepId() %>', '<%=app.getTerritory().getId() %>', '<%=transferAppToColleagueURL.toString() %>', '<portlet:namespace /><%= myAppsRowId %>');
	});
}

var cancelAppButton = document.getElementById('<portlet:namespace /><%=cancelAppLinkId%>');
if (cancelAppButton != null) {
	addEvent('click', cancelAppButton, function() {
		cancelApp('<%=cancelAppURL.toString()%>', '<%= app.getId().toString() %>', '<%= app.getSurgeryId().toString() %>', '<portlet:namespace /><%=myAppsRowId %>');
	});
}

var transferAppToManagerButton = document.getElementById('<portlet:namespace /><%=transferAppToManagerLinkId %>');
if (transferAppToManagerButton != null) {
	addEvent('click', transferAppToManagerButton, function() {
		transferAppToManager('<%=transferAppToManagerURL.toString() %>', '<%= String.valueOf(app.getId()) %>', '<portlet:namespace /><%=myAppsRowId %>');
	});
}


</script>

