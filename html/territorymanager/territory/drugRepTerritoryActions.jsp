<%@page import="com.rxtro.core.model.TeamModel"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.util.TeamUtil"%>
<%@page import="com.rxtro.core.model.TerritoryModel"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@include file="/html/territorymanager/init.jsp" %>
<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	TerritoryModel territory = (TerritoryModel) row.getObject();

	String showEditNotificationsLinkId = "editNotifications" + String.valueOf(territory.getId());
	String showViewMoreTerritoryInfoLinkId = "viewMoreTerritoryInfo" + String.valueOf(territory.getId());
	
	//TODO GET THE LOWEST CURRENT SURGERY DATE
	Calendar currentDate = Calendar.getInstance();
	
	Long drugRepId = (Long) row.getParameter("drugRepId");
	
	Long nextApp = (Long) row.getParameter("nextApp");
	
	TeamModel team = TeamUtil.getTeamByUserId(themeDisplay.getUserId());
	
	String removeSurgeryFromTerritoryLinkId = "removeSurgeryFromTerritoryLinkId" + row.getRowId();
	
	String myTerritoryRowId = "myTerritoryRowId" + row.getRowId();

	String appActionLabel = "Make Appointment";
	if (nextApp != null) {
		appActionLabel = "Swap Appointment";
	}
	
%>

<liferay-ui:icon-menu id="<%=myTerritoryRowId %>" >
	
	<liferay-ui:icon id="<%=removeSurgeryFromTerritoryLinkId %>" image="delete" message="Remove clinic from my territory" url="javascript:;" />
	
	<%if (team.isPremium()) { %>
	<liferay-ui:icon id="<%= showEditNotificationsLinkId %>" image="edit" message="Edit Notifications" url="javascript:;"  />
	<%} %>
		<%if (nextApp == null) { %>
			<portlet:actionURL var="showMakeAppScheduleURL" name="showMakeAppSchedule">
				<portlet:param name="territoryId" value="<%= territory.getId().toString() %>"></portlet:param>
			</portlet:actionURL>
			<liferay-ui:icon image="calendar" message="<%=appActionLabel %>" url="<%= showMakeAppScheduleURL.toString() %>" />
		<%} %>
		
		<%if (nextApp != null) { %>
			<portlet:actionURL var="showSwapAppScheduleURL" name="showSwapAppSchedule">
				<portlet:param name="appId" value="<%= nextApp.toString() %>"></portlet:param>
			</portlet:actionURL>
			<liferay-ui:icon image="calendar" message="<%=appActionLabel %>" url="<%= showSwapAppScheduleURL.toString() %>" />
		<%} %>
	<portlet:actionURL name="showMoreTerritoryInfo" var="showMoreTerritoryInfoURL">
		<portlet:param name="territoryId" value="<%= territory.getId().toString() %>"></portlet:param>
	</portlet:actionURL>
	<liferay-ui:icon image="page" message="View more info" url="<%= showMoreTerritoryInfoURL.toString() %>" />
</liferay-ui:icon-menu>

<portlet:resourceURL id="showEditNotifications" var="showEditNotificationsURL" />
<portlet:resourceURL id="editNotifications" var="editNotificationsURL" />
<portlet:resourceURL id="showMoreTerritoryInfo" var="showMoreTerritoryInfoURL" />
<portlet:resourceURL id="removeSurgeryFromTerritory" var="removeSurgeryFromTerritoryURL" />
<script>
	var showEditNotificationsButton = document.getElementById('<portlet:namespace /><%= showEditNotificationsLinkId %>');
	if (showEditNotificationsButton != null) {
		addEvent('click', showEditNotificationsButton, function() {
			showEditNotificationsForm('<%= territory.getId() %>', '<%= showEditNotificationsURL.toString() %>', '<%= editNotificationsURL.toString() %>');
		});
	}
	
	var removeSurgeryFromTerritoryButton = document.getElementById('<portlet:namespace /><%=removeSurgeryFromTerritoryLinkId %>');
	if (removeSurgeryFromTerritoryButton != null) {
		addEvent('click', removeSurgeryFromTerritoryButton, function() {
			removeSurgeryFromTerritory('<%=removeSurgeryFromTerritoryURL.toString() %>', '<%= territory.getId().toString() %>', '<portlet:namespace /><%=myTerritoryRowId %>');
		});
	}
</script>