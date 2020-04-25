<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@ page import="com.segmax.drugrep.model.Whish_Visit_List" %>
<%@ page import="com.segmax.drugrep.service.Whish_Visit_ListLocalServiceUtil" %>

<%@ include file="/html/visitormanager/init.jsp" %>

<%
ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
DrugRepModel drugRepresentative = (DrugRepModel) row.getObject();
Boolean isBlocked = (Boolean) row.getParameter("isBlocked");
String repTerm = (String) row.getParameter("repTerm");
String compTerm = (String) row.getParameter("compTerm");
Long surgeryId = (Long) row.getParameter("surgeryId");
Long companyId = (Long) row.getParameter("companyId");

String showDrugRepresentativeInfoId = "showDrugRepresentativeInfoId" + String.valueOf(drugRepresentative.getId());
String showBlockDrugRepFormId = "showBlockDrugRepFormId" + String.valueOf(drugRepresentative.getId());
%>

<portlet:actionURL name="unblockDrugRrepresentative" var="unblockDrugRrepresentativeURL">
	<portlet:param name="drugRepresentativeId" value="<%= String.valueOf(drugRepresentative.getId()) %>"></portlet:param>
	<portlet:param name="surgeryId" value="<%=surgeryId.toString() %>"></portlet:param>
	<portlet:param name="companyId" value="<%=companyId.toString() %>"></portlet:param>
	<portlet:param name="compTerm" value="<%=compTerm %>"></portlet:param>
	<portlet:param name="repTerm" value="<%=repTerm %>"></portlet:param>
</portlet:actionURL>

<%
String callDrugUnblockJS = "javascript:excecuteWithConfirm(\"" + unblockDrugRrepresentativeURL.toString() + "\",\"Are you sure you wish to unblock " + drugRepresentative.getFirstName() + " " + drugRepresentative.getLastName() + " ? \")";
%>

<liferay-ui:icon-menu>
	<liferay-ui:icon id="<%= showDrugRepresentativeInfoId %>" image="page" message="View Info" url="javascript:;" />
	<c:if test="<%=!isBlocked%>">
		<liferay-ui:icon id="<%= showBlockDrugRepFormId %>" image="deactivate" message="Block" url="javascript:;" />
	</c:if>
	<c:if test="<%=isBlocked%>">
		<liferay-ui:icon image="deactivate" message="Unblock" url="<%= callDrugUnblockJS %>" />
	</c:if>
</liferay-ui:icon-menu>

<portlet:resourceURL id="showDrugRepresentativeInfo" var="showDrugRepresentativeInfoURL" />
<portlet:resourceURL id="showBlockDrugRepForm" var="showBlockDrugRepFormURL" />
<script>
var showDrugRepresentativeInfoButton = document.getElementById('<portlet:namespace /><%= showDrugRepresentativeInfoId %>');
if (showDrugRepresentativeInfoButton != null) {
	addEvent('click', showDrugRepresentativeInfoButton, function() {
		showDrugRepresentativeInfo('<%=drugRepresentative.getId() %>', '<%= showDrugRepresentativeInfoURL.toString() %>', "<%=drugRepresentative.getFullName() %>");
	});
}
</script>
<c:if test="<%=!isBlocked%>">
	<script>
	var showBlockDrugRepFormButton = document.getElementById('<portlet:namespace /><%= showBlockDrugRepFormId %>');
	addEvent('click', showBlockDrugRepFormButton, function() {
		showBlockDrugRepForm('<%= showBlockDrugRepFormURL.toString() %>', '<%= drugRepresentative.getId() %>', '<%=surgeryId.toString() %>',
				'<%=companyId.toString() %>', '<%=compTerm  %>', '<%=repTerm  %>', "<%=drugRepresentative.getFullName() %>");
	});
	</script>
</c:if>
