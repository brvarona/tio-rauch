<%@page import="java.util.ArrayList"%>
<%@page import="com.rxtro.core.model.TerritoryIndividualModel"%>
<%@page import="com.rxtro.core.util.enums.TerritoryType"%>
<%@page import="com.rxtro.core.util.AppUtil"%>
<%@page import="com.rxtro.core.model.TerritoryModel"%>
<%@include file="/html/territorymanager/init.jsp" %>
<%@include file="/html/territorymanager/global.jsp" %>

<%
PortletURL iteratorURL = renderResponse.createRenderURL();
iteratorURL.setParameter("jspPage", "/html/territorymanager/appointments/myAppoiments.jsp");
List<TerritoryModel> territories = drugRep.getTargetTerritoriesWithoutApps();
%>

<c:if test="<%=!territories.isEmpty() %>">
	<h3>Target Customers to Reappoint</h3>
	<div class="territories" id="territoryListBoxId">
		<liferay-ui:search-container curParam="cur4" delta="10" emptyResultsMessage="Your territory is empty" iteratorURL="<%= iteratorURL %>">
			<liferay-ui:search-container-results>
				<%
					
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
				%>
				<liferay-ui:search-container-column-text 
					name="Who" 
					value="<%= withDesc.toString() %>" 
				/>
				<liferay-ui:search-container-row-parameter name="drugRepId" value="<%=drugRep.getId() %>" />
				<liferay-ui:search-container-column-jsp 
					align="right" 
					path="/html/territorymanager/territory/drugRepTerritoryActions.jsp"
					/>
			</liferay-ui:search-container-row>
			<liferay-ui:search-iterator />
		</liferay-ui:search-container>
	</div>
</c:if>

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
</style>