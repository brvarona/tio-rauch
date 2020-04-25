<%@page import="com.rxtro.core.rep.management.AdminFactory"%>
<%@page import="com.rxtro.core.rep.management.AdminAbstract"%>
<%@page import="com.rxtro.core.util.ManagerUtil"%>
<%@page import="com.rxtro.core.model.TeamModel"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.portlet.PortletURL" %>
<%@include file="/html/drugrepmanager/init.jsp" %>

<!-- View of the DRs unassigned that are in the DR Manager company -->
<!-- Actions: Assign -->

<%
PortletURL otherDrsIteratorURL = renderResponse.createRenderURL();
otherDrsIteratorURL.setParameter("jspPage", "/html/drugrepmanager/drugRepManagement.jsp");
%>

<h3><%=admin.getSubordinatesTitle() %> not assigned yet</h3>
<liferay-ui:search-container curParam="otherDrsCur" delta="10" emptyResultsMessage="No drug representatives" iteratorURL="<%= otherDrsIteratorURL %>">
	<liferay-ui:search-container-results>

		<%
			List<DrugRepModel> companyDrugReps = admin.getNotSubordinates();
			results = ListUtil.subList(companyDrugReps, searchContainer.getStart(), searchContainer.getEnd());
			total = companyDrugReps.size();
			pageContext.setAttribute("results", results);
			pageContext.setAttribute("total", total);
		%>

	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row
		className="com.rxtro.core.model.DrugRepModel"
		keyProperty="id"
		modelVar="drugRep">
	<liferay-ui:search-container-column-text
		name="Name"
		property="fullName"
	/>
	<liferay-ui:search-container-column-text
		name="Team"
		value="<%=drugRep.getTeam().getName() %>"
	/>
	<liferay-ui:search-container-column-jsp
		align="right"
		path="/html/drugrepmanager/companyDrugRepresentativesActions.jsp"
	/>

	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>