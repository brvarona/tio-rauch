
<%@page import="com.rxtro.core.model.BlockOutDateModel"%>
<%@ include file="/html/surgerymanager/init.jsp" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	BlockOutDateModel blockOutDate = (BlockOutDateModel) row.getObject();
	Long blockOutDateId = blockOutDate.getId();
	
	String removeBlockOutDateRowId = "removeBlockOutDateRowId" + row.getRowId();
	
	String removeBlockOutDateLinkId = "removeBlockOutDateLinkId" + row.getRowId();
	
	Long doctorId = 0L;
	if (blockOutDate.isIndividual()) {
		doctorId = blockOutDate.getDoctorId();
	}
%>

<liferay-ui:icon-menu id="<%=removeBlockOutDateRowId %>">
	<portlet:actionURL name="deleteBlockOutDate" var="deleteBlockOutDateURL">
		<portlet:param name="blockOutDateId" value="<%= blockOutDate.getId().toString() %>"></portlet:param>
		<%if (blockOutDate.isIndividual()) { %>
			<portlet:param name="doctorId" value="<%= blockOutDate.getDoctorId().toString() %>"></portlet:param>
		<%} %>
	</portlet:actionURL>
	
	<liferay-ui:icon id="<%=removeBlockOutDateLinkId %>" image="delete" message="Delete" url="javascript:;" />
</liferay-ui:icon-menu>

<portlet:resourceURL id="removeBlockOutDate" var="removeBlockOutDateURL" />
<script>
var removeBlockOutDateButton = document.getElementById('<portlet:namespace /><%=removeBlockOutDateLinkId %>');
if (removeBlockOutDateButton != null) {
	addEvent('click', removeBlockOutDateButton, function() {
		removeBlockOutDate('<%=removeBlockOutDateURL.toString()%>', '<%= blockOutDate.getId().toString() %>', '<%=doctorId.toString()%>', '<portlet:namespace /><%=removeBlockOutDateLinkId %>');
	});
}

</script>