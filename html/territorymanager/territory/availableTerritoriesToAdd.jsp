<%@page import="com.rxtro.core.model.view.AvailableTerritoriesToAddView"%>
<%@include file="/html/territorymanager/init.jsp" %>

<%
PortletURL itTerritoryURL = renderResponse.createRenderURL();
itTerritoryURL.setParameter("jspPage", "/html/territorymanager/territory/availableTerritories.jsp");
%>


<h3>Available to add to your Territory</h3>
<liferay-ui:search-container curParam="cur8" delta="10" emptyResultsMessage="No Territory to add" iteratorURL="<%= itTerritoryURL %>">
	<liferay-ui:search-container-results>

		<%
			if (session.getAttribute("availableTerritoriesToAdd") != null) {
				List<AvailableTerritoriesToAddView> surgeryList = (List<AvailableTerritoriesToAddView>) session.getAttribute("availableTerritoriesToAdd");
				results = ListUtil.subList(surgeryList, searchContainer.getStart(), searchContainer.getEnd());
				total = surgeryList.size();
				pageContext.setAttribute("results",results);
				pageContext.setAttribute("total",total);
			}
		%>

	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.view.AvailableTerritoriesToAddView"
		keyProperty="id"
		modelVar="territory">

	<liferay-ui:search-container-column-text
		name="Who"
		value="<%=territory.getWho() %>"
		cssClass="<%=territory.getSurgeryStyle() %>"
	/>
	<liferay-ui:search-container-row-parameter name="drugRep" value="<%=drugRep %>" />
	<liferay-ui:search-container-column-jsp
		align="right"
		path="/html/territorymanager/territory/availableTerritoriesToAddActions.jsp"
	/>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>
