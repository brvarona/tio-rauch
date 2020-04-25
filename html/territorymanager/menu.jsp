<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@include file="/html/territorymanager/init.jsp" %>
<%@include file="/html/territorymanager/global.jsp" %>

<portlet:renderURL var="viewMyTerritoryURL">
	<portlet:param name="jspPage" value="/html/territorymanager/territory/drugRepTerritory.jsp" />
</portlet:renderURL>
<portlet:actionURL var="viewAvailableTerritoriesURL" name="showAvailableTerritories" />
<portlet:renderURL var="viewMyAppoimentesURL">
	<portlet:param name="jspPage" value="/html/territorymanager/appointments/myAppoiments.jsp" />
</portlet:renderURL>
<portlet:renderURL var="viewMyColleaguesAppoimentesURL">
	<portlet:param name="jspPage" value="/html/territorymanager/appointments/myColleaguesAppoiments.jsp" />
</portlet:renderURL>
<portlet:renderURL var="viewMyPreviousAppointmentsURL">
	<portlet:param name="jspPage" value="/html/territorymanager/appointments/history.jsp" />
</portlet:renderURL>
<portlet:actionURL name="showChangeCompanyForm" var="showChangeCompanyFormURL" />
<portlet:actionURL name="showMyApps" var="showMyAppsURL" />

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
	<c:when test="${param.menuId == 60}">
		<c:set var="active60" value="active" />
	</c:when>
</c:choose>

<ul class="nav nav-pills">
	<li role="presentation" class="${active10}">
		<a href="<%= viewMyTerritoryURL.toString() %>" id="menuSelectedA">My Territory and New Appointments</a>
	</li>
	<li role="presentation" class="${active20}">
		<a href="<%= viewAvailableTerritoriesURL.toString() %>" id="menuSelectedB">Add clinics to My Territory</a>
	</li>
	<li role="presentation" class="${active30}">
		<a href="<%= showMyAppsURL.toString() %>" id="menuSelectedC">My Existing Appointments</a>
	</li>
	<%if (drugRep != null && drugRep.getTeam() != null && drugRep.getTeam().isPremium() && false) { %>
		<li role="presentation" class="${active40}">
			<a href="<%= viewMyColleaguesAppoimentesURL.toString() %>" id="menuSelectedD">My Colleagues Appointments</a>
		</li>
	<%} %>
	<li role="presentation" class="${active50}">
		<a href="<%= viewMyPreviousAppointmentsURL.toString() %>" id="menuSelectedE">Previous Appointments</a>
	</li>
	<li role="presentation" class="${active60}">
		<a href="<%= showChangeCompanyFormURL.toString() %>" id="menuSelectedF">Change Products, Company and Team</a>
	</li>
</ul>
