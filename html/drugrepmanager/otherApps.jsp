
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@page import="com.rxtro.core.util.TeamUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.enums.AppointmentStatus"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@include file="/html/territorymanager/init.jsp" %>
<%@include file="/html/territorymanager/global.jsp" %>
<%@page import="com.rxtro.core.model.AppModel"%>

<%@ page import="java.util.List" %>

<%@ page import="javax.portlet.PortletURL" %>

<liferay-util:include page="/html/drugrepmanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="20" />
</liferay-util:include>

<h3>Other Apps</h3>

<portlet:renderURL var="futureAppointmentsUrl">
	<portlet:param name="jspPage" value="/html/drugrepmanager/futureAppointments.jsp" />
</portlet:renderURL>
<a href="<%=futureAppointmentsUrl.toString() %>" >Back</a>

<%
DrugRepModel currentRep = DrugRepUtil.buildByUser(themeDisplay.getUser());
Map<Long, Boolean> drugRepIds = DrugRepUtil.getDrugRepIdsByCompanyAsMap(currentRep.getTeam().getCompanyId());

Long individualId = (Long) request.getAttribute("individualId");
if (individualId == null && request.getParameter("individualId") != null) {
	individualId = Long.parseLong(request.getParameter("individualId"));
}

Long surgeryId = (Long) request.getAttribute("surgeryId");
if (surgeryId == null && request.getParameter("surgeryId") != null) {
	surgeryId = Long.parseLong(request.getParameter("surgeryId"));
}

Long companyId = (Long) request.getAttribute("companyId");
if (companyId == null && request.getParameter("companyId") != null) {
	companyId = Long.parseLong(request.getParameter("companyId"));
}

PortletURL iteratorURL = renderResponse.createRenderURL();
if (individualId != null) {
	iteratorURL.setParameter("individualId", String.valueOf(individualId));
}
if (surgeryId != null) {
	iteratorURL.setParameter("surgeryId", String.valueOf(surgeryId));
}
if (companyId != null) {
	iteratorURL.setParameter("companyId", String.valueOf(companyId));
}
iteratorURL.setParameter("jspPage", "/html/drugrepmanager/otherApps.jsp");

%>

<div class="earlyApps" id="earlyApps">
	<liferay-ui:search-container curParam="cur2" delta="30" emptyResultsMessage="No appointments" iteratorURL="<%= iteratorURL %>" orderByCol="Clinic">
		<liferay-ui:search-container-results>
			<%
				List<AppModel> apps;
				Long visitorId = TeamUtil.getVisitorId(currentRep);
				SurgeryModel surgery = SurgeryUtil.buildFromOrgId(surgeryId);
				Date from = surgery.getCurrentTime();
				Date to = null;
				Calendar currentTime = surgery.getCurrentTimeAsCal();
				currentTime.add(Calendar.YEAR, 1);
				currentTime.add(Calendar.DAY_OF_YEAR, -1);
				to = new Date(currentTime.getTimeInMillis());
				
				if (individualId != null) {
					//apps = AppUtil.getNextIndividualAppByCompanyAndTSurgery(companyId, surgeryId, individualId);
					
					int totalResult = AppUtil.countIndividualScheduleTimes(surgeryId, visitorId, individualId, from, to);
					apps = AppUtil.getIndividualScheduleTimes(surgeryId, visitorId, individualId, from, to, 0, totalResult);
				} else {
					//apps = AppUtil.getNextAppByCompanyAndTSurgery(companyId, surgeryId);
					
					int totalResult = AppUtil.countSurgeryScheduleTimes(surgeryId, visitorId, from, to);
					apps = AppUtil.getSurgeryScheduleTimes(surgeryId, visitorId, from, to, 0, totalResult);
				}
				
				results = ListUtil.subList(apps, searchContainer.getStart(), searchContainer.getEnd());
				total = apps.size();
	
				pageContext.setAttribute("results", results);
				pageContext.setAttribute("total", total);
			%>
	
		</liferay-ui:search-container-results>
		<liferay-ui:search-container-row
			className="com.rxtro.core.model.AppModel"
			keyProperty="id"
			modelVar="app">
			<%
				String type = app.getType().getLabel();
				Long idTarget;
				if (app.isIndividual()) {
					type = type + " ( "+app.getAttendants().get(0).getFullName()+" )";
				}
				String colorRow = "";
				String drugRepName = "";
				boolean canViewStatistics = true;
				
				if (app.getDrugRepId() != null) {
					//drugRepName = app.getDrugRep().getFullName() + " - " + app.getDrugRep().getTeam().getName();
					//colorRow = "rowColorBlue";
					
					if (app.getDrugRepId().equals(currentRep.getId())) { // CURRENT
						colorRow = "rowBKYellow";
						drugRepName = "";
					} else {
						if (drugRepIds.containsKey(app.getDrugRepId())) {
							colorRow = "rowColorBankAndBKBlue";
							drugRepName = app.getDrugRep().getFullName() + " - " + app.getDrugRep().getTeam().getName();
						} else {
							colorRow = "rowTextItalicColorGrey";
							drugRepName = "Other Representative Booked in";
							canViewStatistics = false;
						}
					}

					
				} else {
					//if (app.isBlockOutDate()) {
					//	if (app.isIndividual()) {
					//		drugRepName = "Doctor Not Available ";
					//	} else {
					//		drugRepName = "Clinic Not Available ";
					//	}
					//	colorRow = "rowColorGrey";
					//}
					
					if (app.isBlockOutDate()) { // BLOCKED
						if (app.isIndividual()) {
							drugRepName = "Doctor Not Available ";
						} else {
							drugRepName = "Clinic Not Available ";
							canViewStatistics = false;
						}
						colorRow = "rowTextItalicColorGrey";
					} else { // AVAILABLE
						colorRow = "";
						drugRepName = "";
					}
				}
				
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
				name="Rep" 
				value="<%= drugRepName %>" 
				cssClass="<%=colorRow %>"
			/>
			<liferay-ui:search-container-column-text 
				name="When" 
				value="<%= FormatDateUtil.format(app.getAppDate(), FormatDateUtil.PATTERN_EEEE_DD_MMMM_YYYY_HH_MM) %>" 
				cssClass="<%=colorRow %>"
			/>
			<liferay-ui:search-container-column-text 
				name="With"
				value="<%= withDesc.toString() %>"
				cssClass="<%=colorRow %>"
			/>
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</div>

<style>
.earlyApps .rowColorBlue {
	background-color: #62B1FF !important;
    color: #fff;
}
.earlyApps .rowColorGrey {
	background-color: #666 !important;
    color: #aaa;
}

.earlyApps .rowColorBankAndBKBlue {
	background-color: #62B1FF !important;
    color: #fff;
}
.earlyApps .rowBKYellow {
	background-color: #ffffcc !important;
}
.earlyApps .rowTextItalicColorGrey {
    color: #aaa;
    font-style: italic;
}
.earlyApps .rowTextItalic {
    font-style: italic;
}
</style>