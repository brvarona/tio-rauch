<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.DrugRepBlockedInfo"%>
<%@page import="com.rxtro.core.model.DrugRepModel"%>
<%@ include file="/html/findrepresentatives/init.jsp" %>

<%
ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
DrugRepModel drugRep = (DrugRepModel) row.getObject();
Long surgeryId = (Long) row.getParameter("surgeryId");

String linkedTitleId = "linkedTitleId" + drugRep.getId();
String linkedDetailId = "linkedDetailId" + drugRep.getId();
String linkedInfoId = "linkedInfoId" + drugRep.getId();
String linkedTitleClassName = "linkedTitle"; 

String linkedTitle = "Linked";
String linkedDetail = "";
if (drugRep.isBloqued()) {
	DrugRepBlockedInfo blockedInfo = SurgeryUtil.getDrugRepBlockedInfo(surgeryId, drugRep.getId());
	linkedTitle = "Blocked";
	linkedDetail = blockedInfo.getReason();
	linkedTitleClassName = "blockedTitle";
}

%>

<div id="<%=linkedInfoId %>">
	<div class="<%=linkedTitleClassName %>" id=<%=linkedTitleId %>><%=linkedTitle %></div>
	<div class="linkedDetail"  id=<%=linkedDetailId %>><%=linkedDetail %></div>
</div>