<%@page import="com.rxtro.core.model.TerritoryIndividualModel"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.model.TerritoryModel"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoValue"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoValueLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoColumnLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoColumn"%>
<%@include file="/html/territorymanager/init.jsp" %>
<%@include file="/html/territorymanager/global.jsp" %>

<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/territorymanager/territory/drugRepTerritory.jsp");

%>

<div class="territories" id="territories">
	<liferay-ui:search-container curParam="cur1" delta="10" emptyResultsMessage="Your territory is empty" iteratorURL="<%= iteratorURL %>">
		<liferay-ui:search-container-results>
			<%
				List<TerritoryModel> territories = drugRep.getTerritories();
				results = ListUtil.subList(territories, searchContainer.getStart(), searchContainer.getEnd());
				total = territories.size();
				pageContext.setAttribute("results", results);
				pageContext.setAttribute("total", total);
			%>
	
		</liferay-ui:search-container-results>
		<liferay-ui:search-container-row
			className="com.rxtro.core.model.TerritoryModel"
			keyProperty="id"
			modelVar="territory">
			
			<%
			
			Integer answerResume = 0;
			String dnsrDropIn = "";


			ExpandoColumn appForDrugRepsColumn = ExpandoColumnLocalServiceUtil.getColumn(167708, "accept-apps-with-pharma-reps");
			ExpandoValue appForDrugRepsValue = ExpandoValueLocalServiceUtil.getValue(appForDrugRepsColumn.getTableId(), appForDrugRepsColumn.getColumnId(), territory.getSurgery().getId());
			if (appForDrugRepsValue != null) {
				if (appForDrugRepsValue.getData().contains("1 - ")) {
					answerResume = 1;
				} else if (appForDrugRepsValue.getData().contains("3 - ")) {
					answerResume = 3;
				}
			}

			if (answerResume > 0) {
				ExpandoColumn appForAlliedHealthColumn = ExpandoColumnLocalServiceUtil.getColumn(167708, "accept-apps-with-rest");
				ExpandoValue appForAlliedHealthValue = ExpandoValueLocalServiceUtil.getValue(appForAlliedHealthColumn.getTableId(), appForAlliedHealthColumn.getColumnId(), territory.getSurgery().getId());
				if (appForAlliedHealthValue != null) {
					if (answerResume == 1 && appForAlliedHealthValue.getData().contains("1 - ")) {
						answerResume = 0;
						dnsrDropIn = "Contact practice to make an appointment -- " + territory.getSurgery().getPhone();
					} 
				}
			}
			
			if (territory.getSurgery().isDNSR()) {
				dnsrDropIn = "DNSR (No appointments made avail.)";
			} else if (territory.getSurgery().isDropIn()) {
				dnsrDropIn = "Drop in (No appointments made avail.)";
			}
			
			Long nextApp = AppUtil.getNextAppIdByDrugRepAndTerritory(territory.getDrugRep().getId(), territory.getId());
			
			String colorRow = "";
			if (nextApp == null && dnsrDropIn == "") {
				colorRow = "rowColorRed";
			} else if (dnsrDropIn == "") {
				colorRow = "";
			} else {
				colorRow = "rowTextItalicColorGrey";
			}
			
			StringBuilder withDesc = new StringBuilder();
			withDesc.append("(");
			withDesc.append(territory.getSurgery().getAddress().getCity());
			withDesc.append("), ");
			withDesc.append(territory.getSurgery().getName());
			if (territory.isIndividual()) {
				withDesc.append(" - ");
				if (((TerritoryIndividualModel) territory).getMedicalStaff() != null) {
					withDesc.append(((TerritoryIndividualModel) territory).getMedicalStaff().getFullName());
				} else {
					withDesc.append("No Attendant");
				}
			}
			withDesc.append(", ");
			withDesc.append(territory.getSurgery().getAddress().getStreet1());
			withDesc.append(" ");
			withDesc.append(territory.getSurgery().getAddress().getStreet2());
			withDesc.append(" ");
			withDesc.append(territory.getSurgery().getAddress().getStreet3());
			
			if (dnsrDropIn != "") {
				withDesc.append(" - " + dnsrDropIn);
			}
			
			%> 
     		<liferay-ui:search-container-column-text  
				name="Who"  
				value="<%= withDesc.toString() %>"  
				cssClass="<%=colorRow %>" 
			/>
			<liferay-ui:search-container-row-parameter name="drugRepId" value="<%=drugRep.getId() %>" />
			<liferay-ui:search-container-row-parameter name="nextApp" value="<%=nextApp %>" />
			<liferay-ui:search-container-column-jsp 
				align="right" 
				path="/html/territorymanager/territory/drugRepTerritoryActions.jsp"
				cssClass="<%=colorRow %>"
				/>
		</liferay-ui:search-container-row>
		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
</div>

<style>
.territories .rowColorYellow {
	background-color: #ffffcc !important;
}

.territories .rowColorRed {
	background-color: #ffbbbb !important;
}

.territories .rowColorGreen {
	background-color: #ccff99 !important;
}
.territories .rowTextItalicColorGrey {
    color: #aaa;
    font-style: italic;
}
</style>