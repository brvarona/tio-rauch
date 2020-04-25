<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
<%@include file="/html/drugrepmanager/init.jsp" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	DrugRepModel drugRep = (DrugRepModel) row.getObject();
%>

<liferay-ui:icon-menu>
	<portlet:actionURL name="assignDrugRep" var="assignDrugRepURL">
		<portlet:param name="drugRepId" value="<%= drugRep.getId().toString() %>"></portlet:param>
	</portlet:actionURL>
	<liferay-ui:icon image="join" message="Assign to me" url="<%= assignDrugRepURL.toString() %>" />
</liferay-ui:icon-menu>