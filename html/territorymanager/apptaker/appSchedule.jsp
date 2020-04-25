<%@page import="com.rxtro.core.model.TeamModel"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="java.util.Map"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.rxtro.core.util.ScheduleUtil"%>
<%@page import="com.rxtro.core.model.MedicalStaff"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@include file="/html/territorymanager/init.jsp" %>

<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="10" />
</liferay-util:include>

<%@include file="/html/territorymanager/territory/territoryMenu.jsp" %>

<%
DrugRepModel currentRep = DrugRepUtil.buildByUser(themeDisplay.getUser());
TeamModel team = currentRep.getTeam();
Map<Long, Boolean> drugRepIds = DrugRepUtil.getDrugRepIdsByCompanyAsMap(currentRep.getTeam().getCompanyId());

PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/territorymanager/apptaker/appSchedule.jsp");

Long appIdToBeSwapped = (Long) session.getAttribute("appIdToBeSwapped");
Map<Long,String> assistance = (Map<Long,String>) session.getAttribute("assistance");

%>

<div class="appSchedule" id="appSchedule">
	<liferay-ui:search-container curParam="cur2" delta="30" emptyResultsMessage="No appointments" iteratorURL="<%= iteratorURL %>" >
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
			String type = app.getType().getLabel();
			Long idTarget;
			if (app.isIndividual()) {
				type = type + " ( "+app.getAttendants().get(0).getFullName()+" )";
			}
			String colorRow = "";
			String drugRepName = "";
			boolean canViewStatistics = true;
			
			if (app.getDrugRepId() != null) { // IS APP TAKEN
				if (app.getDrugRepId().equals(currentRep.getId())) { // CURRENT
					colorRow = "rowBKYellow";
					drugRepName = "";
				} else if (team.isPremium()) { // PREMIUM
					if (drugRepIds.containsKey(app.getDrugRepId())) {
						colorRow = "rowColorBankAndBKBlue";
						drugRepName = app.getDrugRep().getFullName() + " - " + app.getDrugRep().getTeam().getName();
					} else {
						colorRow = "rowTextItalicColorGrey";
						drugRepName = "Other Representative Booked in";
						canViewStatistics = false;
					}
				} else {
					colorRow = "rowTextItalicColorGrey";
					drugRepName = "Other Representative Booked in";
					canViewStatistics = false;
				}
			} else {
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
			
			if (team.isPremium() && !app.isIndividual() && canViewStatistics) {
				withDesc.append("<br>");
				if (!assistance.containsKey(app.getScheduleId())) {
					String desc = ScheduleUtil.getAttendantsStatisticsByScheduleId(app.getScheduleId());
					assistance.put(app.getScheduleId(), desc);
				}
				withDesc.append(assistance.get(app.getScheduleId()));
			}			
			
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
			<%
			if (!app.isBlockOutDate()) {
				if (appIdToBeSwapped == null || appIdToBeSwapped == 0) {%>
					<liferay-ui:search-container-column-jsp 
						align="right" 
						path="/html/territorymanager/apptaker/appTakeScheduleAction.jsp" 
						cssClass="<%=colorRow %>"
						/>
				<%} else { %>
					<liferay-ui:search-container-row-parameter name="currentRepId" value="<%=currentRep.getId() %>" />
					<liferay-ui:search-container-row-parameter name="appIdToBeSwapped" value="<%=appIdToBeSwapped %>" />
					<liferay-ui:search-container-column-jsp 
						align="right" 
						path="/html/territorymanager/apptaker/appSwapScheduleAction.jsp" 
						cssClass="<%=colorRow %>"
						/>
				<%
				}
			} else { %>
				<liferay-ui:search-container-column-text 
				name=""
				value=""
				cssClass="<%=colorRow %>"
			/>
			<%} %>
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</div>

<style>
.appSchedule .rowColorBankAndBKBlue {
	background-color: #62B1FF !important;
    color: #fff;
}
.appSchedule .rowBKYellow {
	background-color: #ffffcc !important;
}
.appSchedule .rowTextItalicColorGrey {
    color: #aaa;
    font-style: italic;
}
.appSchedule .rowTextItalic {
    font-style: italic;
}


</style>
