<%@include file="/html/territorymanager/init.jsp" %>
<%@include file="/html/territorymanager/global.jsp" %>

<!-- MENU -->
<liferay-util:include page="/html/territorymanager/menu.jsp" servletContext="<%= this.getServletContext() %>">
	<liferay-util:param name="menuId" value="20" />
</liferay-util:include>

<!-- MESSAGES -->
<liferay-ui:error key="territory-invalid-drugrep-blocked" message="territory-invalid-drugrep-blocked" />

<!-- TERRITORIES FINDER -->
<%@include file="/html/territorymanager/search/territoriesFinder.jsp" %>

<!-- AVAILABLE TERRITORIES TO ADD -->
<%@include file="/html/territorymanager/territory/availableTerritoriesToAdd.jsp" %>

