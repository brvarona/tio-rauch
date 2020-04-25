<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@ include file="/html/findrepresentatives/init.jsp" %>

<%
ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
DrugRepModel drugRepresentative = (DrugRepModel) row.getObject();
Boolean isBlocked = (Boolean) row.getParameter("isBlocked");
Long surgeryId = (Long) row.getParameter("surgeryId");

String showDrugRepresentativeInfoId = "showDrugRepresentativeInfoId" + String.valueOf(drugRepresentative.getId());
String blockDrugRepButtonId = "blockDrugRepButtonId" + row.getPos();
String unblockDrugRepButtonId = "unblockDrugRepButtonId" + row.getPos();

String blockDisplay = isBlocked ? "hidden" : "";
String unblockDisplay = !isBlocked ? "hidden" : "";

%>

<liferay-ui:icon-menu>
	<liferay-ui:icon cssClass="<%=blockDisplay %>" id="<%= blockDrugRepButtonId %>" image="deactivate" message="Block" url="javascript:;" />
	<liferay-ui:icon cssClass="<%=unblockDisplay %>" id="<%= unblockDrugRepButtonId %>" image="deactivate" message="Unblock" url="javascript:;" />
</liferay-ui:icon-menu>

<portlet:resourceURL id="blockDrugRep" var="blockDrugRepURL" />
<portlet:resourceURL id="showBlockDrugRepForm" var="showBlockDrugRepFormURL" />
<portlet:resourceURL id="unblockDrugRrep" var="unblockDrugRrepURL" />

<script>
	var blockDrugRepButton = document.getElementById('<portlet:namespace /><%= blockDrugRepButtonId %>');
	addEvent('click', blockDrugRepButton, function() {
		showBlockDrugRepForm('<%= showBlockDrugRepFormURL.toString() %>', '<%=blockDrugRepURL.toString()%>', '<%= drugRepresentative.getId() %>', '<%=surgeryId.toString() %>', '<%=drugRepresentative.getFullName() %>', 'DrugRepButtonId<%=row.getPos() %>');
	});
	
	var unblockDrugRepButton = document.getElementById('<portlet:namespace /><%= unblockDrugRepButtonId %>');
	addEvent('click', unblockDrugRepButton, function() {
		unblockDrugRep('<%=unblockDrugRrepURL.toString()%>',  '<%=surgeryId.toString() %>', '<%= drugRepresentative.getId() %>', '<%=drugRepresentative.getFullName() %>', 'DrugRepButtonId<%=row.getPos() %>');
	});
	
</script>
