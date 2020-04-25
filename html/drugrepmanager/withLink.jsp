<%@page import="com.rxtro.core.model.AppModel"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="com.liferay.portal.kernel.dao.search.ResultRow"%>
<%@include file="/html/drugrepmanager/init.jsp" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	AppModel app = (AppModel) row.getObject();
	
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
	
	String surgeryId = app.getSurgeryId().toString();
	String individualId = null;
	String companyId = app.getDrugRep().getTeam().getCompanyId().toString();
	if (app.isIndividual()) {
		individualId = app.getAttendants().get(0).getId().toString();
	} 
%>

<liferay-ui:icon-menu>
	<portlet:renderURL var="viewOtherAppsURL">
		<portlet:param name="jspPage" value="/html/drugrepmanager/otherApps.jsp" />
		<portlet:param name="surgeryId" value="<%=surgeryId %>" />
		<portlet:param name="individualId" value="<%=individualId %>" />
		<portlet:param name="companyId" value="<%=companyId %>" />
	</portlet:renderURL>
	<liferay-ui:icon image="view" message="<%=withDesc.toString() %>" url="<%=viewOtherAppsURL.toString() %>" />
</liferay-ui:icon-menu>