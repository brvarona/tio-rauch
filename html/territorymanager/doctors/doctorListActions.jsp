<%@page import="com.rxtro.core.model.MedicalStaff"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoValue"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoValueLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoColumnLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoColumn"%>
<%@include file="/html/territorymanager/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>

<%@ page import="com.segmax.drugrep.model.Drug_Representative_Blocked" %>
<%@ page import="com.segmax.drugrep.service.Drug_Representative_BlockedLocalServiceUtil" %>

<%
	ResultRow doctorRow = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	String addLnkTitle = (String) doctorRow.getParameter("addLinkTitle");
	DrugRepModel drugRep = (DrugRepModel) doctorRow.getParameter("drugRep");
	MedicalStaff individual = (MedicalStaff) doctorRow.getObject();
	
	Drug_Representative_Blocked drugRepBlocked = Drug_Representative_BlockedLocalServiceUtil.getDrugRepresentativeBlocked(individual.getSurgeryId(), drugRep.getId());
	String addTerritoryLinkId = "addTerritory" + individual.getSurgeryId().toString()+individual.getId().toString();
%>

<%
Integer answerResume = 0;
String buttonLabel = null;
ExpandoColumn appForDrugRepsColumn = ExpandoColumnLocalServiceUtil.getColumn(167708, "accept-apps-with-pharma-reps");
ExpandoValue appForDrugRepsValue = ExpandoValueLocalServiceUtil.getValue(appForDrugRepsColumn.getTableId(), appForDrugRepsColumn.getColumnId(), individual.getSurgeryId());
if (appForDrugRepsValue != null) {
	if (appForDrugRepsValue.getData().contains("1 - ")) {
		answerResume = 1;
	} else if (appForDrugRepsValue.getData().contains("3 - ")) {
		answerResume = 3;
	}
}

if (answerResume > 0) {
	ExpandoColumn appForAlliedHealthColumn = ExpandoColumnLocalServiceUtil.getColumn(167708, "accept-apps-with-rest");
	ExpandoValue appForAlliedHealthValue = ExpandoValueLocalServiceUtil.getValue(appForAlliedHealthColumn.getTableId(), appForAlliedHealthColumn.getColumnId(), individual.getSurgeryId());
	if (appForAlliedHealthValue != null) {
		if (answerResume == 1 && appForAlliedHealthValue.getData().contains("1 - ")) {
			answerResume = 0;
			buttonLabel = "Contact Practice";
		} else if (answerResume == 3 && appForAlliedHealthValue.getData().contains("3 - ")) {
			answerResume = 3;
		}
	}
}

if (answerResume > 0) {
	ExpandoColumn noAppsColumn = ExpandoColumnLocalServiceUtil.getColumn(167708, "see-reps-without-app");
	ExpandoValue noAppsValue = ExpandoValueLocalServiceUtil.getValue(noAppsColumn.getTableId(), noAppsColumn.getColumnId(), individual.getSurgeryId());
	if (noAppsValue != null) {
		if (answerResume == 3 && noAppsValue.getData().contains("1 - ")) {
			answerResume = 0;
			buttonLabel = "Drop-in";
		} else if (answerResume == 3 && noAppsValue.getData().contains("2 - ")) {
			answerResume = 0;
			buttonLabel = "DNSR";
		}
	}
}
%>

<% if (buttonLabel != null) { %>
	<span class="bockedValue"><%=buttonLabel %></span>
<% } else if (drugRep.getTerritoriesAsMap().containsKey(individual.getKey())) { %>
		<span class="bockedValue">Added</span>
<% } else if (drugRepBlocked != null) { %>
		<span class="bockedValue">Blocked</span>
<% } else { %>
	<liferay-ui:icon-menu>
		<liferay-ui:icon id="<%= addTerritoryLinkId %>" image="add" message="<%=addLnkTitle %>" url="javascript:;" />
		<portlet:resourceURL id="addTerritory" var="addTerritoryURL" />
		<script type="text/javascript">
			var showAppReviewButton = document.getElementById('<portlet:namespace /><%= addTerritoryLinkId %>');
			addEvent('click', showAppReviewButton, function() {
				addTerritory('<%= addTerritoryURL.toString() %>', '<%=individual.getId().toString() %>', '<%=individual.getSurgeryId().toString() %>' , '<%=drugRep.getId().toString() %>', '<%=TerritoryType.INDIVIDUAL.getName() %>', '<portlet:namespace /><%= addTerritoryLinkId %>');
			});
		</script>
	</liferay-ui:icon-menu>
<% } %>