<%@page import="com.rxtro.core.util.DrugRepUtil"%>
<%@page import="com.rxtro.core.rep.management.AdminFactory"%>
<%@page import="com.rxtro.core.rep.management.AdminAbstract"%>
<%@page import="com.rxtro.core.util.ManagerUtil"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>

<%@ page import="java.util.List" %>
<%@ page import="javax.portlet.PortletURL" %>
<%@include file="/html/drugrepmanager/init.jsp" %>

<!-- View of the DRs assigned to a DR Manager -->
<!-- Actions: Unassign -->

<%
PortletURL myDrsIteratorURL = renderResponse.createRenderURL();
myDrsIteratorURL.setParameter("jspPage", "/html/drugrepmanager/drugRepManagement.jsp");
%>

<h3>My <%=admin.getSubordinatesTitle() %></h3>
<liferay-ui:search-container curParam="myDrsCur" delta="10" emptyResultsMessage="You do not have drug representatives" iteratorURL="<%= myDrsIteratorURL %>">
	<liferay-ui:search-container-results>

		<%
			List<DrugRepModel> myDrugReps = admin.getSubordinates();
			results = ListUtil.subList(myDrugReps, searchContainer.getStart(), searchContainer.getEnd());
			total = myDrugReps.size();

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
		path="/html/drugrepmanager/myDrugRepresentativesActions.jsp"
	/>

	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator />
</liferay-ui:search-container>