<%@page import="com.rxtro.core.model.NurseModel"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	NurseModel nurse = (NurseModel) row.getObject();
%>
<liferay-ui:icon-menu>
	<portlet:actionURL name="removeNurseFromSurgery" var="removeNurseFromSurgeryURL">
		<portlet:param name="nurseId" value="<%= String.valueOf(nurse.getId()) %>"></portlet:param>
	</portlet:actionURL>
	<liferay-ui:icon image="delete" message="Remove from clinic" url="<%= removeNurseFromSurgeryURL.toString() %>" />
</liferay-ui:icon-menu>