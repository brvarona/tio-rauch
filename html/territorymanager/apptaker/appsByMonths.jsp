<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.util.ScheduleUtil"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.model.TeamModel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%@include file="/html/territorymanager/init.jsp" %>
<%@include file="/html/territorymanager/global.jsp" %>

<%@include file="/html/territorymanager/config.jsp" %>

<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.rxtro.core.model.MedicalStaff"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Locale" %>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.util.enums.AppointmentType"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@ page import="com.segmax.drugrep.model.Doctor" %>
<%@ page import="com.segmax.drugrep.service.DoctorLocalServiceUtil" %>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
</liferay-util:include>

<%@include file="/html/territorymanager/territory/territoryMenu.jsp" %>

<liferay-portlet:actionURL var="showAvailableAppsURL" name="showAvailableApps" />

<%
Integer month = (Integer) session.getAttribute("month");

Integer year = (Integer) session.getAttribute("year");

Long idSuburb = (Long) session.getAttribute("suburbId");

Long territoryId = (Long) session.getAttribute("territoryId");

DrugRepModel currentRep = DrugRepUtil.buildByUser(themeDisplay.getUser());
TeamModel team = currentRep.getTeam();

//Map<Long,String> assistance = new HashMap<Long,String>();

%>

<h2 id="newAppTitle">New Appointments</h2>

<p>
	You will only see available appointments for clinics that you have made part of your territory
</p>

<div id="myTab">
	<ul class="nav nav-tabs">
	<%
	Calendar calendar = Calendar.getInstance();
	Date earlySurgeryDate = DrugRepUtil.getEarlierSurgeryTime(drugRep.getId());
	if (earlySurgeryDate != null) {
		calendar.setTime(earlySurgeryDate);
	}
	for (int i=0; i<=11; i++) {
		String monthLabel = calendar.getDisplayName(Calendar.MONTH, Calendar.SHORT, Locale.ENGLISH) + " " + calendar.get(Calendar.YEAR);
		String tabClassName = month != null && month == calendar.get(Calendar.MONTH) && year != null && year == calendar.get(Calendar.YEAR) ? "active" : "";
	%>
		<li class="<%=tabClassName %>">
			<portlet:actionURL name="showMonthAppointment" var="showMonthAppointmentURL">
				<portlet:param name="month" value="<%= String.valueOf(calendar.get(Calendar.MONTH)) %>"></portlet:param>
				<portlet:param name="year" value="<%= String.valueOf(calendar.get(Calendar.YEAR)) %>"></portlet:param>
				<% if (territoryId != null) {%>
					<portlet:param name="territoryId" value="<%=territoryId.toString() %>"></portlet:param>
				<%} %>
			</portlet:actionURL>
			<a href="<%=showMonthAppointmentURL.toString() %>"><%=monthLabel %></a>
		</li>
	<%
		calendar.add(Calendar.MONTH, 1);
	}
	%>
	</ul>
</div>

<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/territorymanager/apptaker/appsByMonths.jsp");
%>

<div class="tab-content">
	<liferay-ui:search-container delta="30" emptyResultsMessage="There are no appointments available on your territory for this month. Please try another month" iteratorURL="<%= iteratorURL %>" orderByCol="Date">
		<liferay-ui:search-container-results>
		<%
			List<AppModel> appTimes = (List<AppModel>) session.getAttribute("appTimes");
			results = ListUtil.subList(appTimes, searchContainer.getStart(), searchContainer.getEnd());
			total = appTimes.size();
	
			pageContext.setAttribute("results", results);
			pageContext.setAttribute("total", total);
		%>
		</liferay-ui:search-container-results>
		<liferay-ui:search-container-row
			className="com.rxtro.core.model.AppModel"
			keyProperty="id"
			modelVar="app">
			<%
				StringBuilder withDesc = new StringBuilder();

 					withDesc.append("(");
					withDesc.append(app.getSurgery().getAddress().getCity());
					withDesc.append("), ");
					withDesc.append(app.getSurgery().getName());
					if (app.isIndividual()) {
						withDesc.append(" - ");
						if (app.getAttendants() != null && !app.getAttendants().isEmpty()) {
							withDesc.append(app.getAttendants().get(0).getFullName());
						} else {
							withDesc.append("No Attendant");
						}
					}
					withDesc.append(", ");
					withDesc.append(app.getSurgery().getAddress().getStreet1());
					withDesc.append(" ");
					withDesc.append(app.getSurgery().getAddress().getStreet2());
					withDesc.append(" ");
					withDesc.append(app.getSurgery().getAddress().getStreet3());
			%>
			
			<liferay-ui:search-container-column-text 
				name="When" 
				value="<%= FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM) %>" 
			/>
			<liferay-ui:search-container-column-text 
				name="With"
				value="<%= withDesc.toString() %>"
			/>
			
			<%
				if (permissionChecker.isOmniadmin() || isTestEnv) {
			%>
					<liferay-ui:search-container-column-text name="Clinic Time" value="<%= app.getSurgery().getCurrentTimeStr(FormatDateUtil.PATTERN_YYYY_MM_DD_HH_MM) %>" />
			<% } %>
			<liferay-ui:search-container-column-jsp align="right" path="/html/territorymanager/apptaker/appsByMonthsAction.jsp" />
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</div>
