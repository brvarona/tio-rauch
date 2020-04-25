<%@page import="com.rxtro.core.common.utils.FormatDateUtil"%>
<%@page import="com.rxtro.core.util.SurgeryUtil"%>
<%@page import="com.rxtro.core.model.SurgeryModel"%>
<%@ include file="/html/surgerymanager/init.jsp" %>
<%@include file="/html/territorymanager/config.jsp" %>


<%
if ((permissionChecker.isOmniadmin() || isTestEnv)) {
%>
	<div class="clinicTimeBox">
		${surgeryName}: <span class="time">${surgeryTime}</span>
	</div>
<% } %>