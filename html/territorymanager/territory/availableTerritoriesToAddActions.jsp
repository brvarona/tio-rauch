<%@page import="com.liferay.portal.service.OrganizationLocalServiceUtil"%>
<%@page import="com.liferay.portal.model.Organization"%>
<%@page import="com.rxtro.core.util.PracticeInstructionsUtil"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoValueLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoValue"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoColumn"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoColumnLocalServiceUtil"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@page import="com.segmax.drugrep.service.Drug_Representative_BlockedLocalServiceUtil"%>
<%@page import="com.segmax.drugrep.model.Drug_Representative_Blocked"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.rxtro.core.model.view.AvailableTerritoriesToAddView"%>
<%@page import="com.liferay.portal.kernel.dao.search.ResultRow"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@ include file="/html/territorymanager/init.jsp" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
AvailableTerritoriesToAddView territory = (AvailableTerritoriesToAddView) row.getObject();
String addLnkTitle = territory.getAddLinkTitle();
DrugRepModel drugRep = (DrugRepModel) row.getParameter("drugRep");

Drug_Representative_Blocked drugRepBlocked = Drug_Representative_BlockedLocalServiceUtil.getDrugRepresentativeBlocked(territory.getSurgeryId(), drugRep.getId());

String addTerritoryLinkId = "addTerritory" + territory.getSurgeryId().toString();
if (TerritoryType.INDIVIDUAL.equals(territory.getType())) {
	addTerritoryLinkId = "addTerritory" + territory.getSurgeryId().toString()+territory.getId().toString();
}

Integer answerResume = 0;
Boolean showAction = true;
String buttonLabel = "";

if (drugRep.getTerritoriesAsMap().containsKey(territory.getKey())) {
	showAction = false;
	buttonLabel = "Added";
} else if (drugRepBlocked != null) {
	showAction = false;
	buttonLabel = "Blocked";
} else {
	Organization org = OrganizationLocalServiceUtil.getOrganization(territory.getSurgeryId());
	Integer answerResume1 = PracticeInstructionsUtil.getAppForDrugRepsResponse(org);
	Integer answerResume2 = PracticeInstructionsUtil.getAppForAlliedHealthResponse(org);
	Integer answerResume3 = PracticeInstructionsUtil.getNoAppsValueResponse(org);
	
	if (answerResume1.equals(PracticeInstructionsUtil.YES_PRACTICE_DIRECTLY) 
			&& answerResume2.equals(PracticeInstructionsUtil.YES_PRACTICE_DIRECTLY)) {
		buttonLabel = "Contact Practice / ";
	}
	
	if (answerResume1 == PracticeInstructionsUtil.NO_FOR_REPS 
		&& answerResume2 == PracticeInstructionsUtil.NO_FOR_SPECIALISTS) {
		if (answerResume3 == PracticeInstructionsUtil.YES_CHECK_STARTED_PACK_ONLY) {
			buttonLabel = "DNSR / ";
		} else {
			buttonLabel = "Drop In / ";
		}
	}
}
%>

<% if (!showAction) { %>
	<span class="bockedValue"><%=buttonLabel %></span>
<% } else { 
	buttonLabel = buttonLabel + addLnkTitle;
%>
	<liferay-ui:icon-menu>
		<liferay-ui:icon id="<%= addTerritoryLinkId %>" image="add" message="<%=buttonLabel %>" url="javascript:;" />
		<portlet:resourceURL id="addTerritory" var="addTerritoryURL" />
		<script type="text/javascript">
			var showAppReviewButton = document.getElementById('<portlet:namespace /><%= addTerritoryLinkId %>');
			addEvent('click', showAppReviewButton, function() {
				addTerritory('<%= addTerritoryURL.toString() %>', '<%=territory.getId().toString() %>', '<%=territory.getSurgeryId().toString() %>' , '<%=drugRep.getId().toString() %>', '<%=territory.getType().getName() %>', '<portlet:namespace /><%= addTerritoryLinkId %>');
			});
		</script>
	</liferay-ui:icon-menu>
<% } %>